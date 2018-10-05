## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: OFF >>>

# [[[ HEADER ]]]
package RPerl::Compiler;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.039_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 10: allow complex processing with open filehandle

# [[[ INCLUDES ]]]
use RPerl::Parser;
use RPerl::Generator;
use File::Temp qw(tempfile);
use File::Basename;
use English qw(-no_match_vars);    # for $OSNAME; why isn't this included from 'require RPerl::Config', which is included from 'use RPerl' above?
use IPC::Cmd qw(can_run);          # to check for `perltidy` and `astyle`
use List::MoreUtils qw(uniq);
use File::Spec;
use Config;
use Config qw(config_re);
#use IPC::Open3; ## 93r
#use IO::Select; ## 93r
use IPC::Run3 qw(run3);
use Cwd;
use File::Copy;  # for move()
use Alien::astyle;
use Env qw(@PATH);
unshift @PATH, Alien::astyle->bin_dir();

#our string_arrayref_hashref_hashref $filename_suffixes_supported = {
our hashref_hashref $filename_suffixes_supported = {
    INPUT_SOURCE  => { PL  => ['.pl'],  PM => ['.pm'] },
    OUTPUT_SOURCE => { CPP => ['.cpp'], H  => ['.h'], PMC => ['.pmc'], OPENMP_CPP => ['.openmp.cpp'] },
    OUTPUT_BINARY => { O   => ['.o'],   A  => ['.a'], SO => ['.so'], EXE => [ q{}, '.exe' ], OPENMP_EXE => [ '.openmp', '.openmp.exe' ] }

        # NEED ANSWER: what are the correct Windows file extensions?
        #    OUTPUT_BINARY => { O => ['.o', '.lib'], A => ['.a', '.lib'], SO => ['.so', '.dll'], EXE => [q{}, '.exe'], OPENMP_EXE => ['.openmp', '.openmp.exe']}
};

# [[[ SUBROUTINES ]]]

sub find_parents {
    { my string_arrayref $RETURN_TYPE };
    ( my string $file_name, my boolean $find_grandparents_recurse, my string_hashref $modes ) = @ARG;
    RPerl::diag( 'in Compiler::find_parents(), received $file_name = ' . $file_name . "\n" );

    # trim unnecessary (and possibly problematic) @INC & absolute & current-directory paths from input file name
    $file_name = post_processor__INC_paths_delete($file_name, 1, 0);  # $leading_slash_delete = 1, $leading_lib_delete = 0
    $file_name = post_processor__absolute_path_delete($file_name);
    $file_name = post_processor__current_directory_path_delete($file_name);
    RPerl::diag( 'in Compiler::find_parents(), have possibly-trimmed $file_name = ' . $file_name . "\n" );

    my string_arrayref $parents = [];

    if ( not -f $file_name ) {
        die 'ERROR ECOCOPA00, COMPILER, FIND PARENTS: File not found, ' . q{'} . $file_name . q{'} . ', dying' . "\n";
    }

    open my filehandleref $FILE_HANDLE, '<', $file_name
        or die 'ERROR ECOCOPA01, COMPILER, FIND PARENTS: Cannot open file ' . q{'} . $file_name . q{'} . ' for reading, ' . $OS_ERROR . ', dying' . "\n";

    # read in input file, match on 'use' includes for parents
    my string $file_line;
    my string $top_level_package_name = undef;
    my boolean $use_rperl = 0;

    # NEED FIX: do not make recursive calls until after closing file, to avoid
    # ERROR ECOCOPA01, COMPILER, FIND PARENTS: Cannot open file Foo/Bar.pm for reading, Too many open files, dying
    while ( $file_line = <$FILE_HANDLE> ) {
#        RPerl::diag('in Compiler::find_parents(), top of while loop, have $file_line = ' . $file_line . "\n");

        if ( $file_line =~ /^\s*package\s+[\w:]+\s*;\s*$/xms ) {
            if ( not defined $top_level_package_name ) {
                $top_level_package_name = $file_line;
                $top_level_package_name =~ s/^\s*package\s+([\w:]+)\s*;\s*$/$1/gxms;
            }
            # DEV NOTE: for monolithic modules (more than one package), we only find parents of the first package, to avoid incorrect parent lists & infinite recursion
            else {
                last;
            }
        }

        if ( $file_line =~ /^\s*use\s+[\w:]+/xms ) {
#            RPerl::diag('in Compiler::find_parents(), found use line, have $file_line = ' . $file_line . "\n");
            if (( $file_line =~ /use\s+RPerl\s*;/ ) or 
                ( $file_line =~ /use\s+RPerl::AfterSubclass\s*;/ )) {
                $use_rperl = 1;
                next;
            }
            elsif ( $file_line =~ /use\s+lib/ ) {
                die
                    q{ERROR ECOCOPA02, COMPILER, FIND PARENTS: 'use lib...' not currently supported, please set @INC using the PERL5LIB environment variable, file }
                    . q{'}
                    . $file_name . q{'}
                    . ', dying' . "\n";
            }
            elsif ( $file_line !~ /use\s+parent/ )
            {
                # safely ignore these not-parent uses
                next;
            }

            # 'use RPerl;' must appear before any other 'use Foo;' statements, or else this is not a valid RPerl input file and we return empty deps
            if (not $use_rperl) {
                last; 
            }

            my string $package_file_name_included;
            my string $package_name = $file_line;
            # remove everything except the package name
            $package_name =~ s/^(\s*)//gxms;  # strip leading whitespace
            substr $package_name, 0, 14, q{};  # strip leading 'use parent qw('
            $package_name =~ s/([\w:]+)(.*)$/$1/gxms;  # strip trailing everything
#            RPerl::diag('in Compiler::find_parents(), have $package_name = ' . $package_name . "\n\n");

            # safely skip base class for no parent inheritance
            if ($package_name eq 'RPerl::CompileUnit::Module::Class') {
                next;
            }

            my string $package_file_name = $package_name;
            $package_file_name =~ s/::/\//gxms;    # replace double-colon :: scope delineator with forward-slash / directory delineator
            $package_file_name .= '.pm';

            # find specific included dependency file in @INC
            # DEV NOTE, CORRELATION #rp055: handle removal of current directory & all @INC directories, so as not to hard-code system-specific dirs in #include statements
            foreach my string $INC_directory (File::Spec->catpath( '', getcwd, 'lib' ), @INC) {
#                RPerl::diag( 'in Compiler::find_parents(), top of @INC foreach loop, have $INC_directory = ' . $INC_directory . "\n" );
                $package_file_name_included = File::Spec->catpath( '', $INC_directory, $package_file_name );
#                RPerl::diag( 'in Compiler::find_parents(), inside @INC foreach loop, have $package_file_name_included = ' . $package_file_name_included . "\n" );
                if (-e $package_file_name_included) {
#                    RPerl::diag( 'in Compiler::find_parents(), inside @INC foreach loop, have EXISTING $package_file_name_included = ' . $package_file_name_included . "\n" );
                    last;
                }
                else {
                    $package_file_name_included = q{};
                }
            }
            if ($package_file_name_included eq q{}) {
                die 'ERROR ECOCOPA04, COMPILER, FIND PARENTS: Failed to find package file ', q{'}, $package_file_name, q{'},
                    ' in @INC, included from file ', q{'}, $file_name, q{'}, ', dying', "\n";
            }

            RPerl::diag( 'in Compiler::find_parents(), have $package_file_name_included = ' . $package_file_name_included . "\n" );

            # trim unnecessary (and possibly problematic) @INC & absolute & current-directory paths from input file name
            my string $package_file_name_included_relative = $package_file_name_included;
            $package_file_name_included_relative = post_processor__INC_paths_delete($package_file_name_included_relative, 1, 0);  # $leading_slash_delete = 1, $leading_lib_delete = 0
            $package_file_name_included_relative = post_processor__absolute_path_delete( $package_file_name_included_relative );
            $package_file_name_included_relative = post_processor__current_directory_path_delete( $package_file_name_included_relative );

            RPerl::diag( 'in Compiler::find_parents(), have possibly-trimmed $package_file_name_included_relative = ' . $package_file_name_included_relative . "\n" );

            push @{$parents}, $package_file_name_included_relative;
    
#            RPerl::diag( 'in Compiler::find_parents(), have PRE-SUBDEPS $parents = ' . Dumper($parents) . "\n" );

            if ($find_grandparents_recurse) {
    
                # recursively find grandparents
                my string_arrayref $grandparents = find_parents( $package_file_name_included, $find_grandparents_recurse, $modes );
    
                # discard duplicate parents that now appear in grandparents
                $parents = [ uniq @{$grandparents}, @{$parents} ];
    
#                RPerl::diag( 'in Compiler::find_parents(), have POST-SUBDEPS $parents = ' . Dumper($parents) . "\n" );
            }
        }
    }

    close $FILE_HANDLE
        or die 'ERROR ECOCOPA05, COMPILER, FIND PARENTS: Cannot close file ' . q{'}
        . $file_name . q{'}
        . ' after reading, '
        . $OS_ERROR
        . ', dying' . "\n";

#    RPerl::diag( 'in Compiler::find_parents(), returning $parents = ' . Dumper($parents) . "\n" );
#    RPerl::diag('in Compiler::find_parents(), about to return, have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
#    RPerl::diag('in Compiler::find_parents(), about to return, have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
#    RPerl::diag('in Compiler::find_parents(), about to return, have $modes->{_enable_gsl} = ' . Dumper($modes->{_enable_gsl}) . "\n");
    return $parents;
}

sub find_dependencies {
    { my string_arrayref $RETURN_TYPE };
    ( my string $file_name, my boolean $find_subdependencies_recurse, my string_hashref $modes ) = @ARG;
    RPerl::diag( 'in Compiler::find_dependencies(), received $file_name = ' . $file_name . "\n" );

    # trim unnecessary (and possibly problematic) @INC & absolute & current-directory paths from input file name
    $file_name = post_processor__INC_paths_delete($file_name, 1, 0);  # $leading_slash_delete = 1, $leading_lib_delete = 0
    $file_name = post_processor__absolute_path_delete($file_name);
    $file_name = post_processor__current_directory_path_delete($file_name);
    RPerl::diag( 'in Compiler::find_dependencies(), have possibly-trimmed $file_name = ' . $file_name . "\n" );

    my string_arrayref $dependencies = [];
#    my string_arrayref $pmc_disable_paths = [];  # DISABLE_DYNAMIC_DEPS_ANALYSIS

    if ( not -f $file_name ) {
        die 'ERROR ECOCODE00, COMPILER, FIND DEPENDENCIES: File not found, ' . q{'} . $file_name . q{'} . ', dying' . "\n";
    }

    open my filehandleref $FILE_HANDLE, '<', $file_name
        or die 'ERROR ECOCODE01, COMPILER, FIND DEPENDENCIES: Cannot open file ' . q{'} . $file_name . q{'} . ' for reading, ' . $OS_ERROR . ', dying' . "\n";

    # read in input file, match on 'use' includes for dependencies
    my string $file_line;
    my string $top_level_package_name = undef;
    my boolean $use_rperl = 0;

    # NEED FIX: do not make recursive calls until after closing file, to avoid
    # ERROR ECOCODE01, COMPILER, FIND DEPENDENCIES: Cannot open file Foo/Bar.pm for reading, Too many open files, dying
    while ( $file_line = <$FILE_HANDLE> ) {
#        RPerl::diag('in Compiler::find_dependencies(), top of while loop, have $file_line = ' . $file_line . "\n");

        if ( ( $file_line =~ /^\s*package\s+[\w:]+\s*;\s*$/xms ) and ( not defined $top_level_package_name ) ) {
            # disable top-level PMC file before finding subdependencies
            $top_level_package_name = $file_line;
            $top_level_package_name =~ s/^\s*package\s+([\w:]+)\s*;\s*$/$1/gxms;
=DISABLE_DYNAMIC_DEPS_ANALYSIS
            my string $pmc_disable_path = pmc_disable($top_level_package_name);
            if ($pmc_disable_path eq q{}) {
#               my integer $eval_retval = eval_use_dependencies($top_level_package_name);  # NEED ANSWER: do we need to care about $eval_retval?
                eval_use_dependencies($top_level_package_name);
            }
            else {
                push @{$pmc_disable_paths}, $pmc_disable_path;
            }
=cut
        }

        # DEV NOTE, CORRELATION #rp050: hard-coded list of RPerl files/packages/namespaces
        # these instances of the 'use' keyword are NOT subdependencies of the current file, do not try to compile them 
        if ( $file_line =~ /^\s*use\s+[\w:]+/xms ) {
#            RPerl::diag('in Compiler::find_dependencies(), found use line, have $file_line = ' . $file_line . "\n");
            if (( $file_line =~ /use\s+RPerl\s*;/ ) or 
                ( $file_line =~ /use\s+RPerl::AfterSubclass\s*;/ )) {
                $use_rperl = 1;
                next;
            }
            elsif (   ( $file_line =~ /use\s+strict\s*;/ )
                or ( $file_line =~ /use\s+warnings\s*;/ )
                or ( $file_line =~ /use\s+RPerl::CompileUnit::Module::Class\s*;/ )
                or ( $file_line =~ /use\s+RPerl::Class\s*;/ )
                or ( $file_line =~ /use\s+RPerl::Config\s*;/ )
                or ( $file_line =~ /use\s+RPerl::Exporter.*;/ )
                or ( $file_line =~ /use\s+\w+Perl::Config\s*;/ )    # DEV NOTE, CORRELATION #rp027: RPerl::Config, MathPerl::Config, PhysicsPerl::Config, etc
                or ( $file_line =~ /use\s+perlapinames_generated/ )
                or ( $file_line =~ /use\s+parent/ )
                or ( $file_line =~ /use\s+constant/ )
                or ( $file_line =~ /use\s+overload/ )
                or ( $file_line =~ /use\s+integer/ )
                or ( $file_line =~ /use\s+[0-9]/ )
                )
            {
                # safely ignore these possibly-valid but not-subdependency uses
                next;
            }
            elsif ((defined $top_level_package_name) and ( $file_line =~ /use\s+$top_level_package_name\s*;/ )) {
                # DEV NOTE, CORRELATION #rp042: do not recursively load the same .pm file from within itself
                next;
            }
            # use rperlsse;
            elsif ( $file_line =~ /use\s+rperlsse\s*;/ ) {

#               RPerl::diag('in Compiler::find_dependencies(), found rperlsse line, have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
                if ( ( substr $Config{archname}, 0, 3 ) eq 'arm' ) {
                    die q{ERROR ECOCODE06, COMPILER, FIND DEPENDENCIES: 'use rperlsse;' command found but SSE not supported on ARM architecture, file }
                        . q{'}
                        . $file_name . q{'}
                        . ', dying' . "\n";
                }
                if ( ( not exists $modes->{_enable_sse} ) or ( not defined $modes->{_enable_sse} ) ) {
                    $modes->{_enable_sse} = {};
                }
                $modes->{_enable_sse}->{$file_name} = 1;

#                RPerl::diag('in Compiler::find_dependencies(), after finding rperlsse line, have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
                next;
            }
            # use rperlgmp;
            elsif ( $file_line =~ /use\s+rperlgmp\s*;/ ) {
#                RPerl::diag('in Compiler::find_dependencies(), found rperlgmp line, have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
                if ( ( not exists $modes->{_enable_gmp} ) or ( not defined $modes->{_enable_gmp} ) ) {
                    $modes->{_enable_gmp} = {};
                }
                $modes->{_enable_gmp}->{$file_name} = 1;

#                RPerl::diag('in Compiler::find_dependencies(), after finding rperlgmp line, have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
                next;
            }
            # use rperlgsl;
            elsif ( $file_line =~ /use\s+rperlgsl\s*;/ ) {
#                RPerl::diag('in Compiler::find_dependencies(), found rperlgsl line, have $modes->{_enable_gsl} = ' . Dumper($modes->{_enable_gsl}) . "\n");
                if ( ( not exists $modes->{_enable_gsl} ) or ( not defined $modes->{_enable_gsl} ) ) {
                    $modes->{_enable_gsl} = {};
                }
                $modes->{_enable_gsl}->{$file_name} = 1;

#                RPerl::diag('in Compiler::find_dependencies(), after finding rperlgsl line, have $modes->{_enable_gsl} = ' . Dumper($modes->{_enable_gsl}) . "\n");
                next;
            }
            # use RPerl::Support::MongoDB;
            elsif ( $file_line =~ /use\s+RPerl::Support::MongoDB\s*;/ ) {
#                RPerl::diag('in Compiler::find_dependencies(), found RPerl::Support::MongoDB line, have $modes->{_enable_mongodb} = ' . Dumper($modes->{_enable_mongodb}) . "\n");
                if ( ( not exists $modes->{_enable_mongodb} ) or ( not defined $modes->{_enable_mongodb} ) ) {
                    $modes->{_enable_mongodb} = {};
                }
                $modes->{_enable_mongodb}->{$file_name} = 1;

#                RPerl::diag('in Compiler::find_dependencies(), after finding RPerl::Support::MongoDB line, have $modes->{_enable_mongodb} = ' . Dumper($modes->{_enable_mongodb}) . "\n");
                next;
            }
            elsif ( $file_line =~ /use\s+lib/ ) {
                die
                    q{ERROR ECOCODE02, COMPILER, FIND DEPENDENCIES: 'use lib...' not currently supported, please set @INC using the PERL5LIB environment variable, file }
                    . q{'}
                    . $file_name . q{'}
                    . ', dying' . "\n";
            }

            # 'use RPerl;' or 'use RPerl::AfterSubclass;' must appear before any other 'use Foo;' statements, or else this is not a valid RPerl input file and we return empty deps
            if (not $use_rperl) {
                last; 
            }

            my string $package_file_name_included;
            my string $package_name = $file_line;
            $package_name =~ s/^\s*use\s+([\w:]+)\s*.*\s*;\s*$/$1/gxms;    # remove everything except the package name

            # disable PMC file before finding subdependencies
#            my string $pmc_disable_path = pmc_disable($package_name);  # DISABLE_DYNAMIC_DEPS_ANALYSIS

            my string $package_file_name = $package_name;
            $package_file_name =~ s/::/\//gxms;    # replace double-colon :: scope delineator with forward-slash / directory delineator
            $package_file_name .= '.pm';
            RPerl::diag( 'in Compiler::find_dependencies(), have $package_file_name = ' . $package_file_name . "\n" );

            # find specific included dependency file in either %INC or @INC
=DISABLE_DYNAMIC_DEPS_ANALYSIS
            if ($pmc_disable_path eq q{}) {
                eval_use_dependencies($package_name);
                if ( not exists $INC{$package_file_name} ) {
                    die 'ERROR ECOCODE03, COMPILER, FIND DEPENDENCIES: Failed to find package file ', q{'}, $package_file_name, q{'},
                        ' in %INC, included from file ', q{'}, $file_name, q{'}, ', dying', "\n";
                }
                $package_file_name_included = $INC{$package_file_name};
            }
            else {
=cut

                # DEV NOTE, CORRELATION #rp055: handle removal of current directory & all @INC directories, so as not to hard-code system-specific dirs in #include statements
                foreach my string $INC_directory (File::Spec->catpath( '', getcwd, 'lib' ), @INC) {
                    RPerl::diag( 'in Compiler::find_dependencies(), top of @INC foreach loop, have $INC_directory = ' . $INC_directory . "\n" );
                    $package_file_name_included = File::Spec->catpath( '', $INC_directory, $package_file_name );
                    RPerl::diag( 'in Compiler::find_dependencies(), inside @INC foreach loop, have $package_file_name_included = ' . $package_file_name_included . "\n" );
                    if (-e $package_file_name_included) {
                        RPerl::diag( 'in Compiler::find_dependencies(), inside @INC foreach loop, have EXISTING $package_file_name_included = ' . $package_file_name_included . "\n" );
                        last;
                    }
                    else {
                        $package_file_name_included = q{};
                    }
                }
                if ($package_file_name_included eq q{}) {
                    die 'ERROR ECOCODE04, COMPILER, FIND DEPENDENCIES: Failed to find package file ', q{'}, $package_file_name, q{'},
                        ' in @INC, included from file ', q{'}, $file_name, q{'}, ', dying', "\n";
                }
=DISABLE_DYNAMIC_DEPS_ANALYSIS
                push @{$pmc_disable_paths}, $pmc_disable_path;
            }
=cut

            RPerl::diag( 'in Compiler::find_dependencies(), have $package_file_name_included = ' . $package_file_name_included . "\n" );

            # trim unnecessary (and possibly problematic) @INC & absolute & current-directory paths from input file name
            my string $package_file_name_included_relative = $package_file_name_included;
            $package_file_name_included_relative = post_processor__INC_paths_delete($package_file_name_included_relative, 1, 0);  # $leading_slash_delete = 1, $leading_lib_delete = 0
            $package_file_name_included_relative = post_processor__absolute_path_delete( $package_file_name_included_relative );
            $package_file_name_included_relative = post_processor__current_directory_path_delete( $package_file_name_included_relative );
            push @{$dependencies}, $package_file_name_included_relative;

            RPerl::diag( 'in Compiler::find_dependencies(), have possibly-trimmed $package_file_name_included_relative = ' . $package_file_name_included_relative . "\n" );
#            RPerl::diag( 'in Compiler::find_dependencies(), have PRE-SUBDEPS $dependencies = ' . Dumper($dependencies) . "\n" );

            if ($find_subdependencies_recurse) {
    
                # recursively find subdependencies
                my string_arrayref $subdependencies = find_dependencies( $package_file_name_included, $find_subdependencies_recurse, $modes );
    
                # discard duplicate dependencies that now appear in subdependencies
                $dependencies = [ uniq @{$subdependencies}, @{$dependencies} ];
    
#                RPerl::diag( 'in Compiler::find_dependencies(), have POST-SUBDEPS $dependencies = ' . Dumper($dependencies) . "\n" );
            }
        }
    }

    close $FILE_HANDLE
        or die 'ERROR ECOCODE05, COMPILER, FIND DEPENDENCIES: Cannot close file ' . q{'}
        . $file_name . q{'}
        . ' after reading, '
        . $OS_ERROR
        . ', dying' . "\n";

=DISABLE_DYNAMIC_DEPS_ANALYSIS
    # re-enable all PMC files after finding dependencies
    while (scalar @{$pmc_disable_paths}) {
        pmc_reenable(pop @{$pmc_disable_paths});
    }
=cut

    RPerl::diag( 'in Compiler::find_dependencies(), returning $dependencies = ' . Dumper($dependencies) . "\n" );
#    RPerl::diag('in Compiler::find_dependencies(), about to return, have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
#    RPerl::diag('in Compiler::find_dependencies(), about to return, have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
#    RPerl::diag('in Compiler::find_dependencies(), about to return, have $modes->{_enable_gsl} = ' . Dumper($modes->{_enable_gsl}) . "\n");
    return $dependencies;
}

=DISABLE_DYNAMIC_DEPS_ANALYSIS
# temporarily disable a package's PMC file, if it exists
sub pmc_disable {
    { my string $RETURN_TYPE };
    ( my string $package_name ) = @ARG;
#    RPerl::diag( 'in Compiler::pmc_disable(), received $package_name = ' . $package_name . "\n" );

    my string $pmc_file_path_absolute;
    my string $pmc_file_path_absolute_disabled = q{};
    my string $pmc_file_path_relative = $package_name;
    $pmc_file_path_relative =~ s/::/\//gxms;    # replace double-colon :: scope delineator with forward-slash / directory delineator
    $pmc_file_path_relative .= '.pmc';

    # DEV NOTE, CORRELATION #rp055: handle removal of current directory & all @INC directories, so as not to hard-code system-specific dirs in #include statements
    foreach my string $INC_directory (File::Spec->catpath( '', getcwd, 'lib' ), @INC) {
#        RPerl::diag( 'in Compiler::pmc_disable(), top of foreach loop, have $INC_directory = ' . $INC_directory . "\n" );
        $pmc_file_path_absolute = File::Spec->catpath( '', $INC_directory, $pmc_file_path_relative );
#        RPerl::diag( 'in Compiler::pmc_disable(), inside foreach loop, have $pmc_file_path_absolute = ' . $pmc_file_path_absolute . "\n" );
        if (-e $pmc_file_path_absolute) {
#            RPerl::diag( 'in Compiler::pmc_disable(), inside foreach loop, have EXISTING $pmc_file_path_absolute = ' . $pmc_file_path_absolute . "\n" );
            $pmc_file_path_absolute_disabled = $pmc_file_path_absolute . '.PMC_DISABLED';
            my boolean $move_success = move($pmc_file_path_absolute, $pmc_file_path_absolute_disabled);
            if (not $move_success) {
                die 'ERROR ECOCODE07, COMPILER, PMC DISABLE: Failed to temporarily disable package file ', q{'}, $pmc_file_path_absolute, q{'; }, 
                    $OS_ERROR, ', dying', "\n";
            }
#            RPerl::diag( 'in Compiler::pmc_disable(), DISABLED $pmc_file_path_absolute = ' . $pmc_file_path_absolute . "\n" );
            last;
        }
    }
    return $pmc_file_path_absolute_disabled;
}

# re-enable a package's temporarily-disabled PMC file, if it exists
sub pmc_reenable {
    { my boolean $RETURN_TYPE };
    ( my string $file_name ) = @ARG;
#    RPerl::diag( 'in Compiler::pmc_reenable(), received $file_name = ' . $file_name . "\n" );
    if ((defined $file_name) and ($file_name ne q{})) {
        if ((substr $file_name, -13, 13) ne '.PMC_DISABLED') {
            die 'ERROR ECOCODE08, COMPILER, PMC RE-ENABLE: Temporarily-disabled package file name ', q{'}, $file_name, q{'}, 
            ' does not with .PMC_DISABLED, dying', "\n";
        }
        if (-e $file_name) {
            my string $file_name_original = $file_name;
            substr $file_name_original, -13, 13, q{};  # strip trailing .PMC_DISABLED
            my boolean $move_success = move($file_name, $file_name_original);
            if (not $move_success) {
                die 'ERROR ECOCODE09, COMPILER, PMC RE-ENABLE: Failed to re-enable temporarily-disabled package file ', q{'}, $file_name, q{'; }, 
                    $OS_ERROR, ', dying', "\n";
            }
#            RPerl::diag( 'in Compiler::pmc_disable(), RE-ENABLED $file_name = ' . $file_name . "\n" );
        }
        else {
            die 'ERROR ECOCODE10, COMPILER, PMC RE-ENABLE: Failed to re-enable temporarily-disabled package file ', q{'}, $file_name, q{'; }, 
                ' file does not exist, dying', "\n";
        }
        return 1;
    }
    else {
        return 0;
    }
}

# call RPerl::eval_use() to perform a runtime use on a package, with dependencies-specific warning message
sub eval_use_dependencies {
    { my integer $RETURN_TYPE };
    ( my string $package_name ) = @ARG;
#    RPerl::diag( 'in Compiler::eval_use(), received $package_name = ' . $package_name . "\n" );

    my integer $eval_retval = RPerl::eval_use($package_name, 0);

#    RPerl::diag('in Compiler::find_dependencies(), have POST-EVAL NON-DEP %INC = ' . Dumper(\%INC) . "\n");
    # warn instead of dying on eval error here and below, in order to preserve proper parser errors instead of weird eval errors
    # in RPerl/Test/*/*Bad*.pm and RPerl/Test/*/*bad*.pl
    if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
        RPerl::warning( 'WARNING WCOCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package ' . q{'}
            . $package_name . q{'} . ', fatal error trapped and delayed' . "\n" );
        RPerl::diag( '                                                Trapped the following error message...' . "\n\n" . $EVAL_ERROR . "\n" );
        RPerl::warning("\n");
    }
#    RPerl::diag( 'in Compiler::pmc_disable(), EVAL USED $package_name = ' . $package_name . "\n" );
    return $eval_retval;
}
=cut

# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]

sub rperl_to_rperl__parse_generate {
    { my string_hashref $RETURN_TYPE };
    ( my string $rperl_input_file_name, my string_hashref $rperl_output_file_name_group, my string_hashref $rperl_source_group, my string_hashref $modes ) = @ARG;
    my object $rperl_ast;

#    RPerl::diag( 'in Compiler->rperl_to_rperl__parse_generate(), received $rperl_input_file_name = ' . $rperl_input_file_name . "\n" );
#    RPerl::diag( 'in Compiler->rperl_to_rperl__parse_generate(), received $rperl_output_file_name_group = ' . "\n" . Dumper($rperl_output_file_name_group) . "\n" );
#    RPerl::diag( 'in Compiler->rperl_to_rperl__parse_generate(), received $rperl_source_group = ' . "\n" . Dumper($rperl_source_group) . "\n" );
#    RPerl::diag( 'in Compiler->rperl_to_rperl__parse_generate(), received $modes = ' . "\n" . Dumper($modes) . "\n" );

    # [[[ PARSE RPERL TO AST ]]]

    if (   ( $modes->{compile} eq 'PARSE' )
        or ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' ) )
    {
        $rperl_ast = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);
    }

    # [[[ GENERATE AST TO RPERL ]]]

    if (   ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' ) )
    {
        $rperl_source_group = RPerl::Generator::ast_to_rperl__generate( $rperl_ast, $modes );
    }

    # [[[ SAVE RPERL TO DISK ]]]

    if (   ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'SAVE_DEFERRED' ) )
    {
        save_source_files( $rperl_source_group, $rperl_output_file_name_group, $modes );
    }

    # always return $rperl_source_group to maintain consistent return type,
    # only utilized for GENERATE compile mode during dependencies
    return $rperl_source_group;
}

# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]

sub rperl_to_xsbinary__parse_generate_compile {
    { my string_hashref $RETURN_TYPE };
    ( my string $rperl_input_file_name, my string_hashref $cpp_output_file_name_group, my string_hashref $cpp_source_group, my string_hashref $modes ) = @ARG;
    my object $rperl_ast;

#    RPerl::diag( 'in Compiler->rperl_to_xsbinary__parse_generate_compile(), received $cpp_output_file_name_group = ' . "\n" . Dumper($cpp_output_file_name_group) . "\n" );
#    RPerl::diag( 'in Compiler->rperl_to_xsbinary__parse_generate_compile(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );

    # [[[ PARSE RPERL TO AST ]]]

    if (   ( $modes->{compile} eq 'PARSE' )
        or ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'SUBCOMPILE' ) )
    {
        $rperl_ast = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);
    }

    # [[[ GENERATE AST TO C++ ]]]

    if (   ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'SUBCOMPILE' ) )
    {
        $cpp_source_group = RPerl::Generator::ast_to_cpp__generate( $rperl_ast, $modes );
    }

    # [[[ SAVE C++ TO DISK ]]]

    if (   ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'SAVE_DEFERRED' )
        or ( $modes->{compile} eq 'SUBCOMPILE' )
        or ( $modes->{compile} eq 'SUBCOMPILE_DEFERRED' ) )
    {
        save_source_files( $cpp_source_group, $cpp_output_file_name_group, $modes );
    }

    # [[[ AUTO-PARALLELIZE C++ VIA PLUTO & OPENMP ]]]

    if ( $modes->{parallel} eq 'OPENMP' ) {
        cpp_to_openmp_cpp( $cpp_output_file_name_group, $modes );
    }

    # [[[ SUBCOMPILE C++ TO XS & BINARY ]]]

    if (   ( $modes->{compile} eq 'SUBCOMPILE' )
        or ( $modes->{compile} eq 'SUBCOMPILE_DEFERRED' ) )
    {
        cpp_to_xsbinary__subcompile( $cpp_output_file_name_group, $modes );
    }

    # always return $cpp_source_group to maintain consistent return type,
    # only utilized for GENERATE compile mode during dependencies
    return $cpp_source_group;
}

# generate output file name group(s) based on input file name(s)
sub generate_output_file_names {
    { my hashref_arrayref $RETURN_TYPE };
    ( my string_arrayref $input_file_names, my string_arrayref $output_file_name_prefixes, my integer $input_files_count, my string_hashref $modes ) = @ARG;

#    RPerl::diag('in Compiler::generate_output_file_names(), received $input_file_names = ' . "\n" . Dumper($input_file_names) . "\n");
#    RPerl::diag('in Compiler::generate_output_file_names(), received $output_file_name_prefixes = ' . "\n" . Dumper($output_file_name_prefixes) . "\n");
#    RPerl::diag('in Compiler::generate_output_file_names(), received $input_files_count = ' . $input_files_count . "\n");
#    RPerl::diag('in Compiler::generate_output_file_names(), received $modes = ' . "\n" . Dumper($modes) . "\n" );

    # NEED FIX: add string_hashref_arrayref type
    #    my string_hashref_arrayref $output_file_name_groups = [];
    my hashref_arrayref $output_file_name_groups = [];
    my string $input_file_name;
    my string $input_file_name_path;
    my string $input_file_name_prefix;
    my string $input_file_name_suffix;

    for my $i ( 0 .. ( $input_files_count - 1 ) ) {
        $input_file_name = $input_file_names->[$i];

        $output_file_name_groups->[$i] = {};

        # if output file prefix(es) provided, then use to generate output file name(s)
        if ( defined $output_file_name_prefixes->[$i] ) {
            # explicitly provided option should already be only prefix, but fileparse() to make sure
            ( $input_file_name_prefix, $input_file_name_path, $input_file_name_suffix ) = fileparse( $output_file_name_prefixes->[$i], qr/[.][^.]*/xms );
            if ( $input_file_name_prefix eq q{} ) {
                die "ERROR EAR17: Invalid RPerl source code output file command-line argument specified, dying\n";
            }

            # DEV NOTE: File::Basename::fileparse() wrongly (or at least stupidly) returns path './' intead of empty path '' when there is no leading path present, compensate 
            if ((($input_file_name_path eq './') and ((substr $output_file_name_prefixes->[$i], 0, 2) ne './')) or 
                (($input_file_name_path eq '.\\') and ((substr $output_file_name_prefixes->[$i], 0, 2) ne '.\\'))) {
                $input_file_name_path = q{};
            }
        }

        # if output file prefix(es) not provided, then generate output file name(s) from input file name(s)
        else {
#            RPerl::diag('in Compiler::generate_output_file_names(), no output file prefixes provided, have $input_file_name = ' . $input_file_name . "\n");
            # should not already be only prefix, fileparse() to isolate prefix
            ( $input_file_name_prefix, $input_file_name_path, $input_file_name_suffix ) = fileparse( $input_file_name, qr/[.][^.]*/xms );

            # DEV NOTE: File::Basename::fileparse() wrongly (or at least stupidly) returns path './' intead of empty path '' when there is no leading path present, compensate 
            if ((($input_file_name_path eq './') and ((substr $input_file_name, 0, 2) ne './')) or 
                (($input_file_name_path eq '.\\') and ((substr $input_file_name, 0, 2) ne '.\\'))) {
                $input_file_name_path = q{};
            }
        }

        my string $output_file_name_path_prefix = $input_file_name_path . $input_file_name_prefix;

#        RPerl::diag('in Compiler::generate_output_file_names(), have $input_file_name_path = ' . q{'} . $input_file_name_path . q{'} . "\n" );
#        RPerl::diag('in Compiler::generate_output_file_names(), have $input_file_name_prefix = ' . q{'} . $input_file_name_prefix . q{'} . "\n" );
#        RPerl::diag('in Compiler::generate_output_file_names(), have $input_file_name_suffix = ' . q{'} . $input_file_name_suffix . q{'} . "\n" );
#        RPerl::diag('in Compiler::generate_output_file_names(), have $output_file_name_path_prefix = ' . q{'} . $output_file_name_path_prefix . q{'} . "\n" );

        # *.pl input files may generate *.o, *.a, *.so, *.exe, and/or non-suffix output files
        if ( $input_file_name =~ /[.]pl$/xms ) {
            if ( $modes->{subcompile} eq 'ASSEMBLE' ) {

           # NEED ANSWER: does Micro$oft Windows use *.lib file extension (suffix) for both *.o and *.a assembled object files?
           # but does that only apply when using the M$ VC++ compiler? so does it apply here?
           # apply answer to ARCHIVE mode elsif block immediately below; and also for ASSEMBLE & ARCHIVE blocks in *.pm else block below that;
           # ask similar question for *.so in *NIX vs *.dll in M$, apply to .so elsif blocks below and $filename_suffixes_supported in script/rperl
           #                if ( $OSNAME eq 'MSWin32' ) {
           #                    $output_file_name_groups->[$i]->{LIB} = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{O}->[1];
           #                }
           # *NIX uses *.o file extension (suffix) for assembled object files
           #                else {
                $output_file_name_groups->[$i]->{O} = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{O}->[0];

                #                }
            }

            elsif ( $modes->{subcompile} eq 'ARCHIVE' ) {
                $output_file_name_groups->[$i]->{O}        = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{O}->[0];
                $output_file_name_groups->[$i]->{_O_label} = ' (temporary)';
                $output_file_name_groups->[$i]->{A}        = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{A}->[0];
            }
            elsif ( $modes->{subcompile} eq 'SHARED' ) {
                $output_file_name_groups->[$i]->{SO} = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{SO}->[0];
            }
            elsif (
                   ( $modes->{subcompile} eq 'STATIC' )
                or ( $modes->{subcompile} eq 'DYNAMIC' )
                or (( $modes->{subcompile} eq 'OFF' )
                    and (  ( $modes->{compile} eq 'PARSE' )
                        or ( $modes->{compile} eq 'GENERATE' )
                        or ( $modes->{compile} eq 'SAVE' )
                        or ( $modes->{compile} eq 'SUBCOMPILE' ) )
                )
                )
            {
                # Micro$oft Windows uses *.exe file extension (suffix) for compiled executables
                if ( $OSNAME eq 'MSWin32' ) {
                    if ( $modes->{parallel} eq 'OFF' ) {
                        $output_file_name_groups->[$i]->{EXE} = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{EXE}->[1];
                    }
                    elsif ( $modes->{parallel} eq 'OPENMP' ) {
                        $output_file_name_groups->[$i]->{OPENMP_EXE}
                            = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{OPENMP_EXE}->[1];
                    }
                }

                # traditionally, *NIX has no file extension (suffix) for compiled executables, non-suffix
                else {
                    if ( $modes->{parallel} eq 'OFF' ) {
                        $output_file_name_groups->[$i]->{EXE} = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{EXE}->[0];
                    }
                    elsif ( $modes->{parallel} eq 'OPENMP' ) {
                        $output_file_name_groups->[$i]->{OPENMP_EXE}
                            = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{OPENMP_EXE}->[0];
                    }
                }
            }

            # NEED ANSWER: allow this subroutine to be called even when we return empty results?
            else {
                die "ERROR EAR18: Invalid compile mode '"
                    . $modes->{compile}
                    . "' and/or subcompile mode '"
                    . $modes->{subcompile}
                    . "' command-line arguments specified, dying\n";
            }
        }
        else {    # *.pm input files may generate *.o, *.a, *.so, and/or *.pmc output files
            if ( $modes->{subcompile} eq 'ASSEMBLE' ) {
                $output_file_name_groups->[$i]->{O} = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{O}->[0];
            }
            elsif ( $modes->{subcompile} eq 'ARCHIVE' ) {
                $output_file_name_groups->[$i]->{O}        = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{O}->[0];
                $output_file_name_groups->[$i]->{_O_label} = ' (temporary)';
                $output_file_name_groups->[$i]->{A}        = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{A}->[0];
            }
            elsif ( $modes->{subcompile} eq 'SHARED' ) {
                $output_file_name_groups->[$i]->{SO} = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_BINARY}->{SO}->[0];
            }
            elsif ( $modes->{subcompile} eq 'STATIC' ) {

                # DEV NOTE: correlates to errors EAR* in script/rperl
                die 'ERROR EAR15: Incompatible command-line arguments provided, both --static subcompile mode flag and *.pm Perl module input file, dying'
                    . "\n";
            }
            elsif (
                ( $modes->{subcompile} eq 'DYNAMIC' )
                or (( $modes->{subcompile} eq 'OFF' )
                    and (  ( $modes->{compile} eq 'PARSE' )
                        or ( $modes->{compile} eq 'GENERATE' )
                        or ( $modes->{compile} eq 'SAVE' )
                        or ( $modes->{compile} eq 'SUBCOMPILE' ) )
                )
                )
            {
                $output_file_name_groups->[$i]->{PMC} = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_SOURCE}->{PMC}->[0];
            }

            # NEED ANSWER: allow this subroutine to be called even when we return empty results?
            else {
                die "ERROR EAR18: Invalid compile mode '"
                    . $modes->{compile}
                    . "' and/or subcompile mode '"
                    . $modes->{subcompile}
                    . "' command-line arguments specified, dying\n";
            }
        }

        # all CPP ops modes require CPP output files; H output files may optionally be generated as needed for .pm input files only
        if ( $modes->{ops} eq 'CPP' ) {
            $output_file_name_groups->[$i]->{CPP}      = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_SOURCE}->{CPP}->[0];
            # DEV NOTE, CORRELATION #rp039: programs never have header files
            if ( $input_file_name =~ /[.]pm$/xms ) {
                $output_file_name_groups->[$i]->{H}        = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_SOURCE}->{H}->[0];
                $output_file_name_groups->[$i]->{_H_label} = ' (if needed)';
            }
            if ( $modes->{parallel} eq 'OPENMP' ) {
                $output_file_name_groups->[$i]->{OPENMP_CPP} = $output_file_name_path_prefix . $filename_suffixes_supported->{OUTPUT_SOURCE}->{OPENMP_CPP}->[0];
            }
        }

#        RPerl::diag('in Compiler::generate_output_file_names(), bottom of loop ' . $i . ' of ' . ($input_files_count - 1) . ", have \$output_file_name_groups->[$i] = \n" . Dumper( $output_file_name_groups->[$i] ) . "\n");
    }

#    RPerl::diag('in Compiler::generate_output_file_names(), returning $output_file_name_groups = ' . "\n" . Dumper($output_file_name_groups) . "\n" );
    return $output_file_name_groups;
}

# Write Source Code Files To File System
sub save_source_files {
    { my void $RETURN_TYPE };
    ( my string_hashref $source_group, my string_hashref $file_name_group, my string_hashref $modes ) = @ARG;

#    RPerl::diag( q{in Compiler::save_source_files(), received $source_group =} . "\n" . Dumper($source_group) . "\n" );
#    RPerl::diag( q{in Compiler::save_source_files(), received $file_name_group =} . "\n" . Dumper($file_name_group) . "\n" );
#    RPerl::diag( 'in Compiler::save_source_files(), received $modes =' . "\n" . Dumper($modes) . "\n" );
#    RPerl::diag( 'in Compiler::save_source_files(), received $modes->{_symbol_table} =' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );
#    RPerl::diag( 'in Compiler::save_source_files(), received $modes->{_input_file_name} =' . "\n" . Dumper($modes->{_input_file_name}) . "\n" );
#    RPerl::diag( "\n" . 'in Compiler::save_source_files(), received $modes->{subcompile} =' . "\n" . Dumper($modes->{subcompile}) . "\n" );

    foreach my string $suffix_key ( sort keys %{$source_group} ) {
        if ( ( substr $suffix_key, 0, 1 ) eq '_' ) { next; }
        if (   ( not exists $file_name_group->{$suffix_key} )
            or ( not defined $file_name_group->{$suffix_key} )
            or ( $file_name_group->{$suffix_key} eq q{} ) )
        {
            croak("\nERROR ECOCOFI00, COMPILER, SAVE OUTPUT FILES: Expecting file name for suffix '$suffix_key', but received empty or no value, croaking");
        }
    }

    # CPPOPS POST-PROCESSING: set H paths in CPP files & finally create PMC file, as needed
    if ( $modes->{ops} eq 'CPP' ) {
        RPerl::verbose('SAVE  PHASE 0:      Final file modifications...    ');

        $source_group->{CPP} = post_processor_cpp__header_unneeded( $source_group );

        # DEV NOTE, CORRELATION #rp039: programs never have header files
        if (defined $file_name_group->{H}) {
#            RPerl::diag( 'in Compiler::save_source_files(), about to call post_processor_cpp__header_or_cpp_path() w/ $file_name_group->{H} = ' . $file_name_group->{H} . "\n" );
            $source_group->{CPP} = post_processor_cpp__header_or_cpp_path( $source_group->{CPP}, $file_name_group->{H} );
        }

        # MODULE POST-PROCESSING, only if primary input file is a module, thus requiring PMC file creation etc.
        if ( $modes->{_input_file_name} =~ /[.]pm$/xms ) {
            $source_group = post_processor_cpp__types_change( $source_group, $modes );
            post_processor_cpp__pmc_generate( $source_group, $file_name_group, $modes );
        }
        RPerl::verbose( ' done.' . "\n" );
    }

    RPerl::verbose('SAVE  PHASE 1:      Format & write files to disk...');

#    RPerl::diag( 'in Compiler::save_source_files(), have [sort keys %{$source_group}] = ' . Dumper([sort keys %{$source_group}]) . "\n" );
#    RPerl::diag( 'in Compiler::save_source_files(), have $source_group->{H} = ' . Dumper($source_group->{H}) . "\n" );
#    RPerl::diag( 'in Compiler::save_source_files(), have $source_group->{_PMC_includes} = ' . Dumper($source_group->{_PMC_includes}) . "\n" );
#    RPerl::diag( 'in Compiler::save_source_files(), have $source_group = ' . Dumper($source_group) . "\n" );

#    foreach my string $suffix_key ( sort keys %{$file_name_group} ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
    foreach my string $suffix_key ( sort keys %{$source_group} ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        if ( ( substr $suffix_key, 0, 1 ) eq '_' ) { next; }
        if (   ( not exists $source_group->{$suffix_key} )
            or ( not defined $source_group->{$suffix_key} )
            or ( $source_group->{$suffix_key} eq q{} ) )
        {
            croak("\nERROR ECOCOFI05, COMPILER, SAVE OUTPUT FILES: Expecting source code for suffix '$suffix_key', but received empty or no value, croaking");
        }
        my filehandleref $SOURCE_FILE_HANDLE;
        my string $file_name = $file_name_group->{$suffix_key};
        my string $source    = $source_group->{$suffix_key};

        if ( $file_name eq '_TEMPFILE' ) {
            ( $SOURCE_FILE_HANDLE, $file_name )
                = tempfile( 'tempfileXXXX', SUFFIX => ( lc $suffix_key ), UNLINK => 1, TMPDIR => 1 );

            print {$SOURCE_FILE_HANDLE} $source
                or croak("\nERROR ECOCOFI06, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot write to file,\ncroaking: $OS_ERROR");

            close $SOURCE_FILE_HANDLE
                or croak("\nERROR ECOCOFI09, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot close file,\ncroaking: $OS_ERROR");
        }
        else {
            # overwrite existing file
            if ( -f $file_name ) {
                unlink $file_name
                    or croak(
                    "\nERROR ECOCOFI07, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot delete existing file,\ncroaking: $OS_ERROR");
            }

            open $SOURCE_FILE_HANDLE, '>', $file_name
                or
                croak("\nERROR ECOCOFI08, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot open file for writing,\ncroaking: $OS_ERROR");

            print {$SOURCE_FILE_HANDLE} $source
                or croak("\nERROR ECOCOFI06, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot write to file,\ncroaking: $OS_ERROR");

            close $SOURCE_FILE_HANDLE
                or croak("\nERROR ECOCOFI09, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot close file,\ncroaking: $OS_ERROR");
        }

        # format output code
        if ( ( $suffix_key eq 'PMC' ) or ( $suffix_key eq 'EXE' ) ) {
            my string $perltidy_path = undef;
            $perltidy_path = can_run('perltidy');    # DEV NOTE: comment this line to disable perltidy
            if ( defined $perltidy_path ) {
#                system $perltidy_path, '-pbp', '--ignore-side-comment-lengths', '--converge', '-l=160', '-b', '-nst', q{-bext='/'}, '-q', $file_name;
                system $perltidy_path, '-pbp', '--ignore-side-comment-lengths', '--converge', '-l=' . RPerl::Generator::PERLTIDY_LINE_WIDTH(), '-b', '-nst', q{-bext='/'}, '-q', $file_name;
            }
            else {
                RPerl::warning(
                    "\n" . 'WARNING WCOCOFO00, COMPILER, PERL CODE FORMATTING: Perltidy command `perltidy` not found, abandoning formatting' . "\n" );
            }
        }
        elsif ( ( $suffix_key eq 'H' ) or ( $suffix_key eq 'CPP' ) ) {
            my string $astyle_path = can_run('astyle');
            if ( defined $astyle_path ) {

                #                system $astyle_path, '-q', $file_name;
                # don't insert extra newlines, which causes accessors, mutators, and ops_types reporting subroutines to be broken into multiple lines
                system $astyle_path, '-q', '--keep-one-line-blocks', '--keep-one-line-statements', $file_name;
                if ( -f $file_name . '.orig' ) {
                    unlink( $file_name . '.orig' )
                        or croak( "\n"
                            . 'ERROR ECOCOFI10, COMPILER, FILE SYSTEM: Cannot delete Artistic Style original file ' . q{'}
                            . $file_name . '.orig' . q{'} . ',' . "\n"
                            . 'croaking:'
                            . $OS_ERROR );
                }
            }
            else {
                RPerl::warning( 'WARNING WCOCOFO01, COMPILER, C++ CODE FORMATTING: Artistic Style command `astyle` not found, abandoning formatting' . "\n" );
            }
        }
    }

    RPerl::verbose( ' done.' . "\n" );
    return;
}

# remove unneeded __NEED_HEADER_PATH line
sub post_processor_cpp__header_unneeded {
    { my string $RETURN_TYPE };
    ( my string $source_group ) = @ARG;

    # DEV NOTE, CORRELATION #rp033: defer setting header include path until files are saved in Compiler
    if ((not exists $source_group->{H}) or (not defined $source_group->{H})) {
#        RPerl::diag( 'in Compiler::post_processor_cpp__header_unneeded(), removing unneeded __NEED_HEADER_PATH line' . "\n" );
        my string $source_group_CPP_no_header = q{};
        foreach my string $source_group_CPP_line (split /\n/, $source_group->{CPP}) {
#            RPerl::diag( 'in Compiler::post_processor_cpp__header_unneeded(), have $source_group_CPP_line = ' . "\n" . $source_group_CPP_line . "\n" );
            if ($source_group_CPP_line =~ m/__NEED_HEADER_PATH/) { next; }
            $source_group_CPP_no_header .= $source_group_CPP_line . "\n";
        }
        return $source_group_CPP_no_header;
    }
    else {
#        RPerl::diag( 'in Compiler::post_processor_cpp__header_unneeded(), NOT removing unneeded __NEED_HEADER_PATH line' . "\n" );
        return $source_group->{CPP};
    }
}

# replace __NEED_HEADER_PATH or __NEED_CPP_PATH with proper C++ header path
sub post_processor_cpp__header_or_cpp_path {
    { my string $RETURN_TYPE };
    ( my string $source_CPP, my string $file_path ) = @ARG;
#    RPerl::diag( 'in Compiler::post_processor_cpp__header_or_cpp_path(), top of subroutine, received $file_path = ' . $file_path . "\n" );

    # remove leading '.\' or './' if present
    if ( $OSNAME eq 'MSWin32' ) {
        if ( ( substr $file_path, 0, 2 ) eq q{.\\} ) {
            substr $file_path, 0, 2, q{};
        }
    }
    else {
        if ( ( substr $file_path, 0, 2 ) eq './' ) {
            substr $file_path, 0, 2, q{};
        }
    }

    $file_path = post_processor_cpp__lib_path_delete($file_path);
#    RPerl::diag( 'in Compiler::post_processor_cpp__header_or_cpp_path(), after post_processor_cpp__lib_path_delete() have $file_path = ' . $file_path . "\n" );

    # DEV NOTE, CORRELATION #rp033: deferred, finally set path to H module header file in CPP module file
    $source_CPP =~ s/__NEED_HEADER_PATH/$file_path/gxms;
    $source_CPP =~ s/__NEED_CPP_PATH/$file_path/gxms;
    return $source_CPP;
}

# remove leading lib or blib path if present, because it should already be enabled for C++ in RPerl/Inline.pm via -Ifoo subcompiler argument, 
# and for Perl in the generated PMC files via $main::INCLUDE_PATH global var
sub post_processor_cpp__lib_path_delete {
    { my string $RETURN_TYPE };
    ( my string $path ) = @ARG;

    # DEV NOTE: sometimes MS Windows OS has forward slashes in the 'blib/lib/' part of the path, so we do not differentiate by OS
    if ( ( substr $path, 0, 4 ) eq 'lib\\' ) {
        substr $path, 0, 4, q{};
    }
#    elsif ( ( substr $path, 0, 5 ) eq '\\lib\\' ) {  # NEED ANSWER: same question as below
#        substr $path, 0, 5, q{};
#    }
    elsif ( ( substr $path, 0, 6 ) eq '.\\lib\\' ) {
        substr $path, 0, 6, q{};
    }
    elsif ( ( substr $path, 0, 9 ) eq 'blib\\lib\\' ) {
        substr $path, 0, 9, q{};
    }
#    elsif ( ( substr $path, 0, 10 ) eq '\\blib\\lib\\' ) {  # NEED ANSWER: same question as below
#        substr $path, 0, 10, q{};
#    }
    elsif ( ( substr $path, 0, 11 ) eq '.\\blib\\lib\\' ) {
        substr $path, 0, 11, q{};
    }
    elsif ( ( substr $path, 0, 4 ) eq 'lib/' ) {
        substr $path, 0, 4, q{};
    }
#    elsif ( ( substr $path, 0, 5 ) eq '/lib/' ) {  # NEED ANSWER: is there ever a case where '/lib/' would appear instead of 'lib/' or './lib/' ???
#        substr $path, 0, 5, q{};
#    }
    elsif ( ( substr $path, 0, 6 ) eq './lib/' ) {
        substr $path, 0, 6, q{};
    }
    elsif ( ( substr $path, 0, 9 ) eq 'blib/lib/' ) {
        substr $path, 0, 9, q{};
    }
#    elsif ( ( substr $path, 0, 10 ) eq '/blib/lib/' ) {  # NEED ANSWER: same question as above
#        substr $path, 0, 10, q{};
#    }
    elsif ( ( substr $path, 0, 11 ) eq './blib/lib/' ) {
        substr $path, 0, 11, q{};
    }
    return $path;
}

# remove leading blib path if present, because it should only be utilized during Makefile build phase
sub post_processor_cpp__blib_path_delete {
    { my string $RETURN_TYPE };
    ( my string $path ) = @ARG;

    # DEV NOTE: sometimes MS Windows OS has forward slashes in the 'blib/lib/' part of the path, so we do not differentiate by OS
    # DEV NOTE: only delete the 'blib/' parts, not the entire 'blib/lib/' part, leave the 'lib/' in place
    if ( ( substr $path, 0, 5 ) eq 'blib\\' ) {
        substr $path, 0, 5, q{};
    }
#    elsif ( ( substr $path, 0, 6 ) eq '\\blib\\' ) {  # NEED ANSWER: is there ever a case where '/lib/' would appear instead of 'lib/' or './lib/' ???
#        substr $path, 0, 6, q{};
#    }
    elsif ( ( substr $path, 0, 7 ) eq '.\\blib\\' ) {
        substr $path, 0, 7, q{};
    }
    elsif ( ( substr $path, 0, 5 ) eq 'blib/' ) {
        substr $path, 0, 5, q{};
    }
#    elsif ( ( substr $path, 0, 6 ) eq '/blib/' ) {  # NEED ANSWER: same question as above
#        substr $path, 0, 6, q{};
#    }
    elsif ( ( substr $path, 0, 7 ) eq './blib/' ) {
        substr $path, 0, 7, q{};
    }
    return $path;
}

# replace hard-coded PERLOPS_PERLTYPES with CPPOPS_*TYPES
sub post_processor_cpp__types_change {
    { my string_hashref $RETURN_TYPE };
    ( my string_hashref $source_group, my string_hashref $modes ) = @ARG;
    my string $mode_tagline = $modes->{ops} . 'OPS_' . $modes->{types} . 'TYPES';
    if ( exists $source_group->{H} ) {
        $source_group->{H} =~ s/PERLOPS_PERLTYPES/$mode_tagline/gxms;
    }
    if ( exists $source_group->{CPP} ) {
        $source_group->{CPP} =~ s/PERLOPS_PERLTYPES/$mode_tagline/gxms;
    }
    return $source_group;
}

# remove Perl comments
sub post_processor_perl__comments_whitespace_delete {
    { my string $RETURN_TYPE };
    ( my string $input_source_code ) = @ARG;

    my string_arrayref $input_source_code_split = [ ( split /\n/xms, $input_source_code ) ];
    my string_arrayref $input_source_code_split_tmp = [];

    my boolean $inside_comment = 0;
    my boolean $inside_string  = 0;
    my boolean $inside_heredoc = 0;
    my boolean $inside_indent;
    my string $open_quote_string;
    my string $open_quote_heredoc;
    foreach my string $input_source_code_line ( @{$input_source_code_split} ) {

#        RPerl::diag( 'in Compiler::post_processor_perl__comments_whitespace_delete(), have $input_source_code_line = ' . q{'} . $input_source_code_line . q{'} . "\n" );
#        RPerl::diag( 'in C::ppp__cwd(), $iscl = ' . q{'} . $input_source_code_line . q{'} . "\n" );
        if ($inside_comment) {
            if ( $input_source_code_line =~ m/^=cut$/xms ) { $inside_comment = 0; next; }    # delete end of multi-line POD =COMMENT
            next;                                                                            # delete middle of multi-line POD =COMMENT
        }
        if ($inside_heredoc) {
            if ( $input_source_code_line eq $open_quote_heredoc ) { $inside_heredoc = 0; }
            push @{$input_source_code_split_tmp}, $input_source_code_line;
            next;
        }
        if ( $input_source_code_line =~ m/^\s*$/xms )        { next; }                         # delete blank or all-whitespace line
        if ( $input_source_code_line =~ m/^\s*[#][^#!]/xms ) { next; }                         # delete whole-line # COMMENT
        if ( $input_source_code_line =~ m/^=\w+/xms )        { $inside_comment = 1; next; }    # delete beginning of multi-line POD =COMMENT

        $inside_indent = 1;

        # delete partial-line & multi-line comments, properly handling strings which contain comment characters
        my string $input_source_code_line_tmp = q{};
        my string $current_character;
        my string $next_character;
        my boolean $advance_one = 0;
        for my integer $i ( 0 .. ( ( length $input_source_code_line ) - 1 ) ) {
            $current_character = substr $input_source_code_line, $i, 1;
            if ( ($inside_indent) and ( $current_character !~ m/[ \t]/xms ) ) {
                $inside_indent = 0;
            }

            # advance one extra character for q{ OR #! OR ##
            if ($advance_one) {
                $advance_one--;
                $input_source_code_line_tmp .= $current_character;
                next;
            }
            if ( not $inside_string ) {
                if ( $current_character eq '#' ) {
                    $next_character = substr $input_source_code_line, ( $i + 1 ), 1;
                    if ( ( $next_character eq '!' ) or ( $next_character eq '#' ) ) { $advance_one = 1; }    # do not delete shebang #! or critics ##
                    else                                                            { last; }                # delete partial-line # COMMENT
                }
                elsif ( $current_character eq q{'} ) {
                    $inside_string     = 1;
                    $open_quote_string = q{'};
                }
                elsif ( $current_character eq q{"} ) {
                    $inside_string     = 1;
                    $open_quote_string = q{"};
                }
                elsif ( $current_character eq 'q' ) {
                    $next_character = substr $input_source_code_line, ( $i + 1 ), 1;
                    if ( $next_character eq '{' ) {
                        $inside_string     = 1;
                        $advance_one       = 1;
                        $open_quote_string = 'q{';
                    }
                }
                elsif ( $current_character eq '<' ) {
                    $next_character = substr $input_source_code_line, ( $i + 1 ), 1;
                    if ( $next_character eq '<' ) {
                        $inside_heredoc = 1;
                        $open_quote_heredoc = substr $input_source_code_line, ( $i + 2 );
                        if ( ( substr $open_quote_heredoc, 0, 1 ) eq q{'} ) { substr $open_quote_heredoc, 0, 1, q{}; }
                        if ( ( substr $open_quote_heredoc, 0, 1 ) eq q{"} ) { substr $open_quote_heredoc, 0, 1, q{}; }
                        $open_quote_heredoc =~ s/\s+$//xms;    # delete trailing whitespace after heredoc open quote and semicolon
                        if ( ( substr $open_quote_heredoc, -1, 1 ) eq q{;} ) { substr $open_quote_heredoc, -1, 1, q{}; }
                        $open_quote_heredoc =~ s/\s+$//xms;    # delete whitespace between heredoc open quote and semicolon
                        if ( ( substr $open_quote_heredoc, -1, 1 ) eq q{'} ) { substr $open_quote_heredoc, -1, 1, q{}; }
                        if ( ( substr $open_quote_heredoc, -1, 1 ) eq q{"} ) { substr $open_quote_heredoc, -1, 1, q{}; }
                    }
                }

                # delete extra whitespace inserted by Perl::Tidy
                elsif ( ( not $inside_indent ) and ( $current_character =~ m/[ \t]/xms ) ) {
                    $next_character = substr $input_source_code_line, ( $i + 1 ), 1;
                    if ( $next_character =~ m/[ \t]/xms ) { next; }    # delete extra whitespace
                }
            }
            else {                                                     # $inside_string
                if    ( ( $current_character eq q{'} ) and ( $open_quote_string eq q{'} ) ) { $inside_string = 0; }
                elsif ( ( $current_character eq q{"} ) and ( $open_quote_string eq q{"} ) ) { $inside_string = 0; }
                elsif ( ( $current_character eq '}' )  and ( $open_quote_string eq 'q{' ) ) { $inside_string = 0; }
            }
            $input_source_code_line_tmp .= $current_character;
        }
        $input_source_code_line = $input_source_code_line_tmp;

        $input_source_code_line =~ s/[ \t]+$//xms;                     # delete trailing whitespace, if present

        push @{$input_source_code_split_tmp}, $input_source_code_line;
    }
    return join "\n", @{$input_source_code_split_tmp};
}

# remove C++ comments
# NEED TEST: create full tests for this subroutine
sub post_processor_cpp__comments_whitespace_delete {
    { my string $RETURN_TYPE };
    ( my string $input_source_code ) = @ARG;

    my string_arrayref $input_source_code_split = [ ( split /\n/xms, $input_source_code ) ];
    my string_arrayref $input_source_code_split_tmp = [];

    my boolean $inside_comment = 0;
    my boolean $inside_string  = 0;
    my string $open_quote;
    foreach my string $input_source_code_line ( @{$input_source_code_split} ) {
        if ($inside_comment) {
            if ( $input_source_code_line =~ m!\*/!xms ) {
                $input_source_code_line =~ s!^(.*\*/)!!xms;    # delete end of multi-line /* COMMENT */
                $inside_comment = 0;
            }
            else { next; }                                     # delete middle of multi-line /* COMMENT */
        }
        if ( $input_source_code_line =~ m/^\s*$/xms )            { next; }    # delete blank or all-whitespace line
        if ( $input_source_code_line =~ m!^\s*//!xms )           { next; }    # delete whole-line // COMMENT
        if ( $input_source_code_line =~ m!^\s*/\*.*\*/\s*$!xms ) { next; }    # delete whole-line /* COMMENT */

        # delete partial-line & multi-line comments, properly handling strings which contain comment characters
        my string $input_source_code_line_tmp = q{};
        my string $current_character;
        my string $next_character;
        my boolean $advance_one = 0;
        for my integer $i ( 0 .. ( ( length $input_source_code_line ) - 1 ) ) {
            $current_character = substr $input_source_code_line, $i, 1;

            # advance one extra character for \' or \" or /* or */
            if ($advance_one) {
                $advance_one = 0;
                $input_source_code_line_tmp .= $current_character;
                next;
            }
            if ( not $inside_string ) {
                if ($inside_comment) {
                    if ( $current_character eq '*' ) {
                        $next_character = substr $input_source_code_line, ( $i + 1 ), 1;
                        if ( $next_character eq '/' ) {

                            # delete end of partial-line /* COMMENT */
                            $advance_one    = 1;
                            $inside_comment = 0;
                            next;
                        }
                    }
                    else { next; }    # delete middle of partial-line /* COMMENT */
                }
                else {                # not $inside_comment
                    if ( $current_character eq '/' ) {
                        $next_character = substr $input_source_code_line, ( $i + 1 ), 1;
                        if ( $next_character eq '/' ) { last; }    # delete partial-line // COMMENT
                        elsif ( $next_character eq '*' ) {

                            # delete beginning of partial-line or multi-line /* COMMENT */
                            $advance_one    = 1;
                            $inside_comment = 1;
                            next;
                        }
                    }
                    elsif ( $current_character eq q{'} ) {
                        $inside_string = 1;
                        $open_quote    = q{'};
                    }
                    elsif ( $current_character eq q{"} ) {
                        $inside_string = 1;
                        $open_quote    = q{"};
                    }

                    # NEED UPGRADE: can not delete extra whitespace characters here, because it destroys indentation
                    #                    elsif ( $current_character =~ m/[ \t]/ ) {
                    #                        $next_character = substr $input_source_code_line, ( $i + 1 ), 1;
                    #                        if ( $next_character =~ m/[ \t]/ ) { next; }    # delete extra whitespace
                    #                    }
                }
            }
            else {    # $inside_string
                if    ( ( $current_character eq q{'} ) and ( $open_quote eq q{'} ) ) { $inside_string = 0; }
                elsif ( ( $current_character eq q{"} ) and ( $open_quote eq q{"} ) ) { $inside_string = 0; }
                elsif ( $current_character eq '\\' ) {
                    $next_character = substr $input_source_code_line, ( $i + 1 ), 1;

                    # backslash-escaped quotes do not close a string
                    if ( ( $next_character eq q{'} ) and ( $open_quote eq q{'} ) ) { $advance_one = 1; }
                    if ( ( $next_character eq q{"} ) and ( $open_quote eq q{"} ) ) { $advance_one = 1; }
                }
            }
            $input_source_code_line_tmp .= $current_character;
        }
        $input_source_code_line = $input_source_code_line_tmp;

        $input_source_code_line =~ s/[ \t]+$//xms;    # delete trailing whitespace, if present

        push @{$input_source_code_split_tmp}, $input_source_code_line;
    }
    return join "\n", @{$input_source_code_split_tmp};
}

# DEV NOTE, CORRELATION #rp055: handle removal of current directory & all @INC directories, so as not to hard-code system-specific dirs in #include statements
# remove unnecessary @INC paths
sub post_processor__INC_paths_delete {
    { my string $RETURN_TYPE };
    ( my string $input_path, my boolean $leading_slash_delete, my boolean $leading_lib_delete ) = @ARG;

    RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), received $input_path = ' . $input_path . "\n" );
    RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), received $leading_slash_delete = ' . $leading_slash_delete . "\n" );
    RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), received $leading_lib_delete = ' . $leading_lib_delete . "\n" );

    RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), have @INC = ' . Dumper(\@INC) . "\n" );

    # DEV NOTE: do not directly use @INC itself, because 'lib' stripping will actually change values of @INC!!!
    my @INC_copy = @INC;
    RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), have @INC_copy = ' . Dumper(\@INC_copy) . "\n" );

    if ( $OSNAME eq 'MSWin32' ) {
        $input_path =~ s/\\/\//gxms;
        RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), Windows OS detected, have possibly-reformatted $input_path = ' . $input_path . "\n" );
    }

    # strip leading INC directory if present
#    foreach my string $INC_directory (@INC) {  # DEV NOTE: do not directly use @INC itself, because 'lib' stripping will actually change values of @INC!!!
    foreach my string $INC_directory (@INC_copy) {
        RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), have $INC_directory = ' . $INC_directory . "\n" );
        if ((not $leading_lib_delete) and ((substr $INC_directory, -3, 3) eq 'lib')) {
            # delete trailing 'lib' in $INC_directory, so as NOT to delete leading 'lib' in $input_path
            RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), do not delete leading lib if present' . "\n" );
            substr $INC_directory, -3, 3, q{};
        }
        RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), have possibly-lib-trimmed $INC_directory = ' . $INC_directory . "\n" );
        if ($INC_directory eq q{}) {
            RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), skipping empty presumably-lib-trimmed $INC_directory' . "\n" );
            next;
        }

        if ((substr $input_path, 0, (length $INC_directory)) eq $INC_directory ) {
            RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), have matching $INC_directory, trimming dir...' . "\n" );
            substr $input_path, 0, ( length $INC_directory ), q{};
            if ($leading_slash_delete and ((substr $input_path, 0, 1) eq '/')) {
                RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), have matching $INC_directory, trimming leading slash...' . "\n" );
                substr $input_path, 0, 1, q{};
            }
            last;
        }
    }

    RPerl::diag( 'in Compiler::post_processor__INC_paths_delete(), about to return $input_path = ' . $input_path . "\n" );

    return $input_path;
}

# DEV NOTE, CORRELATION #rp055: handle removal of current directory & all @INC directories, so as not to hard-code system-specific dirs in #include statements
# remove unnecessary absolute paths
sub post_processor__absolute_path_delete {
    { my string $RETURN_TYPE };
    ( my string $input_path ) = @ARG;

    RPerl::diag( 'in Compiler::post_processor__absolute_path_delete(), received $input_path = ' . $input_path . "\n" );

    if ( $OSNAME eq 'MSWin32' ) {
        $input_path =~ s/\\/\//gxms;
        RPerl::diag( 'in Compiler::post_processor__absolute_path_delete(), Windows OS detected, have possibly-reformatted $input_path = ' . $input_path . "\n" );
    }

    my string $current_working_directory = getcwd;

    RPerl::diag( 'in Compiler::post_processor__absolute_path_delete(), have $current_working_directory = ' . $current_working_directory . "\n" );

    if ( ( substr $input_path, 0, ( length $current_working_directory ) ) eq $current_working_directory ) {
        return substr $input_path, ( ( length $current_working_directory ) + 1 );
    }

    RPerl::diag( 'in Compiler::post_processor__absolute_path_delete(), about to return $input_path = ' . $input_path . "\n" );

    return $input_path;  # this comment is a test of find_replace_old_subroutine_headers.sh
}

# remove unnecessary current-directory paths
sub post_processor__current_directory_path_delete {
    { my string $RETURN_TYPE };
    ( my string $input_path ) = @ARG;

#    RPerl::diag( 'in Compiler::post_processor__current_directory_path_delete(), received $input_path = ' . $input_path . "\n" );

    if ( $OSNAME eq 'MSWin32' ) {
        $input_path =~ s/\\/\//gxms;
#        RPerl::diag( 'in Compiler::post_processor__current_directory_path_delete(), Windows OS detected, have possibly-reformatted $input_path = ' . $input_path . "\n" );
    }

    if ( ( substr $input_path, 0, 2 ) eq './' ) {
        return substr $input_path, 2;
    }
    return $input_path;  # this comment is a test of find_replace_old_subroutine_headers.sh
}

# generate PMC file
sub post_processor_cpp__pmc_generate {
    { my void $RETURN_TYPE };
    ( my string_hashref $source_group, my string_hashref $file_name_group, my string_hashref $modes ) = @ARG;
#    RPerl::diag( q{in Compiler::post_processor_cpp__pmc_generate(), top of surbroutine...} . "\n" );
#    RPerl::diag( q{in Compiler::post_processor_cpp__pmc_generate(), received $file_name_group->{CPP} = } . $file_name_group->{CPP} . "\n" );

    # DEV NOTE: only generate PMC output file in dynamic (default) subcompile mode
    if ( $modes->{subcompile} eq 'DYNAMIC' ) {
        if ( ( exists $source_group->{PMC} ) and ( defined $source_group->{PMC} ) and ( $source_group->{PMC} ne q{} ) ) {

#            RPerl::diag( q{in Compiler::post_processor_cpp__pmc_generate(), have $source_group = } . Dumper($source_group) . "\n" );
            die 'ERROR ECOCOFI01, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Received non-empty PMC source, dying' . "\n";
        }

#        RPerl::diag( q{in Compiler::post_processor_cpp__pmc_generate(), have %INC = } . Dumper(\%INC) . "\n" );
#        RPerl::diag( q{in Compiler::post_processor_cpp__pmc_generate(), have @INC = } . Dumper(\@INC) . "\n" );
#        RPerl::diag( q{in Compiler::post_processor_cpp__pmc_generate(), have $source_group->{_package_names_underscores} = } . Dumper($source_group->{_package_names_underscores}) . "\n" );
#        RPerl::diag( q{in Compiler::post_processor_cpp__pmc_generate(), have $source_group->{_package_names} = } . Dumper($source_group->{_package_names}) . "\n" );

        my string_arrayref $module_names_split             = [ ( split /\n/, $source_group->{_package_names} ) ];
        my string_arrayref $module_names_underscores_split = [ ( split /\n/, $source_group->{_package_names_underscores} ) ];

        #        RPerl::diag( q{in Compiler::post_processor_cpp__pmc_generate(), have $module_names_split = } . Dumper($module_names_split) . "\n" );

        my integer $module_count           = scalar @{$module_names_split};
        my string $module_name             = shift @{$module_names_split};
        my string $module_name_underscores = shift @{$module_names_underscores_split};
        my integer $i                      = 0;

# deferred, finally insert constants shims
#        RPerl::diag('in Compiler::post_processor_cpp__pmc_generate(), have $source_group->{_H_constants_shims}->{$module_name_underscores} = ' . $source_group->{_H_constants_shims}->{$module_name_underscores} . "\n");

        while ( defined $module_name_underscores ) {

#            RPerl::diag( q{in Compiler::post_processor_cpp__pmc_generate(), have $file_name_group->{CPP} = } . $file_name_group->{CPP} . "\n" );
#            RPerl::diag( q{in Compiler::post_processor_cpp__pmc_generate(), have $module_name_underscores = } . $module_name_underscores . "\n" );

            # utilize modified copies of Module PMC template file
            my string $module_pmc_filename_manual;
            if ( $module_count == 1 ) {
                $module_pmc_filename_manual = $RPerl::INCLUDE_PATH . '/RPerl/CompileUnit/Module.pmc.CPPOPS_DUALTYPES_TEMPLATE';
            }
            else {
                if ( $i == ( $module_count - 1 ) ) {
                    $module_pmc_filename_manual = $RPerl::INCLUDE_PATH . '/RPerl/CompileUnit/Module.pmc.CPPOPS_DUALTYPES_TEMPLATE_MONOLITH';
                }
                else {
                    $module_pmc_filename_manual = $RPerl::INCLUDE_PATH . '/RPerl/CompileUnit/Module.pmc.CPPOPS_DUALTYPES_TEMPLATE_MONOLITH_SECONDARY';
                }
            }

#            RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $module_pmc_filename_manual = ' . $module_pmc_filename_manual . "\n" );
#            RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $source_group->{_PMC_accessors_mutators_shims} = ' . Dumper($source_group->{_PMC_accessors_mutators_shims}) . "\n" );
#            RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $source_group->{_PMC_subroutines_shims} = ' . Dumper($source_group->{_PMC_subroutines_shims}) . "\n" );
#            RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $source_group->{_PMC_includes} = ' . Dumper($source_group->{_PMC_includes}) . "\n" );

            if ( not -f $module_pmc_filename_manual ) {
                die 'ERROR ECOCOFI02, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: File not found, ' . q{'}
                    . $module_pmc_filename_manual . q{'} . "\n"
                    . ', dying' . "\n";
            }

            open my filehandleref $FILE_HANDLE, '<', $module_pmc_filename_manual
                or die 'ERROR ECOCOFI03, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Cannot open file '
                . $module_pmc_filename_manual
                . ' for reading, '
                . $OS_ERROR
                . ', dying' . "\n";

            # deferred, finally read in Module PMC template file, replace package name and paths, add accessor/mutator shim methods
            my string $file_line;
            my string $file_string  = q{};
            my string $pm_file_path = $file_name_group->{PMC};
            my boolean $has_rperl_config = 0;
            chop $pm_file_path;    # remove the 'c' from 'pmc' file suffix
            while ( $file_line = <$FILE_HANDLE> ) {
#                $file_line =~ s/\/RPerl\/CompileUnit\/Module\.cpp/$cpp_file_path/gxms;  # replaced by auto-generated 'use Inline' code below
                $file_line =~ s/RPerl::CompileUnit::Module/$module_name/gxms;
                $file_line =~ s/RPerl__CompileUnit__Module/$module_name_underscores/gxms;
                if ( $file_line eq
                    ( '# <<< OO PROPERTIES, ACCESSORS & MUTATORS, SHIMS >>>  # <<< CHANGE_ME: add real shims after this line or delete it >>>' . "\n" ) )
                {
                    if (    ( exists $source_group->{_PMC_accessors_mutators_shims}->{$module_name_underscores} )
                        and ( defined $source_group->{_PMC_accessors_mutators_shims}->{$module_name_underscores} ) )
                    {
                        $file_line
                            = ( substr $file_line, 0, 52 ) . "\n" . $source_group->{_PMC_accessors_mutators_shims}->{$module_name_underscores} . "\n\n";
                    }
                    else { $file_line = undef; }
                }
                elsif (
                    $file_line eq ( '# <<< OO PROPERTIES, SUBROUTINES, SHIMS >>>  # <<< CHANGE_ME: add real shims after this line or delete it >>>' . "\n" ) )
                {
                    if (    ( exists $source_group->{_PMC_subroutines_shims}->{$module_name_underscores} )
                        and ( defined $source_group->{_PMC_subroutines_shims}->{$module_name_underscores} ) )
                    {
                        $file_line = ( substr $file_line, 0, 43 ) . "\n" . $source_group->{_PMC_subroutines_shims}->{$module_name_underscores} . "\n\n";
                    }
                    else { $file_line = undef; }
                }
                elsif ( $file_line eq ( '# <<< CHANGE_ME: add OO ISA here >>>' . "\n" ) ) {
                    $file_line = 'our @ISA = qw(' . $source_group->{_parent_names}->{$module_name_underscores} . ');' . "\n";
                }
                # DEV NOTE, CORRELATION #rp027: RPerl::Config, MathPerl::Config, PhysicsPerl::Config, etc
                elsif ( $file_line eq ( '# <<< CHANGE_ME: add distribution-specific config include here >>>' . "\n" ) ) {
                    my string $distribution_package = ( split /::/, $source_group->{_package_name} )[0];
                    my string $eval_line = q{};
                    $eval_line .= 'use ' . $distribution_package . '::Config;  ';
                    $eval_line .= 'if ((defined $' . $distribution_package . '::Config::IS_RPERL_CONFIG) and ($' . $distribution_package . '::Config::IS_RPERL_CONFIG)) { return q{YES_CONFIG}; } else { return 0; }';

#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), checking for distribution-specific config file, have $eval_line = ', "\n", $eval_line, "\n" );
                    
                    my integer $eval_retval = eval $eval_line;

                    if ($EVAL_ERROR ne q{}) {
#                        RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), checking for distribution-specific config file, have non-empty $EVAL_ERROR = ', "\n", $EVAL_ERROR, "\n\n", 'no config file found' );
#                        RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), checking for distribution-specific config file, have non-empty $EVAL_ERROR, no config file found', "\n" );
                        # do not use any Config file if not provided by the distribution, no $main::INCLUDE_PATH will be utilized
#                        $file_line = 'use RPerl::Config;' . "\n";
                        $file_line = undef;
                        $has_rperl_config = 0;
                    }
                    elsif (defined $eval_retval) {
#                        RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), checking for distribution-specific config file, have $eval_retval = ', q{'}, $eval_retval, q{'}, "\n" );

                        if (not $eval_retval) {
#                            RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), checking for distribution-specific config file, have false $eval_retval, no config file found', "\n" );
                            # do not use any Config file if not provided by the distribution, no $main::INCLUDE_PATH will be utilized
#                            $file_line = 'use RPerl::Config;' . "\n";
                            $file_line = undef;
                            $has_rperl_config = 0;
                        }
                        elsif ($eval_retval eq 'YES_CONFIG') {
#                            RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), checking for distribution-specific config file, have true $eval_retval, YES config file found, ', $distribution_package, '::Config', "\n" );
                            $file_line = 'use ' . $distribution_package . '::Config;' . "\n";
                            $has_rperl_config = 1;
                        }
                        else {
                            die 'ERROR ECOCOFI11, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Attempt to check for distribution-specific config file  '
                                . q{'} . $distribution_package . '::Config' . q{'} . ' returned invalid value:' . "\n" . $eval_retval . "\n" . 'dying' . "\n";
                        }
                    }
                    else {
                        die 'ERROR ECOCOFI11, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Attempt to check for distribution-specific config file  '
                            . q{'} . $distribution_package . '::Config' . q{'} . ' returned undefined value, dying' . "\n";
                    }
                }
                elsif ( $file_line eq ( '# <<< CHANGE_ME: add use Inline path & args here >>>' . "\n" ) ) {
                    # common to all options
                    $file_line  = '        my $eval_string = <<"EOF";' . "\n";
                    $file_line .= 'package main;' . "\n";
                    $file_line .= 'use RPerl::Inline;' . "\n";

=DISABLE_hardcoded_example__absolute_or_relative_with_dots
        my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
# ---vvv---
BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for '/foo/MyClass.pm' ]]]\n" x 1); }
use Inline (CPP => '/foo/MyClass.pm', \%RPerl::Inline::ARGS);
RPerl::diag("[[[ END   'use Inline' STAGE for '/foo/MyClass.pm' ]]]\n" x 1);
# ---^^^---
1;
EOF
=cut

=DISABLE_hardcoded_example__relative_without_dots__has_rperl_config
        my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
# ---vvv---
BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for 'RPerl/MyClass.cpp' ]]]\n" x 1); }
use Inline (CPP => '$main::INCLUDE_PATH' . '/' . 'RPerl/MyClass.cpp', \%RPerl::Inline::ARGS);
RPerl::diag("[[[ END   'use Inline' STAGE for 'RPerl/MyClass.cpp' ]]]\n" x 1);
# ---^^^---
1;
EOF
=cut

=DISABLE_hardcoded_example__relative_without_dots__no_rperl_config
# ---vvv---
        my $cpp_file_path = 'blib/lib/MyClass.cpp';
        my $cpp_file_path_noblib = 'lib/MyClass.cpp';
        if (not ((-e $cpp_file_path) and (-f $cpp_file_path))) { $cpp_file_path = $cpp_file_path_noblib; }  # fall back to non-blib, if blib does not exist
# ---^^^---
        my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
# ---vvv---
BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for 'lib/MyClass.cpp' ]]]\\n" x 1); }
use Inline (CPP => \$cpp_file_path, \%RPerl::Inline::ARGS);
RPerl::diag("[[[ END   'use Inline' STAGE for 'lib/MyClass.cpp' ]]]\\n" x 1);
# ---^^^---
1;
EOF
=cut

                    my string $cpp_file_path = $file_name_group->{CPP};
                    my string $cpp_file_path_noblib = q{};
                    my boolean $has_blib = 0;

#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, have $cpp_file_path = ', q{'}, $cpp_file_path, q{'}, "\n" );

                    # DEV NOTE: only call post_processor_cpp__lib_path_delete() if there is an RPerl config file which will provide the proper lib directory for us
                    if ($has_rperl_config) {
#                        RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, have true $has_rperl_config, about to call post_processor_cpp__lib_path_delete()...', "\n" );
                        $cpp_file_path = post_processor_cpp__lib_path_delete($cpp_file_path);
                    }
                    # DEV NOTE: only call post_processor_cpp__blib_path_delete() if there is NOT an RPerl config file, due to Makefile build phase
                    else {
#                        RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, have false $has_rperl_config, about to call post_processor_cpp__blib_path_delete()...', "\n" );
                        $cpp_file_path_noblib = post_processor_cpp__blib_path_delete($cpp_file_path);
                        if ($cpp_file_path_noblib ne $cpp_file_path) {
                            $has_blib = 1;
                        }
                    }
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, have possibly-modified $cpp_file_path = ', q{'}, $cpp_file_path, q{'}, "\n" );
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, have $cpp_file_path_noblib = ', q{'}, $cpp_file_path_noblib, q{'}, "\n" );

                    # $cpp_volume will be empty string q{} on *NIX & other non-volume operating systems
                    (my string $cpp_volume, my string $cpp_directories, my string $cpp_file) = File::Spec->splitpath( $cpp_file_path, my boolean $no_file = 0 );
#                    my string $cpp_file_full_recatted = File::Spec->catpath( $cpp_volume, $cpp_directories, $cpp_file );  # unused
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, have $has_rperl_config = ', $has_rperl_config, "\n" );
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, have $has_blib = ', $has_blib, "\n" );
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, have $cpp_volume = ', q{'}, $cpp_volume, q{'}, "\n" );
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, have $cpp_directories = ', q{'}, $cpp_directories, q{'}, "\n" );
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, have $cpp_file = ', q{'}, $cpp_file, q{'}, "\n" );

                    my string $cpp_directories_char0 = substr $cpp_directories, 0, 1;

                    # absolute path; OR
                    if ((($cpp_volume ne q{}) or ($cpp_directories_char0 eq '/') or ($cpp_directories_char0 eq '\\')) or
                    # relative path, w/ leading dots
                    ($cpp_directories_char0 eq '.')) {
                        # prepend nothing, even if $has_rperl_config or $has_blib
                        # DEV NOTE, CORRELATION #rp036: handle input file names with leading dots
                        # we should have already stripped all leading single-dots in rperl::accept_and_verify_input_files(),
                        # so all leading-dot $cpp_directories here should be double-dots, although the same logic here should also apply to single-dots,
                        # because the point is not to prepend INCLUDE_PATH to anything which has dots at all, which is almost certainly wrong;
                        # also, the Makefile build phase prepends non-absolute non-relative-w/-dots 'blib/' which should not trigger this section
#                        RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, absolute path or relative path w/ leading dots, PREPEND NOTHING', "\n" );
                        $file_line .= q<BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for '> . $cpp_file_path . q<' ]]]\n" x 1); }> . "\n";
                        $file_line .= q{use Inline (CPP => '} . $cpp_file_path . q{', \%RPerl::Inline::ARGS);} . "\n";
                        $file_line .= q{RPerl::diag("[[[ END   'use Inline' STAGE for '} . $cpp_file_path . q{' ]]]\n" x 1);} . "\n";
                    }
                    # relative path, w/out leading dots
                    else {
                        # relative path, w/out leading dots, has RPerl config
                        if ($has_rperl_config) {
                            # prepend INCLUDE_PATH and forward slash
                            # NEED ANSWER WIN32: forward slash has been a valid path separator since MS-DOS v2.0, but can NOT be used as a path separator in the DOS shell command line because it is used for command switches instead
                            # so is it truly necessary to use backslash for WIN32 just to be safe??? 
#                            RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, relative path w/out leading dots and true $has_rperl_config, PREPEND INCLUDE_PATH', "\n" );
                            if ( $OSNAME eq 'MSWin32' ) {
                                $file_line .= q<BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for '> . $cpp_file_path . q<' ]]]\n" x 1); }> . "\n";
                                # NEED ANSWER WIN32: should the backslash below itself be backslash escaped (double backslash), or not???
                                $file_line .= q{use Inline (CPP => '$main::INCLUDE_PATH' . '\\' . '} . $cpp_file_path . q{', \%RPerl::Inline::ARGS);} . "\n";
                                $file_line .= q{RPerl::diag("[[[ END   'use Inline' STAGE for '} . $cpp_file_path . q{' ]]]\n" x 1);} . "\n";
                            }
                            else {
                                $file_line .= q<BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for '> . $cpp_file_path . q<' ]]]\n" x 1); }> . "\n";
                                $file_line .= q{use Inline (CPP => '$main::INCLUDE_PATH' . '/' . '} . $cpp_file_path . q{', \%RPerl::Inline::ARGS);} . "\n";
                                $file_line .= q{RPerl::diag("[[[ END   'use Inline' STAGE for '} . $cpp_file_path . q{' ]]]\n" x 1);} . "\n";
                            }
                        }
                        # relative path, w/out leading dots, no RPerl config
                        else {
#                            RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, relative path w/out leading dots and false $has_rperl_config', "\n" );
                            if (not $has_blib) {
                                # artificially prepend 'blib/' so we can prepend blib-handling logic below,
                                # allowing for uniformity between normal `rperl` front-end invocation versus Makefile build phase
#                                RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, relative path w/out leading dots and false $has_rperl_config, false $has_blib, artificially prepending to $cpp_file_path', "\n" );
                                if ( $OSNAME eq 'MSWin32' ) {
                                    $cpp_file_path = 'blib\\' . $cpp_file_path;
                                }
                                else {
                                    $cpp_file_path = 'blib/' . $cpp_file_path;
                                }
                            }
                            # DEV NOTE: barely-documented Inline::CPP bug, must have leading './' if no other directories in path
                            if ( $cpp_file_path !~ /\// ) {
                                # prepend './' to path before generating $file_line
#                                RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, relative path w/out leading dots and false $has_rperl_config, $cpp_file_path has no slashes, prepending dot-slash', "\n" );
                                if ( $OSNAME eq 'MSWin32' ) {
                                    $cpp_file_path = q{.\\} . $cpp_file_path;
                                }
                                else {
                                    $cpp_file_path = q{./} . $cpp_file_path;
                                }
                            }
                            if ( $cpp_file_path_noblib !~ /\// ) {
                                # prepend './' to path before generating $file_line
#                                RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, relative path w/out leading dots and false $has_rperl_config, $cpp_file_path_noblib has no slashes, prepending dot-slash', "\n" );
                                if ( $OSNAME eq 'MSWin32' ) {
                                    $cpp_file_path_noblib = q{.\\} . $cpp_file_path_noblib;
                                }
                                else {
                                    $cpp_file_path_noblib = q{./} . $cpp_file_path_noblib;
                                }
                            }

                            # prepend blib-handling logic
                            # DEV NOTE: for relative path w/out leading dots, we must always prepend blib-handling logic, in order to allow for uniformity
#                            RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), setting use Inline path & args, relative path w/out leading dots and false $has_rperl_config, prepending blib-handling logic', "\n" );
                            my $file_line_prepend = q{};
                            $file_line_prepend .= q<        my $cpp_file_path = '> . $cpp_file_path . q<';> . "\n";
                            $file_line_prepend .= q<        my $cpp_file_path_noblib = '> . $cpp_file_path_noblib . q<';> . "\n";
                            $file_line_prepend .= q<        if (not ((-e $cpp_file_path) and (-f $cpp_file_path))) { $cpp_file_path = $cpp_file_path_noblib; }  # fall back to non-blib, if blib does not exist> . "\n";
                            $file_line = $file_line_prepend . $file_line;

                            # hard-code $cpp_file_path_noblib in debug statements for uniformity
                            $file_line .= q<BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for '> . $cpp_file_path_noblib . q<' ]]]\n" x 1); }> . "\n";
                            $file_line .= q{use Inline (CPP => \$cpp_file_path, \%RPerl::Inline::ARGS);} . "\n";
                            $file_line .= q{RPerl::diag("[[[ END   'use Inline' STAGE for '} . $cpp_file_path_noblib . q{' ]]]\n" x 1);} . "\n";
                        }
                    }

                    # common to all options
                    $file_line .= '1;' . "\n";
                    $file_line .= 'EOF' . "\n";
                }
                elsif ( $file_line eq ( '# <<< CHANGE_ME: add user-defined includes here >>>' . "\n" ) ) {
                    if (    ( exists $source_group->{_PMC_includes}->{$module_name_underscores} )
                        and ( defined $source_group->{_PMC_includes}->{$module_name_underscores} ) )
                    {
                        $file_line = $source_group->{_PMC_includes}->{$module_name_underscores} . "\n\n";
                    }
                    else { $file_line = undef; }
                }
                elsif ( $file_line eq ( '        # <<< CHANGE_ME: enable optional SSE support here >>>' . "\n" ) ) {
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n" );
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $pm_file_path = ' . $pm_file_path . "\n" );
                    $pm_file_path = post_processor__INC_paths_delete($pm_file_path, 1, 0);  # $leading_slash_delete = 1, $leading_lib_delete = 0
                    $pm_file_path = post_processor__absolute_path_delete($pm_file_path);
                    $pm_file_path = post_processor__current_directory_path_delete($pm_file_path);
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have possibly-trimmed $pm_file_path = ' . $pm_file_path . "\n" );

                    if (    ( exists $modes->{_enable_sse} )
                        and ( defined $modes->{_enable_sse} )
                        and ( exists $modes->{_enable_sse}->{$pm_file_path} )
                        and ( defined $modes->{_enable_sse}->{$pm_file_path} )
                        and $modes->{_enable_sse}->{$pm_file_path} )
                    {
                        $file_line = q(        $RPerl::Inline::ARGS{optimize}  .= ' -mfpmath=sse -msse3';  # enable SSE support) . "\n";
                        $file_line
                            .= q(        $RPerl::Inline::ARGS{auto_include} = ['#include <immintrin.h>', @{$RPerl::Inline::ARGS{auto_include}}];  # enable SSE support)
                            . "\n";
                    }
                    else { $file_line = undef; }
                }
                elsif ( $file_line eq ( '        # <<< CHANGE_ME: enable optional GMP support here >>>' . "\n" ) ) {
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n" );
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $pm_file_path = ' . $pm_file_path . "\n" );
                    $pm_file_path = post_processor__INC_paths_delete($pm_file_path, 1, 0);  # $leading_slash_delete = 1, $leading_lib_delete = 0
                    $pm_file_path = post_processor__absolute_path_delete($pm_file_path);
                    $pm_file_path = post_processor__current_directory_path_delete($pm_file_path);
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have possibly-trimmed $pm_file_path = ' . $pm_file_path . "\n" );

                    if (    ( exists $modes->{_enable_gmp} )
                        and ( defined $modes->{_enable_gmp} )
                        and ( exists $modes->{_enable_gmp}->{$pm_file_path} )
                        and ( defined $modes->{_enable_gmp}->{$pm_file_path} )
                        and $modes->{_enable_gmp}->{$pm_file_path} )
                    {
                        $file_line = q(        $RPerl::Inline::ARGS{libs}  = '-L' . $RPerl::Inline::gmp_lib_dir . ' -lgmpxx -lgmp';  # enable GMP support) . "\n";
                        $file_line .= q(        $RPerl::Inline::ARGS{inc}  .= ' -I' . $RPerl::Inline::gmp_include_dir;  # enable GMP support) . "\n";
                        $file_line
                            .= q(        $RPerl::Inline::ARGS{auto_include} = [ @{ $RPerl::Inline::ARGS{auto_include} }, '#include <gmpxx.h>', '#include <gmp.h>' ];    # enable GMP support)
                            . "\n";
                    }
                    else { $file_line = undef; }
                }
                elsif ( $file_line eq ( '        # <<< CHANGE_ME: enable optional GSL support here >>>' . "\n" ) ) {
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $modes->{_enable_gsl} = ' . Dumper($modes->{_enable_gsl}) . "\n" );
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $pm_file_path = ' . $pm_file_path . "\n" );
                    $pm_file_path = post_processor__INC_paths_delete($pm_file_path, 1, 0);  # $leading_slash_delete = 1, $leading_lib_delete = 0
                    $pm_file_path = post_processor__absolute_path_delete($pm_file_path);
                    $pm_file_path = post_processor__current_directory_path_delete($pm_file_path);
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have possibly-trimmed $pm_file_path = ' . $pm_file_path . "\n" );
                    
                    if (    ( exists $modes->{_enable_gsl} )
                        and ( defined $modes->{_enable_gsl} )
                        and ( exists $modes->{_enable_gsl}->{$pm_file_path} )
                        and ( defined $modes->{_enable_gsl}->{$pm_file_path} )
                        and $modes->{_enable_gsl}->{$pm_file_path} )
                    {
                        # DEV NOTE: linking instructions    https://www.gnu.org/software/gsl/doc/html/usage.html#linking-programs-with-the-library
                        $file_line = q(        $RPerl::Inline::ARGS{libs}  = '-L' . $RPerl::Inline::gsl_lib_dir . ' -lgsl -lgslcblas -lm';  # enable GSL support) . "\n";
                        $file_line .= q(        $RPerl::Inline::ARGS{inc}  .= ' -I' . $RPerl::Inline::gsl_include_dir;  # enable GSL support) . "\n";
                        $file_line
                            .= q(        $RPerl::Inline::ARGS{auto_include} = [ @{ $RPerl::Inline::ARGS{auto_include} }, '#include <gsl_matrix.h>', '#include <gsl_blas.h>' ];    # enable GSL support)
                            . "\n";
                    }
                    else { $file_line = undef; }
                }



# START HERE: what else remains to be done w/ MongoDB support here???
# START HERE: what else remains to be done w/ MongoDB support here???
# START HERE: what else remains to be done w/ MongoDB support here???

                elsif ( $file_line eq ( '        # <<< CHANGE_ME: enable optional MongoDB support here >>>' . "\n" ) ) {
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $modes->{_enable_mongodb} = ' . Dumper($modes->{_enable_mongodb}) . "\n" );
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have $pm_file_path = ' . $pm_file_path . "\n" );
                    $pm_file_path = post_processor__INC_paths_delete($pm_file_path, 1, 0);  # $leading_slash_delete = 1, $leading_lib_delete = 0
                    $pm_file_path = post_processor__absolute_path_delete($pm_file_path);
                    $pm_file_path = post_processor__current_directory_path_delete($pm_file_path);
#                    RPerl::diag( 'in Compiler::post_processor_cpp__pmc_generate(), have possibly-trimmed $pm_file_path = ' . $pm_file_path . "\n" );
                    
                    if (    ( exists $modes->{_enable_mongodb} )
                        and ( defined $modes->{_enable_mongodb} )
                        and ( exists $modes->{_enable_mongodb}->{$pm_file_path} )
                        and ( defined $modes->{_enable_mongodb}->{$pm_file_path} )
                        and $modes->{_enable_mongodb}->{$pm_file_path} )
                    {
                        # DEV NOTE: linking instructions    http://mongodb.github.io/mongo-cxx-driver/mongocxx-v3/tutorial/ 
                        # g++ --std=c++11 ... $(pkg-config --cflags --libs libmongocxx) -Wl,-rpath,/usr/local/lib
                        $file_line = q(        $RPerl::Inline::ARGS{libs}  = '$(pkg-config --libs libmongocxx) -Wl,-rpath,' . $RPerl::Inline::mongodb_lib_dir;  # enable MongoDB support) . "\n";
                        $file_line .= q(        $RPerl::Inline::ARGS{inc}  .= ' $(pkg-config --cflags libmongocxx)';  # enable MongoDB support) . "\n";
                        # fix conflict between RPerl's use of "exp" exponent function from math.h (in rperloperations.h) & MongoDB BSON "exp" expected value (in bsoncxx/v_noabi/bsoncxx/third_party/mnmlstc/core/optional.hpp);
                        # error: expected ‘,’ or ‘...’    AND    note: in expansion of macro ‘exp’
                        $file_line .= q(        $RPerl::Inline::ARGS{auto_include} = [ @{ $RPerl::Inline::ARGS{auto_include} }, ) .
                                      q('#undef exp', '#include <mongocxx/client.hpp>', '#include <mongocxx/stdx.hpp>', '#include <mongocxx/uri.hpp>', ) .
                                      q('#include <mongocxx/instance.hpp>', '#include <bsoncxx/json.hpp>', '#include <bsoncxx/builder/stream/document.hpp>' ];    # enable MongoDB support) . "\n";
                    }
                    else { $file_line = undef; }
                }

                if ( defined $file_line ) { $source_group->{PMC} .= $file_line; }
            }





            close $FILE_HANDLE
                or die 'ERROR ECOCOFI04, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Cannot close file '
                . $module_pmc_filename_manual
                . ' after reading, '
                . $OS_ERROR
                . ', dying' . "\n";

            $module_name             = shift @{$module_names_split};
            $module_name_underscores = shift @{$module_names_underscores_split};
            $i++;
        }
    }
    return;
}

# Auto-Parallelize from Serial C++ File to Parallel C++ File via Pluto PolyCC & OpenMP
sub cpp_to_openmp_cpp {
    { my void $RETURN_TYPE };
    ( my string_hashref $cpp_output_file_name_group, my string_hashref $modes ) = @ARG;

    RPerl::diag( q{in Compiler::cpp_to_openmp_cpp(), received $cpp_output_file_name_group =} . "\n" . Dumper($cpp_output_file_name_group) . "\n" );

    #    RPerl::diag( q{in Compiler::cpp_to_openmp_cpp(), received $modes =} . "\n" . Dumper($modes) . "\n" );

    #    RPerl::diag( q{in Compiler::cpp_to_openmp_cpp(), NOT DOING ANYTHING YET} . "\n" );
    #    return;
    #    die 'TMP DEBUG';

    # START HERE: modify pluto min/max macros & calls, modify final g++ command
    # START HERE: modify pluto min/max macros & calls, modify final g++ command
    # START HERE: modify pluto min/max macros & calls, modify final g++ command

    # THEN START HERE, NEED FIX PARALLEL: enable non-pluto min/max sub calls, re-enable prints
    RPerl::verbose('PARALLELIZE:        Generate OpenMP Code...     ');

    my string $polycc_path = can_run('polycc');
    if ( not defined $polycc_path ) {
        die 'ERROR Exxxxx, COMPILER, PARALLELIZATION: Pluto PolyCC command `polycc` not found, dying';
    }
    my string $polycc_command
        = $polycc_path . q{ } . $cpp_output_file_name_group->{CPP} . ' -o ' . $cpp_output_file_name_group->{OPENMP_CPP} . ' --parallel --tile';

    RPerl::diag( 'in Compiler::cpp_to_openmp_cpp(), have $polycc_command =' . "\n\n" . $polycc_command . "\n" );

    # ACTUALLY RUN POLYCC COMMAND
    #    my $pid = open3( 0, \*POLYCC_STDOUT, \*POLYCC_STDERR, $polycc_command );    # disable STDIN w/ 0
    #
    #    my $stdout_select;
    #    my $stderr_select;
    #    if ( $OSNAME ne 'MSWin32' ) {
    #        $stdout_select = IO::Select->new();
    #        $stderr_select = IO::Select->new();
    #        $stdout_select->add( \*POLYCC_STDOUT );
    #        $stderr_select->add( \*POLYCC_STDERR );
    #    }
    #

    my string $polycc_command_stdout = q{};
    my string $polycc_command_stderr = q{};

    #if ( $OSNAME eq 'MSWin32' || $stdout_select->can_read(0) ) { sysread POLYCC_STDOUT, $polycc_command_stdout, 4096; }
	 #    if ( $OSNAME eq 'MSWin32' || $stderr_select->can_read(0) ) { sysread POLYCC_STDERR, $polycc_command_stderr, 4096; }
	 #    waitpid $pid, 0;
	 #    if ( $OSNAME eq 'MSWin32' || $stdout_select->can_read(0) ) { my $s; sysread POLYCC_STDOUT, $s, 4096; $polycc_command_stdout .= $s; }
	 #    if ( $OSNAME eq 'MSWin32' || $stderr_select->can_read(0) ) { my $s; sysread POLYCC_STDERR, $s, 4096; $polycc_command_stderr .= $s; }

    #my $pid = open3( 0, \*POLYCC_STDOUT, \*POLYCC_STDERR, $polycc_command );    # disable STDIN w/ 0
    run3( $polycc_command, \undef, \$polycc_command_stdout, \$polycc_command_stderr );

    my $test_exit_status = $CHILD_ERROR >> 8;

    #    RPerl::diag( 'in Compiler::cpp_to_openmp_cpp(), have $CHILD_ERROR = ' . $CHILD_ERROR . "\n" );
    #    RPerl::diag( 'in Compiler::cpp_to_openmp_cpp(), have $test_exit_status = ' . $test_exit_status . "\n" );

    RPerl::verbose( '         done.' . "\n" );

    #        if ($polycc_command_stdout) { RPerl::diag( "===STDOUT=BEGIN===\n" . $polycc_command_stdout . "===STDOUT=END===\n" ); }
    #        if ($polycc_command_stderr) { RPerl::diag( "===STDERR=BEGIN===\n" . $polycc_command_stderr . "===STDERR=END===\n" ); }
    my boolean $polycc_command_stdout_content = ( ( defined $polycc_command_stdout ) and ( $polycc_command_stdout =~ m/[^\s]+/g ) );
    my boolean $polycc_command_stderr_content = ( ( defined $polycc_command_stderr ) and ( $polycc_command_stderr =~ m/[^\s]+/g ) );

    if ( $polycc_command_stdout_content or $polycc_command_stderr_content ) {
        RPerl::diag("\n");
        if ($polycc_command_stdout_content) {
            RPerl::diag( '[[[ POLYCC STDOUT ]]]' . "\n\n" . $polycc_command_stdout . "\n" );
        }
        if ($polycc_command_stderr_content) {
            RPerl::diag( '[[[ POLYCC STDERR ]]]' . "\n\n" . $polycc_command_stderr . "\n" );
        }
        # NEED FIX PARALLEL: actually test polycc output for failure or error messages, etc.
#        if ( $test_exit_status == 0 ) {    # UNIX process return code 0, success
#            RPerl::warning( 'WARNING WCOCOSU00, COMPILER, POLYCC: Pluto PolyCC compiler returned success code but produced output which may indicate an error,' . "\n" . 'please run again with `rperl -D` command or RPERL_DEBUG=1 environmental variable for error messages or other output if none appear above' . "\n" );
#        }
    }

    if ($test_exit_status) {               # UNIX process return code not 0, error
        if ( not( $polycc_command_stdout_content or $polycc_command_stderr_content ) ) {
            RPerl::diag( "\n" . '[[[ POLYCC STDOUT & STDERR ARE BOTH EMPTY ]]]' . "\n\n" );
        }
        croak 'ERROR Exxxxx, COMPILER, POLYCC: Pluto PolyCC compiler returned error code,' . "\n"
            . 'please run again with `rperl -D` command or RPERL_DEBUG=1 environmental variable for error messages if none appear above,' . "\n"
            . 'croaking';
    }
    
    # NEED FIX PARALLEL: temporarily disable all user-defined or non-pluto uses of string 'min' and 'max' within parallel loop

    if (( not -e $cpp_output_file_name_group->{OPENMP_CPP} ) or ( not -f $cpp_output_file_name_group->{OPENMP_CPP} ) or ( not -T $cpp_output_file_name_group->{OPENMP_CPP} )) {
        die 'ERROR Exxxxx, COMPILER, PARALLELIZATION: Missing or invalid Pluto PolyCC output file, ' . q{'} . $cpp_output_file_name_group->{OPENMP_CPP} . q{'} . "\n" . ', dying' . "\n";
    }

    open my filehandleref $FILE_HANDLE_POLYCC, '<', $cpp_output_file_name_group->{OPENMP_CPP}
        or die 'ERROR Exxxxx, COMPILER, PARALLELIZATION: Cannot open Pluto PolyCC output file ' . q{'} . $cpp_output_file_name_group->{OPENMP_CPP} . q{'} . ' for reading,' . $OS_ERROR . ', dying' . "\n";

    # read in file, strip blank lines
    my string $file_line_polycc;
    my string $string_polycc = q{};
    while ( $file_line_polycc = <$FILE_HANDLE_POLYCC> ) {
        $file_line_polycc =~ s/min/polyccmin/gxms;
        $file_line_polycc =~ s/max/polyccmax/gxms;
        $string_polycc .= $file_line_polycc;
    }

    close $FILE_HANDLE_POLYCC
        or die 'ERROR Exxxxx, COMPILER, PARALLELIZATION: Cannot close file ' . q{'} . $cpp_output_file_name_group->{OPENMP_CPP} . q{'} . ' after reading, ' . $OS_ERROR . ', dying' . "\n";

    open $FILE_HANDLE_POLYCC, '>', $cpp_output_file_name_group->{OPENMP_CPP}
        or die 'ERROR Exxxxx, COMPILER, PARALLELIZATION: Cannot open Pluto PolyCC output file ' . q{'} . $cpp_output_file_name_group->{OPENMP_CPP} . q{'} . ' for writing,' . $OS_ERROR . ', dying' . "\n";

    print {$FILE_HANDLE_POLYCC} $string_polycc;

    close $FILE_HANDLE_POLYCC
        or die 'ERROR Exxxxx, COMPILER, PARALLELIZATION: Cannot close file ' . q{'} . $cpp_output_file_name_group->{OPENMP_CPP} . q{'} . ' after writing, ' . $OS_ERROR . ', dying' . "\n";
    return;
}

# Sub-Compile from C++-Parsable String to Perl-Linkable XS & Machine-Readable Binary
sub cpp_to_xsbinary__subcompile {
    { my void $RETURN_TYPE };
    ( my string_hashref $cpp_output_file_name_group, my string_hashref $modes ) = @ARG;

  #    RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), received $cpp_output_file_name_group =} . "\n" . Dumper($cpp_output_file_name_group) . "\n" );
  #    RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), received $modes =} . "\n" . Dumper($modes) . "\n" );

    if ( ( $modes->{_input_file_name} =~ /[.]pl$/xms ) or ( $modes->{subcompile} ne 'DYNAMIC' ) ) {
        RPerl::verbose('SUBCOMPILE:         Generate binary...     ');

        if ( $modes->{subcompile} eq 'OFF' ) {
            croak 'ERROR ECOCOSU00, COMPILER, SUBCOMPILE: Received incorrect subcompile mode OFF while inside subcompile subroutine, croaking';
        }
        elsif ( ( $modes->{subcompile} ne 'ASSEMBLE' )
            and ( $modes->{subcompile} ne 'ARCHIVE' )
            and ( $modes->{subcompile} ne 'SHARED' )
            and ( $modes->{subcompile} ne 'STATIC' )
            and ( $modes->{subcompile} ne 'DYNAMIC' ) )
        {
            croak 'ERROR ECOCOSU01, COMPILER, SUBCOMPILE: Received invalid subcompile mode ' . q{'}
                . $modes->{subcompile} . q{'}
                . ' while inside subcompile subroutine, croaking';
        }

        my string $subcompile_command = $modes->{CXX};
        my string $subcompile_command_append = q{};

        if (   ( $modes->{subcompile} eq 'ASSEMBLE' )
            or ( $modes->{subcompile} eq 'ARCHIVE' ) )
        {
            # stop the subcompiler after the assemble phase, output .o file; not in original Inline::CPP subcompile command
            $subcompile_command .= q{ } . '-c';
        }
        elsif (( $modes->{subcompile} eq 'STATIC' )
            or ( $modes->{subcompile} eq 'DYNAMIC' ) )
        {
            # Perl requires pthreads, at least Perls compiled with thread support do; not in original Inline::CPP subcompile command
            # NEED ANSWER: test for non-threaded Perl to avoid including pthread support?
            $subcompile_command .= q{ } . '-pthread';
        }

        my string $ccflags = [ config_re('ccflags') ]->[0];
        substr $ccflags, 0,  9, q{};    # remove leading ccflags='
        substr $ccflags, -1, 1, q{};    # remove trailing '
        $subcompile_command .= q{ } . $ccflags;

        $subcompile_command .= q{ } . '-xc++';    # force C++ language mode

        # using RPerl::BASE_PATH instead of substr $RPerl::INCLUDE_PATH
        #        if ( ( ( substr $RPerl::INCLUDE_PATH, -4, 4 ) eq '/lib' ) or ( ( substr $RPerl::INCLUDE_PATH, -4, 4 ) eq '\lib' ) ) {
        #            $subcompile_command .= q{ } . '-I"' . ( substr $RPerl::INCLUDE_PATH, 0, -4 ) . '"';    # remove trailing /lib or \lib
        #        }

        $subcompile_command .= q{ } . '-I"' . $RPerl::BASE_PATH . '"';
        $subcompile_command .= q{ } . '-I"' . $RPerl::INCLUDE_PATH . '"'; # different than original Inline::CPP subcompile command, double-quotes added to encapsulate user-name directories
        $subcompile_command .= q{ } . '-I. -Ilib';

        # DEV NOTE: must have $pl_file_path for support checking below; GMP, GSL, MongoDB 
#        RPerl::diag( 'in Compiler::cpp_to_xsbinary__subcompile(), have $modes->{_enable_mongodb} = ' . Dumper($modes->{_enable_mongodb}) . "\n" );
        my string $pl_file_path = $modes->{_input_file_name};
#        RPerl::diag( 'in Compiler::cpp_to_xsbinary__subcompile(), have $pl_file_path = ' . $pl_file_path . "\n" );
        $pl_file_path = post_processor__INC_paths_delete($pl_file_path, 1, 0);  # $leading_slash_delete = 1, $leading_lib_delete = 0
        $pl_file_path = post_processor__absolute_path_delete($pl_file_path);
        $pl_file_path = post_processor__current_directory_path_delete($pl_file_path);
#        RPerl::diag( 'in Compiler::cpp_to_xsbinary__subcompile(), have possibly-trimmed $pl_file_path = ' . $pl_file_path . "\n" );

        # GMP support
        if (    ( exists $modes->{_enable_gmp} )
            and ( defined $modes->{_enable_gmp} )
            and ( exists $modes->{_enable_gmp}->{$pl_file_path} )
            and ( defined $modes->{_enable_gmp}->{$pl_file_path} )
            and $modes->{_enable_gmp}->{$pl_file_path} )
        {
            $subcompile_command .= q{ } . '-I"' . $RPerl::Inline::gmp_include_dir . '"';
        }

        # GSL support
        if (    ( exists $modes->{_enable_gsl} )
            and ( defined $modes->{_enable_gsl} )
            and ( exists $modes->{_enable_gsl}->{$pl_file_path} )
            and ( defined $modes->{_enable_gsl}->{$pl_file_path} )
            and $modes->{_enable_gsl}->{$pl_file_path} )
        {
            $subcompile_command .= q{ } . '-I"' . $RPerl::Inline::gsl_include_dir . '"';
        }

        # MongoDB support
        if (    ( exists $modes->{_enable_mongodb} )
            and ( defined $modes->{_enable_mongodb} )
            and ( exists $modes->{_enable_mongodb}->{$pl_file_path} )
            and ( defined $modes->{_enable_mongodb}->{$pl_file_path} )
            and $modes->{_enable_mongodb}->{$pl_file_path} )
        {
            $subcompile_command .= q{ } . '$(pkg-config --cflags libmongocxx)';
            $subcompile_command_append .= q{ } . '$(pkg-config --libs libmongocxx) -Wl,-rpath,' . $RPerl::Inline::mongodb_lib_dir;
        }

        $subcompile_command .= q{ } . '-I"' . $RPerl::Inline::pcre2_include_dir . '"';   # for regex support
        $subcompile_command .= q{ } . '-I"' . $RPerl::Inline::jpcre2_include_dir . '"';  # for regex support

        $subcompile_command .= q{ } . $RPerl::Inline::CCFLAGSEX;
        $subcompile_command .= q{ } . '-D__' . $modes->{types} . '__TYPES'; # same as #define __PERL__TYPES or #define__CPP__TYPES; don't just use hard-coded $RPerl::TYPES_CCFLAG
        $subcompile_command .= q{ } . '-D__TYPE__INTEGER__' . $modes->{type_integer};
        $subcompile_command .= q{ } . '-D__TYPE__NUMBER__' . $modes->{type_number};
        $subcompile_command .= q{ } . $RPerl::Inline::ARGS{optimize};

        $subcompile_command .= q{ } . '-DVERSION=\"0.00\" -DXS_VERSION=\"0.00\"';    # NEED ANSWER: what does this do?

        my string $cccdlflags = [ config_re('cccdlflags') ]->[0];
        substr $cccdlflags, 0,  12, q{};                                             # remove leading cccdlflags='
        substr $cccdlflags, -1, 1,  q{};                                             # remove trailing '
        $subcompile_command .= q{ } . $cccdlflags;

        if ( $RPerl::CORE_PATH eq q{} ) {
            croak 'ERROR ECOCOSU02, COMPILER, SUBCOMPILE: Perl source code CORE directory or CORE/perl.h file not found in @INC path listing, croaking';
        }
        $subcompile_command .= q{ } . '"-I' . $RPerl::CORE_PATH . '"';




        if ($modes->{parallel} eq 'OFF') {
            $subcompile_command .= q{ } . $cpp_output_file_name_group->{CPP};
            $subcompile_command .= q{ } . '-o ';
    
            if (   ( $modes->{subcompile} eq 'ASSEMBLE' )
                or ( $modes->{subcompile} eq 'ARCHIVE' ) )
            {
                $subcompile_command .= q{ } . $cpp_output_file_name_group->{O};
            }
            elsif ( $modes->{subcompile} eq 'SHARED' ) {
                $subcompile_command .= q{ } . $cpp_output_file_name_group->{SO};
            }
            elsif (( $modes->{subcompile} eq 'STATIC' )
                or ( $modes->{subcompile} eq 'DYNAMIC' ) )
            {
                $subcompile_command .= q{ } . $cpp_output_file_name_group->{EXE};
            }
        }
        elsif ($modes->{parallel} eq 'OPENMP') {
            $subcompile_command .= q{ } . '-mtune=native -ftree-vectorize -DTIME -fopenmp';
            $subcompile_command .= q{ } . $cpp_output_file_name_group->{OPENMP_CPP};
            $subcompile_command .= q{ } . '-o ';
    
            # NEED FIX PARALLEL: handle other subcompile modes???
            if (( $modes->{subcompile} eq 'STATIC' )
                or ( $modes->{subcompile} eq 'DYNAMIC' ) )
            {
                $subcompile_command .= q{ } . $cpp_output_file_name_group->{OPENMP_EXE};
            }
        }

        # some subcompile arguments must be at the end of the command (presumably after the filenames?)
        $subcompile_command .= $subcompile_command_append;

        if ( $modes->{subcompile} eq 'SHARED' ) {
            $subcompile_command .= q{ } . '-shared';
        }
        elsif ( $modes->{subcompile} eq 'STATIC' ) {
            $subcompile_command .= q{ } . '-static';
        }

        if (   ( $modes->{subcompile} eq 'STATIC' )
            or ( $modes->{subcompile} eq 'DYNAMIC' ) )
        {
            if ($modes->{parallel} eq 'OPENMP') {
                $subcompile_command .= q{ } . '-lm';    # not in original Inline::CPP subcompile command
            }
            $subcompile_command .= q{ } . '-lperl';    # not in original Inline::CPP subcompile command
            # DEV NOTE, CORRELATION #rp300: must link against all bit width libs to allow automatic selection
            $subcompile_command .= q{ } . '-lpcre2-8 -lpcre2-16 -lpcre2-32';  # for regex support, not in original Inline::CPP subcompile command
        }

        if ( $modes->{subcompile} eq 'STATIC' ) {
            $subcompile_command .= q{ } . '-lcrypt';    # not in original Inline::CPP subcompile command
        }

        if ( $modes->{subcompile} eq 'ARCHIVE' ) {
            $subcompile_command .= q{ } . ' ; ar -cvq ' . $cpp_output_file_name_group->{A} . q{ } . $cpp_output_file_name_group->{O};

            # NEED ANSWER: is this always the correct output redirect mechanism M$ Windows?  I think it is correct for cmd.exe, but what about Cygwin, etc?
            if   ( $OSNAME eq 'MSWin32' ) { $subcompile_command .= q{ } . ' > nul'; }
            else                          { $subcompile_command .= q{ } . ' > /dev/null'; }
        }
	#	my $pid = open3( 0, \*SUBCOMPILE_STDOUT, \*SUBCOMPILE_STDERR, $subcompile_command );    # disable STDIN w/ 0
	#
	#        my $stdout_select;
	#        my $stderr_select;
	#        if ( $OSNAME ne 'MSWin32' ) {
	#            $stdout_select = IO::Select->new();
	#            $stderr_select = IO::Select->new();
	#            $stdout_select->add( \*SUBCOMPILE_STDOUT );
	#            $stderr_select->add( \*SUBCOMPILE_STDERR );
	#        }
	#

#        RPerl::diag( "\n" . 'in Compiler::cpp_to_xsbinary__subcompile(), have $subcompile_command =' . "\n\n" . $subcompile_command . "\n\n" );
        RPerl::diag(  "\n\n" . $subcompile_command . "\n\n" );
        if ( $ENV{RPERL_VERBOSE} or $RPerl::VERBOSE ) { RPerl::diag(  q{SUBCOMPILE:         Generate binary...     } ); }

	# if ( $OSNAME eq 'MSWin32' || $stdout_select->can_read(0) ) { sysread SUBCOMPILE_STDOUT, $subcompile_command_stdout, 4096; }
	#        if ( $OSNAME eq 'MSWin32' || $stderr_select->can_read(0) ) { sysread SUBCOMPILE_STDERR, $subcompile_command_stderr, 4096; }
	#        waitpid $pid, 0;
	#        if ( $OSNAME eq 'MSWin32' || $stdout_select->can_read(0) ) { my $s; sysread SUBCOMPILE_STDOUT, $s, 4096; $subcompile_command_stdout .= $s; }
	#        if ( $OSNAME eq 'MSWin32' || $stderr_select->can_read(0) ) { my $s; sysread SUBCOMPILE_STDERR, $s, 4096; $subcompile_command_stderr .= $s; }

        # ACTUALLY RUN SUBCOMPILE COMMAND
        my string $subcompile_command_stdout = q{};
        my string $subcompile_command_stderr = q{};

    	#my $pid = open3( 0, \*SUBCOMPILE_STDOUT, \*SUBCOMPILE_STDERR, $subcompile_command );    # disable STDIN w/ 0
    	run3( $subcompile_command, \undef, \$subcompile_command_stdout, \$subcompile_command_stderr );

        my $test_exit_status = $CHILD_ERROR >> 8;

        #    RPerl::diag( 'in Compiler::cpp_to_xsbinary__subcompile(), have $CHILD_ERROR = ' . $CHILD_ERROR . "\n" );
        #    RPerl::diag( 'in Compiler::cpp_to_xsbinary__subcompile(), have $test_exit_status = ' . $test_exit_status . "\n" );

        RPerl::verbose( '         done.' . "\n" );

        # delete temporary .o file
        if ( $modes->{subcompile} eq 'ARCHIVE' ) {
            if ( -f $cpp_output_file_name_group->{O} ) {
                unlink( $cpp_output_file_name_group->{O} )
                    or croak( "\n"
                        . 'ERROR ECOCOSU03, COMPILER, SUBCOMPILE: Cannot delete temporary object file ' . q{'}
                        . $cpp_output_file_name_group->{O} . q{'} . ',' . "\n"
                        . 'croaking:'
                        . $OS_ERROR );
            }
        }

        #        if ($subcompile_command_stdout) { RPerl::diag( "===STDOUT=BEGIN===\n" . $subcompile_command_stdout . "===STDOUT=END===\n" ); }
        #        if ($subcompile_command_stderr) { RPerl::diag( "===STDERR=BEGIN===\n" . $subcompile_command_stderr . "===STDERR=END===\n" ); }
        my boolean $subcompile_command_stdout_content = ( ( defined $subcompile_command_stdout ) and ( $subcompile_command_stdout =~ m/[^\s]+/g ) );
        my boolean $subcompile_command_stderr_content = ( ( defined $subcompile_command_stderr ) and ( $subcompile_command_stderr =~ m/[^\s]+/g ) );

        if ( $subcompile_command_stdout_content or $subcompile_command_stderr_content ) {
            RPerl::diag("\n");
            if ($subcompile_command_stdout_content) {
                RPerl::diag( '[[[ SUBCOMPILE STDOUT ]]]' . "\n\n" . $subcompile_command_stdout . "\n" );
            }
            if ($subcompile_command_stderr_content) {
                RPerl::diag( '[[[ SUBCOMPILE STDERR ]]]' . "\n\n" . $subcompile_command_stderr . "\n" );
            }
            if ( $test_exit_status == 0 ) {    # UNIX process return code 0, success
                RPerl::warning(
                          'WARNING WCOCOSU00, COMPILER, SUBCOMPILE: C++ compiler returned success code but produced output which may indicate an error,' . "\n"
                        . 'please run again with `rperl -D` command or RPERL_DEBUG=1 environmental variable for error messages or other output if none appear above'
                        . "\n" );
            }
        }

        if ($test_exit_status) {               # UNIX process return code not 0, error
            if ( not( $subcompile_command_stdout_content or $subcompile_command_stderr_content ) ) {
                RPerl::diag( "\n" . '[[[ SUBCOMPILE STDOUT & STDERR ARE BOTH EMPTY ]]]' . "\n\n" );
            }
            croak 'ERROR ECOCOSU04, COMPILER, SUBCOMPILE: C++ compiler returned error code,' . "\n"
                . 'please run again with `rperl -D` command or RPERL_DEBUG=1 environmental variable for error messages if none appear above,' . "\n"
                . 'croaking';
        }
    }
    else {                                     # *.pm module files
        RPerl::verbose('SUBCOMPILE:         Generate XS & binary...');

        ( my string $volume_pmc, my string $directories_pmc, my string $file_pmc )
            = File::Spec->splitpath( $cpp_output_file_name_group->{PMC}, my $no_file = 0 );

        #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have $directories_pmc = } . $directories_pmc . "\n" );

        # strip trailing / or \ as long as they are not the only characters, which could indicate the root directory
        if (    ( ( length $directories_pmc ) > 1 )
            and ( ( ( substr $directories_pmc, -1, 1 ) eq q{/} ) or ( ( substr $directories_pmc, -1, 1 ) eq q{\\} ) ) )
        {
            substr $directories_pmc, -1, 1, q{};
        }

        my @INC_sorted = sort { length $b <=> length $a } @INC;

        #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have @INC =} . "\n" . Dumper(\@INC) . "\n" );
        #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have @INC_sorted =} . "\n" . Dumper(\@INC_sorted) . "\n" );

        # strip leading INC directory if present
        # DEV NOTE, CORRELATION #rp055: handle removal of current directory & all @INC directories, so as not to hard-code system-specific dirs in #include statements
        $directories_pmc = post_processor__INC_paths_delete($directories_pmc, 0, 1);  # $leading_slash_delete = 0, $leading_lib_delete = 1

        #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have POSSIBLY-MODIFIED $directories_pmc = } . $directories_pmc . "\n" );

        my string_arrayref $directories_pmc_split = [ File::Spec->splitdir($directories_pmc) ];

        #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have $directories_pmc_split =} . "\n" . Dumper($directories_pmc_split) . "\n" );

        # discard '.' or empty directory names
        my $directories_pmc_split_tmp = [];
        foreach my $directory ( @{$directories_pmc_split} ) {
            if ( ( $directory ne q{.} ) and ( $directory ne q{} ) ) {
                push @{$directories_pmc_split_tmp}, $directory;
            }
        }
        $directories_pmc_split = $directories_pmc_split_tmp;

        # strip trailing .pmc file suffix
        substr $file_pmc, -4, 4, q{};

        my string $eval_string = join '::', @{$directories_pmc_split}, $file_pmc;
        $eval_string = 'use ' . $eval_string . ';';

        #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have $eval_string =} . "\n" . $eval_string . "\n" );

        # NEED FIX: why does Inline::CPP require double-subcompiling???
        # DEV NOTE: exec() and system() don't work, only backticks

        #    `export RPERL_WARNINGS=0; perl -e '$eval_string'`;  # should build
        #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), done with backticks 1...} . "\n" );

        #    `export RPERL_WARNINGS=0; perl -e '$eval_string'`;  # should not build, but does
        #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), done with backticks 2...} . "\n" );

        #    `export RPERL_WARNINGS=0; perl -e '$eval_string'`;  # should not build, does not seem to
        #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), done with backticks 3...} . "\n" );

        RPerl::verbose( '     deferred.' . "\n" );
    }
    return;
}

1;    # end of class

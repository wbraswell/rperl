## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: OFF >>>

# [[[ HEADER ]]]
package RPerl::Compiler;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.007_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitStringyEval) # SYSTEM DEFAULT 1: allow eval()
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

# [[[ SUBROUTINES ]]]

our string_arrayref $find_dependencies = sub {
    ( my string $file_name, my string_hashref $modes ) = @_;
    my string_arrayref $dependencies = [];

    #    RPerl::diag( 'in Compiler::find_dependencies(), received $file_name = ' . $file_name . "\n" );

    if ( not -f $file_name ) {
        die 'ERROR ECVCODE00, COMPILER, FIND DEPENDENCIES: File not found, ' . q{'} . $file_name . q{'} . "\n" . ', dying' . "\n";
    }

    open my filehandleref $FILE_HANDLE, '<', $file_name
        or die 'ERROR ECVCODE01, COMPILER, FIND DEPENDENCIES: Cannot open file ' . $file_name . ' for reading, ' . $OS_ERROR . ', dying' . "\n";

    # read in input file, match on 'use' includes for dependencies
    my string $file_line;
    my string $first_package_name = undef;
    my string $eval_string;
    my integer $eval_retval;

    # NEED FIX: do not make recursive calls until after closing file, to avoid
    # ERROR ECVCODE01, COMPILER, FIND DEPENDENCIES: Cannot open file Foo/Bar.pm for reading, Too many open files, dying
    while ( $file_line = <$FILE_HANDLE> ) {
        if ( ( $file_line =~ /^\s*package\s+[\w:]+\s*;\s*$/xms ) and ( not defined $first_package_name ) ) {
            $first_package_name = $file_line;
            $first_package_name =~ s/^\s*package\s+([\w:]+)\s*;\s*$/$1/gxms;
            $eval_string = 'use ' . $first_package_name . '; 1;';

            #        	RPerl::diag('in Compiler::find_dependencies(), about to call NON-DEP $eval_string = ' . $eval_string . "\n");
            $eval_retval = eval($eval_string);

##        	RPerl::diag('in Compiler::find_dependencies(), have POST-EVAL NON-DEP %INC = ' . Dumper(\%INC) . "\n");
            # warn instead of dying on eval error here and below, in order to preserve proper parser errors instead of weird eval errors
            # in RPerl/Test/*/*Bad*.pm and RPerl/Test/*/*bad*.pl
            if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
                RPerl::warning(
                    'WARNING WCVCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package ' . $first_package_name . '  ...  ' . $EVAL_ERROR . "\n" );
            }
        }

        # NEED FIX: remove hard-coded list of not-subdependency uses
        if ( $file_line =~ /^\s*use\s+[\w:]+/xms ) {
            if (   ( $file_line =~ /use\s+strict\s*;/ )
                or ( $file_line =~ /use\s+warnings\s*;/ )
                or ( $file_line =~ /use\s+RPerl::CompileUnit::Module::Class\s*;/ )
                or ( $file_line =~ /use\s+RPerl::Class\s*;/ )
                or ( $file_line =~ /use\s+RPerl\s*;/ )
                or ( $file_line =~ /use\s+RPerl::AfterSubclass\s*;/ )
                or ( $file_line =~ /use\s+RPerl::Config\s*;/ )
                or ( $file_line =~ /use\s+parent/ )
                or ( $file_line =~ /use\s+constant/ )
                or ( $file_line =~ /use\s+overload/ )
                or ( $file_line =~ /use\s+[0-9]/ ) )
            {
                # safely ignore these possibly-valid but not-subdependency uses
                next;
            }
            elsif ( $file_line =~ /use\s+rperlsse\s*;/ ) {
#            	RPerl::diag('in Compiler::find_dependencies(), found rperlsse line, have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
                if ((substr $Config{archname}, 0, 3) eq 'arm') {
                    die q{ERROR ECVCODE05, COMPILER, FIND DEPENDENCIES: 'use rperlsse;' command found but SSE not supported on Arm architecture, file } . $file_name . ', dying' . "\n";
                }
                if ((not exists $modes->{_enable_sse}) or (not defined $modes->{_enable_sse})) {
                    $modes->{_enable_sse} = {};
                }
                $modes->{_enable_sse}->{$file_name} = 1;
#            	RPerl::diag('in Compiler::find_dependencies(), after finding rperlsse line, have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
                next;
            }
            elsif ( $file_line =~ /use\s+rperlgmp\s*;/ ) {
#            	RPerl::diag('in Compiler::find_dependencies(), found rperlgmp line, have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
                if ((not exists $modes->{_enable_gmp}) or (not defined $modes->{_enable_gmp})) {
                    $modes->{_enable_gmp} = {};
                }
                $modes->{_enable_gmp}->{$file_name} = 1;
#            	RPerl::diag('in Compiler::find_dependencies(), after finding rperlgmp line, have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
                next;
            }

            if ( $file_line =~ /use\s+lib/ ) {
                die
                    q{ERROR ECVCODE02, COMPILER, FIND DEPENDENCIES: 'use lib...' not currently supported, please set @INC using the PERL5LIB environment variable, file } . $file_name . ', dying'
                    . "\n";
            }

            $file_line =~ s/^\s*use\s+([\w:]+)\s*.*\s*;\s*$/$1/gxms;    # remove everything except the package name
            $eval_string = 'use ' . $file_line . '; 1;';

            #            RPerl::diag( 'in Compiler::find_dependencies(), about to call DEP $eval_string = ' . $eval_string . "\n" );
            $eval_retval = eval($eval_string);

            #            RPerl::diag('in Compiler::find_dependencies(), have POST-EVAL DEP %INC = ' . Dumper(\%INC) . "\n");
            if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
                RPerl::warning( 'WARNING WCVCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package ' . $file_line . '  ...  ' . $EVAL_ERROR . "\n" );
            }
            $file_line =~ s/::/\//gxms;                                 # replace double-colon :: scope delineator with forward-slash / directory delineator
            $file_line .= '.pm';
            if ( not exists $INC{$file_line} ) {
                die 'ERROR ECVCODE03, COMPILER, FIND DEPENDENCIES: After successful eval-use, still failed to find package file '
                    . $file_line
                    . ' in %INC, file ' . $file_name . ', dying' . "\n";
            }

            #            RPerl::diag( 'in Compiler::find_dependencies(), have MATCHING $file_line = ' . $file_line . "\n" );
            #            RPerl::diag( 'in Compiler::find_dependencies(), have $INC{$file_line} = ' . $INC{$file_line} . "\n" );
            push @{$dependencies}, $INC{$file_line};

            #            RPerl::diag( 'in Compiler::find_dependencies(), have PRE-SUBDEPS $dependencies = ' . Dumper($dependencies) . "\n" );

            my string_arrayref $subdependencies = find_dependencies( $INC{$file_line}, $modes );

            # discard duplicate dependencies that now appear in subdependencies
            $dependencies = [ uniq @{$subdependencies}, @{$dependencies} ];

            #            RPerl::diag( 'in Compiler::find_dependencies(), have POST-SUBDEPS $dependencies = ' . Dumper($dependencies) . "\n" );
        }
    }

    close $FILE_HANDLE
        or die 'ECVCODE04, COMPILER, FIND DEPENDENCIES: Cannot close file ' . $file_name . ' after reading, ' . $OS_ERROR . ', dying' . "\n";

    #    RPerl::diag( 'in Compiler::find_dependencies(), returning $dependencies = ' . Dumper($dependencies) . "\n" );
#    RPerl::diag('in Compiler::find_dependencies(), about to return, have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
#    RPerl::diag('in Compiler::find_dependencies(), about to return, have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
    return $dependencies;
};

# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]

our string_hashref $rperl_to_rperl__parse_generate = sub {
    ( my string $rperl_input_file_name, my string_hashref $rperl_output_file_name_group, my string_hashref $rperl_source_group, my string_hashref $modes ) = @_;
    my object $rperl_ast;

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
};

# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]

our string_hashref $rperl_to_xsbinary__parse_generate_compile = sub {
    ( my string $rperl_input_file_name, my string_hashref $cpp_output_file_name_group, my string_hashref $cpp_source_group, my string_hashref $modes ) = @_;
    my object $rperl_ast;

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

    # [[[ SUBCOMPILE C++ TO XS & BINARY ]]]

    if (   ( $modes->{compile} eq 'SUBCOMPILE' )
        or ( $modes->{compile} eq 'SUBCOMPILE_DEFERRED' ) )
    {
        cpp_to_xsbinary__subcompile( $cpp_output_file_name_group );
    }

    # always return $cpp_source_group to maintain consistent return type,
    # only utilized for GENERATE compile mode during dependencies
    return $cpp_source_group;
};

# generate output file name group(s) based on input file name(s)
#sub generate_output_file_names {
our hashref_arrayref $generate_output_file_names = sub {
    ( my string_arrayref $input_file_names, my string_arrayref $output_file_name_prefixes, my integer $input_files_count, my string_hashref $modes ) = @_;

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

                # DEV NOTE: correlates to errors EARG* in script/rperl
                die "ERROR EARG09: Invalid RPerl source code output file option specified, dying\n";
            }
        }

        # if output file prefix(es) not provided, then generate output file name(s) from input file name(s)
        else {
            #            RPerl::diag('have $input_file_name = ' . $input_file_name . "\n");
            # should not already be only prefix, fileparse() to isolate prefix
            ( $input_file_name_prefix, $input_file_name_path, $input_file_name_suffix ) = fileparse( $input_file_name, qr/[.][^.]*/xms );
        }

        #        RPerl::diag('$output_file_name_groups->[' . $i . ']' . "\n" . Dumper($output_file_name_groups->[$i]) . "\n");

        my string $output_file_name_path_prefix = $input_file_name_path . $input_file_name_prefix;

        # all *.pl input files require EXE output file
        if ( $input_file_name =~ /[.]pl$/xms ) {

            # Micro$oft Windows uses *.exe file extension (suffix) for compiled executables
            if ( $OSNAME eq 'MSWin32' ) {
                $output_file_name_groups->[$i]->{EXE} = $output_file_name_path_prefix . '.exe';
            }

            # traditionally, *NIX has no file extension (suffix) for compiled executables
            else {
                $output_file_name_groups->[$i]->{EXE} = $output_file_name_path_prefix;
            }

            if ( $modes->{ops} eq 'CPP' ) {

                # *.pl input files in CPPOPS mode requires PMC loader module; *.pl input files in PERLOPS test mode does not require PMC file, only EXE file
                $output_file_name_groups->[$i]->{PMC} = $output_file_name_path_prefix . '.pmc';
            }
        }
        else {    # all *.pm input files require PMC output file; PMC is the only output file for *.pm input files in PERLOPS mode
            $output_file_name_groups->[$i]->{PMC} = $output_file_name_path_prefix . '.pmc';
        }

        # all CPP ops modes require CPP & H output files
        if ( $modes->{ops} eq 'CPP' ) {
            $output_file_name_groups->[$i]->{CPP} = $output_file_name_path_prefix . '.cpp';
            $output_file_name_groups->[$i]->{H}   = $output_file_name_path_prefix . '.h';
        }

#        RPerl::diag('in rperl::generate_output_file_names(), bottom of loop ' . $i . ' of ' . $input_files_count . ", have \$output_file_name_groups->[$i] = \n" . Dumper( $output_file_name_groups->[$i] ) . "\n");
    }

    return $output_file_name_groups;
};

# Write Source Code Files To File System
our void $save_source_files = sub {
    ( my string_hashref $source_group, my string_hashref $file_name_group, my string_hashref $modes ) = @_;

    #    RPerl::diag( q{in Compiler::save_source_files(), received $source_group =} . "\n" . Dumper($source_group) . "\n" );
    #    RPerl::diag( q{in Compiler::save_source_files(), received $file_name_group =} . "\n" . Dumper($file_name_group) . "\n" );
    #    RPerl::diag( 'in Compiler::save_source_files(), received $modes->{_symbol_table} =' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );

    foreach my string $suffix_key ( sort keys %{$source_group} ) {
        if ( ( substr $suffix_key, 0, 1 ) eq '_' ) { next; }
        if (   ( not exists $file_name_group->{$suffix_key} )
            or ( not defined $file_name_group->{$suffix_key} )
            or ( $file_name_group->{$suffix_key} eq q{} ) )
        {
            croak("\nERROR ECVCOFI00, COMPILER, SAVE OUTPUT FILES: Expecting file name for suffix '$suffix_key', but received empty or no value, croaking");
        }
    }

    # finally create PMC file and set H path in CPP file for CPPOPS
    if ( $modes->{ops} eq 'CPP' ) {
        RPerl::verbose('SAVE  PHASE 0:      Final file modifications...    ');

        if ( $source_group->{PMC} ne q{} ) {
            die 'ERROR ECVCOFI01, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Received non-empty PMC source, dying' . "\n";
        }

        # NEED FIX WIN32: handle back-slash for Win32 instead of forward-slash only for *NIX

        my string $module_path              = $file_name_group->{CPP};
        my string $module_header_path_nolib = $file_name_group->{H};

        # DEV NOTE: barely-documented Inline::CPP bug, must have leading './' if no other directories in path
        if (( $OSNAME eq 'MSWin32' ) and ( $module_path !~ /\\/ )) {
            $module_path .= q{.\\};
        }
        elsif ( $module_path !~ /\// ) {
            $module_path .= q{./};
        }
 
        # remove leading '.\' or './' if present
        if ((( $OSNAME eq 'MSWin32' ) and (( substr $module_header_path_nolib, 0, 2 ) eq q{.\\} ))
            or (( substr $module_header_path_nolib, 0, 2 ) eq './' )) {
            substr $module_header_path_nolib, 0, 2, q{};
        }

        # remove leading 'lib/' if present, because -Ilib enabled in RPerl/Inline.pm
        if ((( $OSNAME eq 'MSWin32' ) and (( substr $module_header_path_nolib, 0, 4 ) eq 'lib\\' ))
            or (( substr $module_header_path_nolib, 0, 4 ) eq 'lib/' )) {
            substr $module_header_path_nolib, 0, 4, q{};
        }

        # deferred, finally set path to H module header file in CPP module file
        $source_group->{CPP} =~ s/__NEED_MODULE_HEADER_PATH/$module_header_path_nolib/gxms;

        # deferred, finally change hard-coded PERLOPS_PERLTYPES to CPPOPS_*TYPES
        my string $mode_tagline = $modes->{ops} . 'OPS_' . $modes->{types} . 'TYPES';
        $source_group->{H} =~ s/PERLOPS_PERLTYPES/$mode_tagline/gxms;
        $source_group->{CPP} =~ s/PERLOPS_PERLTYPES/$mode_tagline/gxms;

#        RPerl::diag( q{in Compiler::save_source_files(), have %INC = } . Dumper(\%INC) . "\n" );
#        RPerl::diag( q{in Compiler::save_source_files(), have @INC = } . Dumper(\@INC) . "\n" );
#        RPerl::diag( q{in Compiler::save_source_files(), have $source_group->{_package_names_underscores} = } . Dumper($source_group->{_package_names_underscores}) . "\n" );
#        RPerl::diag( q{in Compiler::save_source_files(), have $source_group->{_package_names} = } . Dumper($source_group->{_package_names}) . "\n" );

        my string_arrayref $module_names_split = [(split /\n/, $source_group->{_package_names})];
        my string_arrayref $module_names_underscores_split = [(split /\n/, $source_group->{_package_names_underscores})];
#        RPerl::diag( q{in Compiler::save_source_files(), have $module_names_split = } . Dumper($module_names_split) . "\n" );
 
        my integer $module_count           = scalar @{ $module_names_split };
        my string $module_name = shift @{ $module_names_split };
        my string $module_name_underscores = shift @{ $module_names_underscores_split };
        my integer $i = 0;

        while ( defined $module_name_underscores ) {
#            RPerl::diag( q{in Compiler::save_source_files(), have $module_path = } . $module_path . "\n" );
#            RPerl::diag( q{in Compiler::save_source_files(), have $module_name_underscores = } . $module_name_underscores . "\n" );

            # utilize modified copies of Module PMC template file
            my string $module_pmc_filename_manual;
            if ($module_count == 1) {
                $module_pmc_filename_manual = $RPerl::INCLUDE_PATH . '/RPerl/CompileUnit/Module.pmc.CPPOPS_DUALTYPES';
            }
            else {
                if ($i == ($module_count - 1)) {
                    $module_pmc_filename_manual = $RPerl::INCLUDE_PATH . '/RPerl/CompileUnit/Module.pmc.CPPOPS_DUALTYPES_MONOLITH';
                }
                else {
                    $module_pmc_filename_manual = $RPerl::INCLUDE_PATH . '/RPerl/CompileUnit/Module.pmc.CPPOPS_DUALTYPES_MONOLITH_SECONDARY';
                }
            }

#            RPerl::diag( 'in Compiler::save_source_files(), have $module_pmc_filename_manual = ' . $module_pmc_filename_manual . "\n" );
#            RPerl::diag( 'in Compiler::save_source_files(), have $source_group->{_PMC_accessors_mutators_shims} = ' . Dumper($source_group->{_PMC_accessors_mutators_shims}) . "\n" );
#            RPerl::diag( 'in Compiler::save_source_files(), have $source_group->{_PMC_subroutines_shims} = ' . Dumper($source_group->{_PMC_subroutines_shims}) . "\n" );
#            RPerl::diag( 'in Compiler::save_source_files(), have $source_group->{_PMC_includes} = ' . Dumper($source_group->{_PMC_includes}) . "\n" );

            if ( not -f $module_pmc_filename_manual ) {
                die 'ERROR ECVCOFI02, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: File not found, ' . q{'}
                    . $module_pmc_filename_manual . q{'} . "\n"
                    . ', dying' . "\n";
            }

            open my filehandleref $FILE_HANDLE, '<', $module_pmc_filename_manual
                or die 'ERROR ECVCOFI03, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Cannot open file '
                . $module_pmc_filename_manual
                . ' for reading, '
                . $OS_ERROR
                . ', dying' . "\n";

            # deferred, finally read in Module PMC template file, replace package name and paths, add accessor/mutator shim methods
            my string $file_line;
            my string $file_string = q{};
            my string $module_path_pm = $file_name_group->{PMC};
            chop $module_path_pm;  # remove the 'c' from 'pmc' file suffix
            while ( $file_line = <$FILE_HANDLE> ) {
                $file_line =~ s/lib\/RPerl\/CompileUnit\/Module\.cpp/$module_path/gxms;
                $file_line =~ s/RPerl::CompileUnit::Module/$module_name/gxms;
                $file_line =~ s/RPerl__CompileUnit__Module/$module_name_underscores/gxms;
                if ( $file_line eq
                    ( '# <<< OO PROPERTIES, ACCESSORS & MUTATORS, SHIMS >>>  # <<< CHANGE_ME: add real shims after this line or delete it >>>' . "\n" ) )
                {
                    if (( defined $source_group->{_PMC_accessors_mutators_shims}->{$module_name_underscores} ) 
                        and ( exists $source_group->{_PMC_accessors_mutators_shims}->{$module_name_underscores} )) {
                        $file_line = ( substr $file_line, 0, 52 ) . "\n" . $source_group->{_PMC_accessors_mutators_shims}->{$module_name_underscores} . "\n\n";
                    }
                    else { $file_line = undef; }
                }
                elsif (
                    $file_line eq ( '# <<< OO PROPERTIES, SUBROUTINES, SHIMS >>>  # <<< CHANGE_ME: add real shims after this line or delete it >>>' . "\n" ) )
                {
                    if (( defined $source_group->{_PMC_subroutines_shims}->{$module_name_underscores} ) 
                        and ( exists $source_group->{_PMC_subroutines_shims}->{$module_name_underscores} )) {
                        $file_line = ( substr $file_line, 0, 43 ) . "\n" . $source_group->{_PMC_subroutines_shims}->{$module_name_underscores} . "\n\n";
                    }
                    else { $file_line = undef; }
                }
                elsif ( $file_line eq ( '# <<< CHANGE_ME: add user-defined includes here >>>' . "\n" ) ) {
                    if (( defined $source_group->{_PMC_includes}->{$module_name_underscores} ) 
                        and ( exists $source_group->{_PMC_includes}->{$module_name_underscores} )) {
                        $file_line = $source_group->{_PMC_includes}->{$module_name_underscores} . "\n\n";
                    }
                    else                                            { $file_line = undef; }
                }
                elsif ( $file_line eq ( '        # <<< CHANGE_ME: enable optional SSE support here >>>' . "\n" ) ) {
#                    RPerl::diag( 'in Compiler::save_source_files(), have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n" );
                    if ((exists $modes->{_enable_sse}) and (defined $modes->{_enable_sse}) and 
                        (exists $modes->{_enable_sse}->{$module_path_pm}) and (defined $modes->{_enable_sse}->{$module_path_pm}) and 
                        $modes->{_enable_sse}->{$module_path_pm}) {
                        $file_line = q[        $RPerl::Inline::ARGS{optimize}  .= ' -mfpmath=sse -msse3';  # enable SSE support] . "\n";
                        $file_line .= q[        $RPerl::Inline::ARGS{auto_include} = ['#include <immintrin.h>', '#include <rperlsse.h>', @{$RPerl::Inline::ARGS{auto_include}}];  # enable SSE support] . "\n";
                    }
                    else { $file_line = undef; }
                }
                elsif ( $file_line eq ( '        # <<< CHANGE_ME: enable optional GMP support here >>>' . "\n" ) ) {
#                    RPerl::diag( 'in Compiler::save_source_files(), have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n" );
                    if ((exists $modes->{_enable_gmp}) and (defined $modes->{_enable_gmp}) and 
                        (exists $modes->{_enable_gmp}->{$module_path_pm}) and (defined $modes->{_enable_gmp}->{$module_path_pm}) and 
                        $modes->{_enable_gmp}->{$module_path_pm}) {
                        $file_line = q[        $RPerl::Inline::ARGS{libs}  = '-lgmp';  # enable GMP support] . "\n";
                        $file_line .= q[        $RPerl::Inline::ARGS{auto_include} = ['#include <gmp.h>', '#include <rperlgmp.h>', @{$RPerl::Inline::ARGS{auto_include}}];  # enable GMP support] . "\n";
                    }
                    else { $file_line = undef; }
                }
                if ( defined $file_line ) { $source_group->{PMC} .= $file_line; }
            }

            close $FILE_HANDLE
                or die 'ECVCOFI04, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Cannot close file '
                . $module_pmc_filename_manual
                . ' after reading, '
                . $OS_ERROR
                . ', dying' . "\n";

            $module_name = shift @{ $module_names_split };
            $module_name_underscores = shift @{ $module_names_underscores_split };
            $i++;
        }
        RPerl::verbose( ' done.' . "\n" );
    }

    RPerl::verbose('SAVE  PHASE 1:      Format & write files to disk...');

    foreach my string $suffix_key ( sort keys %{$file_name_group} ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        if (   ( not exists $source_group->{$suffix_key} )
            or ( not defined $source_group->{$suffix_key} )
            or ( $source_group->{$suffix_key} eq q{} ) )
        {
            croak("\nERROR ECVCOFI05, COMPILER, SAVE OUTPUT FILES: Expecting source code for suffix '$suffix_key', but received empty or no value, croaking");
        }
        my filehandleref $SOURCE_FILE_HANDLE;
        my string $file_name = $file_name_group->{$suffix_key};
        my string $source    = $source_group->{$suffix_key};

        if ( $file_name eq '_TEMPFILE' ) {
            ( $SOURCE_FILE_HANDLE, $file_name )
                = tempfile( 'tempfileXXXX', SUFFIX => ( lc $suffix_key ) );

            print {$SOURCE_FILE_HANDLE} $source
                or croak("\nERROR ECVCOFI06, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot write to file,\ncroaking: $OS_ERROR");
                
            close $SOURCE_FILE_HANDLE
                or croak("\nERROR ECVCOFI09, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot close file,\ncroaking: $OS_ERROR");
        }
        else {

            # overwrite existing file
            if ( -f $file_name ) {
                unlink $file_name
                    or croak(
                    "\nERROR ECVCOFI07, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot delete existing file,\ncroaking: $OS_ERROR");
            }

            open $SOURCE_FILE_HANDLE, '>', $file_name
                or
                croak("\nERROR ECVCOFI08, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot open file for writing,\ncroaking: $OS_ERROR");

            print {$SOURCE_FILE_HANDLE} $source
                or croak("\nERROR ECVCOFI06, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot write to file,\ncroaking: $OS_ERROR");

            close $SOURCE_FILE_HANDLE
                or croak("\nERROR ECVCOFI09, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot close file,\ncroaking: $OS_ERROR");
        }

        # format output code
        if ( ( $suffix_key eq 'PMC' ) or ( $suffix_key eq 'EXE' ) ) {
            my string $perltidy_path = can_run('perltidy');
            if ( defined $perltidy_path ) {
                system $perltidy_path, '-pbp', '--ignore-side-comment-lengths', '--converge', '-l=160', '-b', '-nst', q{-bext='/'}, '-q', $file_name;
            }
            else {
                RPerl::warning( 'WARNING WCVCOFO00, COMPILER, PERL CODE FORMATTING: Perltidy command `perltidy` not found, abandoning formatting' . "\n" );
            }
        }
        elsif ( ( $suffix_key eq 'H' ) or ( $suffix_key eq 'CPP' ) ) {
            my string $astyle_path = can_run('astyle');
            if ( defined $astyle_path ) {

                #                system $astyle_path, '-q', $file_name;
                # don't insert extra newlines, which causes accessors, mutators, and ops_types reporting subroutines to be broken into multiple lines
                system $astyle_path, '-q', '--keep-one-line-blocks', '--keep-one-line-statements', $file_name;
                unlink( $file_name . '.orig' );
            }
            else {
                RPerl::warning( 'WARNING WCVCOFO01, COMPILER, C++ CODE FORMATTING: Artistic Style command `astyle` not found, abandoning formatting' . "\n" );
            }
        }
    }

    RPerl::verbose( ' done.' . "\n" );
};

# Sub-Compile from C++-Parsable String to Perl-Linkable XS & Machine-Readable Binary
our void $cpp_to_xsbinary__subcompile = sub {
    ( my string_hashref $cpp_output_file_name_group ) = @_;

#RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), received $cpp_output_file_name_group =} . "\n" . Dumper($cpp_output_file_name_group) . "\n" );

    RPerl::verbose('SUBCOMPILE:         Generate XS & binary...');

    ( my string $volume_pmc, my string $directories_pmc, my string $file_pmc ) = File::Spec->splitpath( $cpp_output_file_name_group->{PMC}, my $no_file = 0 );
#RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have $directories_pmc = } . $directories_pmc . "\n" );

    # strip trailing / or \ as long as they are not the only characters, which could indicate the root directory
    if (((length $directories_pmc) > 1) and 
        (((substr $directories_pmc, -1, 1) eq q{/}) or ((substr $directories_pmc, -1, 1) eq q{\\}))) {
        substr $directories_pmc, -1, 1, q{};
    }

    my @INC_sorted = sort { length $b <=> length $a } @INC;
#RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have @INC =} . "\n" . Dumper(\@INC) . "\n" );
#RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have @INC_sorted =} . "\n" . Dumper(\@INC_sorted) . "\n" );

    # strip leading INC directory if present
    foreach my string $INC_directory (@INC_sorted) {
#RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have $INC_directory = } . $INC_directory . "\n" );
        if ($directories_pmc =~ /^$INC_directory/) {
            substr $directories_pmc, 0, (length $INC_directory), q{};
            last;
        }
    }

#RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have POSSIBLY-MODIFIED $directories_pmc = } . $directories_pmc . "\n" );

    my string_arrayref $directories_pmc_split = [File::Spec->splitdir($directories_pmc)];
#RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have $directories_pmc_split =} . "\n" . Dumper($directories_pmc_split) . "\n" );

    # discard '.' or empty directory names
    my $directories_pmc_split_tmp = [];
    foreach my $directory (@{$directories_pmc_split}) {
        if (($directory ne q{.}) and ($directory ne q{})) {
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

    RPerl::verbose( '         done.' . "\n" );
};

1;    # end of class

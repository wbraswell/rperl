## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: OFF >>>

# [[[ HEADER ]]]
package RPerl::Compiler;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.010_000;

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
use IPC::Open3;
use IO::Select;

# [[[ SUBROUTINES ]]]

our string_arrayref $find_dependencies = sub {
    ( my string $file_name, my string_hashref $modes ) = @_;
    my string_arrayref $dependencies = [];

    #    RPerl::diag( 'in Compiler::find_dependencies(), received $file_name = ' . $file_name . "\n" );

    if ( not -f $file_name ) {
        die 'ERROR ECOCODE00, COMPILER, FIND DEPENDENCIES: File not found, ' . q{'} . $file_name . q{'} . ', dying' . "\n";
    }

    open my filehandleref $FILE_HANDLE, '<', $file_name
        or die 'ERROR ECOCODE01, COMPILER, FIND DEPENDENCIES: Cannot open file ' . q{'} . $file_name . q{'} . ' for reading, ' . $OS_ERROR . ', dying' . "\n";

    # read in input file, match on 'use' includes for dependencies
    my string $file_line;
    my string $first_package_name = undef;
    my string $eval_string;
    my integer $eval_retval;

    # NEED FIX: do not make recursive calls until after closing file, to avoid
    # ERROR ECOCODE01, COMPILER, FIND DEPENDENCIES: Cannot open file Foo/Bar.pm for reading, Too many open files, dying
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
                RPerl::warning( 'WARNING WCOCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package ' . q{'} . $first_package_name . q{'} . ', fatal error trapped and delayed' . "\n" );
                RPerl::diag(    '                                                Trapped the following error message...' . "\n\n" . $EVAL_ERROR . "\n" );
                RPerl::warning( "\n" );
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
                or ( $file_line =~ /use\s+\w+Perl::Config\s*;/ )    # DEV NOTE, CORRELATION #rp27: MathPerl::Config, PhysicsPerl::Config, etc
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
            elsif ( $file_line =~ /use\s+rperlsse\s*;/ ) {

       #            	RPerl::diag('in Compiler::find_dependencies(), found rperlsse line, have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
                if ( ( substr $Config{archname}, 0, 3 ) eq 'arm' ) {
                    die q{ERROR ECOCODE05, COMPILER, FIND DEPENDENCIES: 'use rperlsse;' command found but SSE not supported on ARM architecture, file }
                        . q{'} . $file_name . q{'} . ', dying' . "\n";
                }
                if ( ( not exists $modes->{_enable_sse} ) or ( not defined $modes->{_enable_sse} ) ) {
                    $modes->{_enable_sse} = {};
                }
                $modes->{_enable_sse}->{$file_name} = 1;

#            	RPerl::diag('in Compiler::find_dependencies(), after finding rperlsse line, have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
                next;
            }
            elsif ( $file_line =~ /use\s+rperlgmp\s*;/ ) {

       #            	RPerl::diag('in Compiler::find_dependencies(), found rperlgmp line, have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
                if ( ( not exists $modes->{_enable_gmp} ) or ( not defined $modes->{_enable_gmp} ) ) {
                    $modes->{_enable_gmp} = {};
                }
                $modes->{_enable_gmp}->{$file_name} = 1;

#            	RPerl::diag('in Compiler::find_dependencies(), after finding rperlgmp line, have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
                next;
            }

            if ( $file_line =~ /use\s+lib/ ) {
                die
                    q{ERROR ECOCODE02, COMPILER, FIND DEPENDENCIES: 'use lib...' not currently supported, please set @INC using the PERL5LIB environment variable, file }
                    . q{'} . $file_name . q{'} . ', dying' . "\n";
            }

            $file_line =~ s/^\s*use\s+([\w:]+)\s*.*\s*;\s*$/$1/gxms;    # remove everything except the package name
            $eval_string = 'use ' . $file_line . '; 1;';

            #            RPerl::diag( 'in Compiler::find_dependencies(), about to call DEP $eval_string = ' . $eval_string . "\n" );
            $eval_retval = eval($eval_string);

            #            RPerl::diag('in Compiler::find_dependencies(), have POST-EVAL DEP %INC = ' . Dumper(\%INC) . "\n");
            if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
                RPerl::warning( 'WARNING WCOCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package ' . q{'} . $first_package_name . q{'} . ', fatal error trapped and delayed' . "\n" );
                RPerl::diag(    '                                                Trapped the following error message...' . "\n\n" . $EVAL_ERROR . "\n" );
                RPerl::warning( "\n" );
            }
            $file_line =~ s/::/\//gxms;                                 # replace double-colon :: scope delineator with forward-slash / directory delineator
            $file_line .= '.pm';
            if ( not exists $INC{$file_line} ) {
                die 'ERROR ECOCODE03, COMPILER, FIND DEPENDENCIES: Failed to find package file '
                    . q{'} . $file_line . q{'}
                    . ' in %INC, file '
                    . q{'} . $file_name . q{'} . ', dying' . "\n";
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
        or die 'ERROR ECOCODE04, COMPILER, FIND DEPENDENCIES: Cannot close file ' . q{'} . $file_name . q{'} . ' after reading, ' . $OS_ERROR . ', dying' . "\n";

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
        cpp_to_xsbinary__subcompile( $cpp_output_file_name_group, $modes );
    }

    # always return $cpp_source_group to maintain consistent return type,
    # only utilized for GENERATE compile mode during dependencies
    return $cpp_source_group;
};

# generate output file name group(s) based on input file name(s)
#sub generate_output_file_names {
our hashref_arrayref $generate_output_file_names = sub {
    ( my string_arrayref $input_file_names, my string_arrayref $output_file_name_prefixes, my integer $input_files_count, my string_hashref $modes ) = @_;

#    RPerl::diag('in Compiler::generate_output_file_names(), received $input_file_names = ' . "\n" . Dumper($input_file_names) . "\n");
#    RPerl::diag('in Compiler::generate_output_file_names(), received $output_file_name_prefixes = ' . "\n" . Dumper($output_file_name_prefixes) . "\n");
#    RPerl::diag('in Compiler::generate_output_file_names(), received $input_files_count = ' . $input_files_count . "\n");
#    RPerl::diag('in Compiler::generate_output_file_names(), received $modes = ' . "\n" . Dumper($modes) . "\n");

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
        }

        # if output file prefix(es) not provided, then generate output file name(s) from input file name(s)
        else {
#            RPerl::diag('in Compiler::generate_output_file_names(), have $input_file_name = ' . $input_file_name . "\n");
            # should not already be only prefix, fileparse() to isolate prefix
            ( $input_file_name_prefix, $input_file_name_path, $input_file_name_suffix ) = fileparse( $input_file_name, qr/[.][^.]*/xms );
        }

        my string $output_file_name_path_prefix = $input_file_name_path . $input_file_name_prefix;

        # *.pl input files may generate *.o, *.a, *.so, *.exe, and/or non-suffix output files
        if ( $input_file_name =~ /[.]pl$/xms ) {
            if ($modes->{subcompile} eq 'ASSEMBLE') {
                # NEED ANSWER: does Micro$oft Windows use *.lib file extension (suffix) for both *.o and *.a assembled object files?
                # but does that only apply when using the M$ VC++ compiler? so does it apply here?
                # apply answer to ARCHIVE mode elsif block immediately below; and also for ASSEMBLE & ARCHIVE blocks in *.pm else block below that;
                # ask similar question for *.so in *NIX vs *.dll in M$, apply to .so elsif blocks below and $filename_suffixes_supported in script/rperl
#                if ( $OSNAME eq 'MSWin32' ) {
#                    $output_file_name_groups->[$i]->{LIB} = $output_file_name_path_prefix . '.lib';
#                }
                # *NIX uses *.o file extension (suffix) for assembled object files
#                else {
                    $output_file_name_groups->[$i]->{O} = $output_file_name_path_prefix . '.o';
#                }
            }

            elsif ($modes->{subcompile} eq 'ARCHIVE') {
                $output_file_name_groups->[$i]->{O} = $output_file_name_path_prefix . '.o';
                $output_file_name_groups->[$i]->{_O_label} = ' (temporary)';
                $output_file_name_groups->[$i]->{A}        = $output_file_name_path_prefix . '.a';
            }
            elsif ($modes->{subcompile} eq 'SHARED') {
                $output_file_name_groups->[$i]->{SO} = $output_file_name_path_prefix . '.so';
            }
            elsif ( ($modes->{subcompile} eq 'STATIC') or 
                    ($modes->{subcompile} eq 'DYNAMIC') or
                   (($modes->{subcompile} eq 'OFF') and (($modes->{compile} eq 'GENERATE') or ($modes->{compile} eq 'SAVE') or ($modes->{compile} eq 'SUBCOMPILE')))
                   ) {
                # Micro$oft Windows uses *.exe file extension (suffix) for compiled executables
                if ( $OSNAME eq 'MSWin32' ) {
                    $output_file_name_groups->[$i]->{EXE} = $output_file_name_path_prefix . '.exe';
                }
    
                # traditionally, *NIX has no file extension (suffix) for compiled executables, non-suffix
                else {
                    $output_file_name_groups->[$i]->{EXE} = $output_file_name_path_prefix;
                }
            }
            # NEED ANSWER: allow this subroutine to be called even when we return empty results?
            else {
                die "ERROR EAR18: Invalid compile mode '" . $modes->{compile} . "' and/or subcompile mode '" . $modes->{subcompile} . "' command-line arguments specified, dying\n";
            }
        }
        else {    # *.pm input files may generate *.o, *.a, *.so, and/or *.pmc output files
            if ($modes->{subcompile} eq 'ASSEMBLE') {
                $output_file_name_groups->[$i]->{O} = $output_file_name_path_prefix . '.o';
            }
            elsif ($modes->{subcompile} eq 'ARCHIVE') {
                $output_file_name_groups->[$i]->{O} = $output_file_name_path_prefix . '.o';
                $output_file_name_groups->[$i]->{_O_label} = ' (temporary)';
                $output_file_name_groups->[$i]->{A}        = $output_file_name_path_prefix . '.a';
            }
            elsif ($modes->{subcompile} eq 'SHARED') {
                $output_file_name_groups->[$i]->{SO} = $output_file_name_path_prefix . '.so';
            }
            elsif ($modes->{subcompile} eq 'STATIC') {
                # DEV NOTE: correlates to errors EAR* in script/rperl
                die 'ERROR EAR15: Incompatible command-line arguments provided, both --static subcompile mode flag and *.pm Perl module input file, dying' . "\n";
            }
            elsif ( ($modes->{subcompile} eq 'DYNAMIC') or
                   (($modes->{subcompile} eq 'OFF') and (($modes->{compile} eq 'GENERATE') or ($modes->{compile} eq 'SAVE') or ($modes->{compile} eq 'SUBCOMPILE')))
                   ) {
                $output_file_name_groups->[$i]->{PMC} = $output_file_name_path_prefix . '.pmc';
            }
            # NEED ANSWER: allow this subroutine to be called even when we return empty results?
            else {
                die "ERROR EAR18: Invalid compile mode '" . $modes->{compile} . "' and/or subcompile mode '" . $modes->{subcompile} . "' command-line arguments specified, dying\n";
            }
        }

        # all CPP ops modes require CPP output files; H output files may optionally be generated as needed
        if ( $modes->{ops} eq 'CPP' ) {
            $output_file_name_groups->[$i]->{CPP}      = $output_file_name_path_prefix . '.cpp';
            $output_file_name_groups->[$i]->{H}        = $output_file_name_path_prefix . '.h';
            $output_file_name_groups->[$i]->{_H_label} = ' (if needed)';
        }

#        RPerl::diag('in Compiler::generate_output_file_names(), bottom of loop ' . $i . ' of ' . ($input_files_count - 1) . ", have \$output_file_name_groups->[$i] = \n" . Dumper( $output_file_name_groups->[$i] ) . "\n");
    }

    return $output_file_name_groups;
};

# Write Source Code Files To File System
our void $save_source_files = sub {
    ( my string_hashref $source_group, my string_hashref $file_name_group, my string_hashref $modes ) = @_;

#    RPerl::diag( q{in Compiler::save_source_files(), received $source_group =} . "\n" . Dumper($source_group) . "\n" );
#    RPerl::diag( q{in Compiler::save_source_files(), received $file_name_group =} . "\n" . Dumper($file_name_group) . "\n" );
#    RPerl::diag( 'in Compiler::save_source_files(), received $modes =' . "\n" . Dumper($modes) . "\n" );
#    RPerl::diag( 'in Compiler::save_source_files(), received $modes->{_symbol_table} =' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );
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

        # NEED FIX WIN32: handle back-slash for Win32 instead of forward-slash only for *NIX

        my string $cpp_file_path     = $file_name_group->{CPP};
        my string $h_file_path_nolib = $file_name_group->{H};

        # remove leading '.\' or './' if present
        if (   ( ( $OSNAME eq 'MSWin32' ) and ( ( substr $h_file_path_nolib, 0, 2 ) eq q{.\\} ) )
            or ( ( substr $h_file_path_nolib, 0, 2 ) eq './' ) )
        {
            substr $h_file_path_nolib, 0, 2, q{};
        }

        # remove leading 'lib/' if present, because -Ilib enabled in RPerl/Inline.pm
        if (   ( ( $OSNAME eq 'MSWin32' ) and ( ( substr $h_file_path_nolib, 0, 4 ) eq 'lib\\' ) )
            or ( ( substr $h_file_path_nolib, 0, 4 ) eq 'lib/' ) )
        {
            substr $h_file_path_nolib, 0, 4, q{};
        }

        # deferred, finally set path to H module header file in CPP module file
        $source_group->{CPP} =~ s/__NEED_HEADER_PATH/$h_file_path_nolib/gxms;

        # MODULE POST-PROCESSING
        if ( $modes->{_input_file_name} =~ /[.]pm$/xms ) {

            # DEV NOTE: barely-documented Inline::CPP bug, must have leading './' if no other directories in path
            if ( ( $OSNAME eq 'MSWin32' ) and ( $cpp_file_path !~ /\\/ ) ) {
                $cpp_file_path .= q{.\\};
            }
            elsif ( $cpp_file_path !~ /\// ) {
                $cpp_file_path .= q{./};
            }

            # deferred, finally change hard-coded PERLOPS_PERLTYPES to CPPOPS_*TYPES
            my string $mode_tagline = $modes->{ops} . 'OPS_' . $modes->{types} . 'TYPES';
            $source_group->{H} =~ s/PERLOPS_PERLTYPES/$mode_tagline/gxms;
            $source_group->{CPP} =~ s/PERLOPS_PERLTYPES/$mode_tagline/gxms;

            # DEV NOTE: only generate PMC output file in dynamic (default) subcompile mode
            if ($modes->{subcompile} eq 'DYNAMIC') {
                if ((exists $source_group->{PMC}) and (defined $source_group->{PMC}) and ($source_group->{PMC} ne q{})) {
                    die 'ERROR ECOCOFI01, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Received non-empty PMC source, dying' . "\n";
                }
    
    #        RPerl::diag( q{in Compiler::save_source_files(), have %INC = } . Dumper(\%INC) . "\n" );
    #        RPerl::diag( q{in Compiler::save_source_files(), have @INC = } . Dumper(\@INC) . "\n" );
    #        RPerl::diag( q{in Compiler::save_source_files(), have $source_group->{_package_names_underscores} = } . Dumper($source_group->{_package_names_underscores}) . "\n" );
    #        RPerl::diag( q{in Compiler::save_source_files(), have $source_group->{_package_names} = } . Dumper($source_group->{_package_names}) . "\n" );
    
                my string_arrayref $module_names_split             = [ ( split /\n/, $source_group->{_package_names} ) ];
                my string_arrayref $module_names_underscores_split = [ ( split /\n/, $source_group->{_package_names_underscores} ) ];
    
                #        RPerl::diag( q{in Compiler::save_source_files(), have $module_names_split = } . Dumper($module_names_split) . "\n" );
    
                my integer $module_count           = scalar @{$module_names_split};
                my string $module_name             = shift @{$module_names_split};
                my string $module_name_underscores = shift @{$module_names_underscores_split};
                my integer $i                      = 0;
    
    # deferred, finally insert constants shims
    #        RPerl::diag('in Compiler::save_source_files(), have $source_group->{_H_constants_shims}->{$module_name_underscores} = ' . $source_group->{_H_constants_shims}->{$module_name_underscores} . "\n");
    
                while ( defined $module_name_underscores ) {
    
                    #            RPerl::diag( q{in Compiler::save_source_files(), have $cpp_file_path = } . $cpp_file_path . "\n" );
                    #            RPerl::diag( q{in Compiler::save_source_files(), have $module_name_underscores = } . $module_name_underscores . "\n" );
    
                    # utilize modified copies of Module PMC template file
                    my string $module_pmc_filename_manual;
                    if ( $module_count == 1 ) {
                        $module_pmc_filename_manual = $RPerl::INCLUDE_PATH . '/RPerl/CompileUnit/Module.pmc.CPPOPS_DUALTYPES';
                    }
                    else {
                        if ( $i == ( $module_count - 1 ) ) {
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
                    chop $pm_file_path;    # remove the 'c' from 'pmc' file suffix
                    while ( $file_line = <$FILE_HANDLE> ) {
                        $file_line =~ s/lib\/RPerl\/CompileUnit\/Module\.cpp/$cpp_file_path/gxms;
                        $file_line =~ s/RPerl::CompileUnit::Module/$module_name/gxms;
                        $file_line =~ s/RPerl__CompileUnit__Module/$module_name_underscores/gxms;
                        if ( $file_line eq
                            ( '# <<< OO PROPERTIES, ACCESSORS & MUTATORS, SHIMS >>>  # <<< CHANGE_ME: add real shims after this line or delete it >>>' . "\n" ) )
                        {
                            if (    ( defined $source_group->{_PMC_accessors_mutators_shims}->{$module_name_underscores} )
                                and ( exists $source_group->{_PMC_accessors_mutators_shims}->{$module_name_underscores} ) )
                            {
                                $file_line
                                    = ( substr $file_line, 0, 52 ) . "\n" . $source_group->{_PMC_accessors_mutators_shims}->{$module_name_underscores} . "\n\n";
                            }
                            else { $file_line = undef; }
                        }
                        elsif ( $file_line eq
                            ( '# <<< OO PROPERTIES, SUBROUTINES, SHIMS >>>  # <<< CHANGE_ME: add real shims after this line or delete it >>>' . "\n" ) )
                        {
                            if (    ( defined $source_group->{_PMC_subroutines_shims}->{$module_name_underscores} )
                                and ( exists $source_group->{_PMC_subroutines_shims}->{$module_name_underscores} ) )
                            {
                                $file_line = ( substr $file_line, 0, 43 ) . "\n" . $source_group->{_PMC_subroutines_shims}->{$module_name_underscores} . "\n\n";
                            }
                            else { $file_line = undef; }
                        }
                        elsif ( $file_line eq ( '# <<< CHANGE_ME: add user-defined includes here >>>' . "\n" ) ) {
                            if (    ( defined $source_group->{_PMC_includes}->{$module_name_underscores} )
                                and ( exists $source_group->{_PMC_includes}->{$module_name_underscores} ) )
                            {
                                $file_line = $source_group->{_PMC_includes}->{$module_name_underscores} . "\n\n";
                            }
                            else { $file_line = undef; }
                        }
                        elsif ( $file_line eq ( '        # <<< CHANGE_ME: enable optional SSE support here >>>' . "\n" ) ) {
    
                       #                    RPerl::diag( 'in Compiler::save_source_files(), have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n" );
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
    
                       #                    RPerl::diag( 'in Compiler::save_source_files(), have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n" );
                            if (    ( exists $modes->{_enable_gmp} )
                                and ( defined $modes->{_enable_gmp} )
                                and ( exists $modes->{_enable_gmp}->{$pm_file_path} )
                                and ( defined $modes->{_enable_gmp}->{$pm_file_path} )
                                and $modes->{_enable_gmp}->{$pm_file_path} )
                            {
                                $file_line = q(        $RPerl::Inline::ARGS{libs}  = '-lgmpxx -lgmp';  # enable GMP support) . "\n";
                                $file_line
                                    .= q(        $RPerl::Inline::ARGS{auto_include} = [ @{ $RPerl::Inline::ARGS{auto_include} }, '#include <gmpxx.h>', '#include <gmp.h>' ];    # enable GMP support)
                                    . "\n";
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
        }
        RPerl::verbose( ' done.' . "\n" );
    }

    RPerl::verbose('SAVE  PHASE 1:      Format & write files to disk...');

    #    RPerl::diag( 'in Compiler::save_source_files(), have [sort keys %{$source_group}] = ' . Dumper([sort keys %{$source_group}]) . "\n" );
    #    RPerl::diag( 'in Compiler::save_source_files(), have $source_group->{H} = ' . Dumper($source_group->{H}) . "\n" );
    #    RPerl::diag( 'in Compiler::save_source_files(), have $source_group = ' . Dumper($source_group) . "\n" );

#    foreach my string $suffix_key ( sort keys %{$file_name_group} ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
    foreach my string $suffix_key ( sort keys %{$source_group} ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        if ((substr $suffix_key, 0, 1) eq '_' ) { next; }
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
                = tempfile( 'tempfileXXXX', SUFFIX => ( lc $suffix_key ) );

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
            $perltidy_path = can_run('perltidy');  # DEV NOTE: comment this line to disable perltidy
            if ( defined $perltidy_path ) {
                system $perltidy_path, '-pbp', '--ignore-side-comment-lengths', '--converge', '-l=160', '-b', '-nst', q{-bext='/'}, '-q', $file_name;
            }
            else {
                RPerl::warning( "\n" . 'WARNING WCOCOFO00, COMPILER, PERL CODE FORMATTING: Perltidy command `perltidy` not found, abandoning formatting' . "\n" );
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
                        or croak( "\n" . 'ERROR ECOCOFI10, COMPILER, FILE SYSTEM: Cannot delete Artistic Style original file ' . 
                            q{'} . $file_name . '.orig' . q{'} . ',' . "\n" . 'croaking:' . $OS_ERROR);
                }
            }
            else {
                RPerl::warning( 'WARNING WCOCOFO01, COMPILER, C++ CODE FORMATTING: Artistic Style command `astyle` not found, abandoning formatting' . "\n" );
            }
        }
    }

    RPerl::verbose( ' done.' . "\n" );
};

# Sub-Compile from C++-Parsable String to Perl-Linkable XS & Machine-Readable Binary
our void $cpp_to_xsbinary__subcompile = sub {
    ( my string_hashref $cpp_output_file_name_group, my string_hashref $modes ) = @_;

#    RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), received $cpp_output_file_name_group =} . "\n" . Dumper($cpp_output_file_name_group) . "\n" );
#    RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), received $modes =} . "\n" . Dumper($modes) . "\n" );

    if (( $modes->{_input_file_name} =~ /[.]pl$/xms ) or ($modes->{subcompile} ne 'DYNAMIC')) {
        RPerl::verbose('SUBCOMPILE:         Generate binary...     ');

        if ($modes->{subcompile} eq 'OFF') {
            croak 'ERROR ECOCOSU00, COMPILER, SUBCOMPILE: Received incorrect subcompile mode OFF while inside subcompile subroutine, croaking';
        }
        elsif ( ($modes->{subcompile} ne 'ASSEMBLE') and 
                ($modes->{subcompile} ne 'ARCHIVE') and 
                ($modes->{subcompile} ne 'SHARED') and 
                ($modes->{subcompile} ne 'STATIC') and 
                ($modes->{subcompile} ne 'DYNAMIC')) {
            croak 'ERROR ECOCOSU01, COMPILER, SUBCOMPILE: Received invalid subcompile mode ' . q{'} . $modes->{subcompile} . q{'} . 
                ' while inside subcompile subroutine, croaking';
        }

        my string $subcompile_command = $modes->{CXX};

        if (($modes->{subcompile} eq 'ASSEMBLE') or 
            ($modes->{subcompile} eq 'ARCHIVE')) {
            # stop the subcompiler after the assemble phase, output .o file; not in original Inline::CPP subcompile command
            $subcompile_command .= q{ } . '-c';    
        }
        elsif (($modes->{subcompile} eq 'STATIC') or 
            ($modes->{subcompile} eq 'DYNAMIC')) {
            # Perl requires pthreads, at least Perls compiled with thread support do; not in original Inline::CPP subcompile command
            # NEED ANSWER: test for non-threaded Perl to avoid including pthread support?
            $subcompile_command .= q{ } . '-pthread';    
        }

        my string $ccflags = [ config_re('ccflags') ]->[0];
        substr $ccflags, 0,  9, q{};                 # remove leading ccflags='
        substr $ccflags, -1, 1, q{};                 # remove trailing '
        $subcompile_command .= q{ } . $ccflags;

        $subcompile_command .= q{ } . '-xc++';       # force C++ language mode

        # using RPerl::BASE_PATH instead of substr $RPerl::INCLUDE_PATH
#        if ( ( ( substr $RPerl::INCLUDE_PATH, -4, 4 ) eq '/lib' ) or ( ( substr $RPerl::INCLUDE_PATH, -4, 4 ) eq '\lib' ) ) {
#            $subcompile_command .= q{ } . '-I"' . ( substr $RPerl::INCLUDE_PATH, 0, -4 ) . '"';    # remove trailing /lib or \lib
#        }

        $subcompile_command .= q{ } . '-I"' . $RPerl::BASE_PATH    . '"';
        $subcompile_command .= q{ } . '-I"' . $RPerl::INCLUDE_PATH . '"';  # different than original Inline::CPP subcompile command, double-quotes added to encapsulate user-name directories
        $subcompile_command .= q{ } . '-Ilib';

        $subcompile_command .= q{ } . $RPerl::Inline::CCFLAGSEX;
        $subcompile_command .= q{ } . '-D__' . $modes->{types} . '__TYPES';    # same as #define __PERL__TYPES or #define__CPP__TYPES; don't just use hard-coded $RPerl::TYPES_CCFLAG
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

        $subcompile_command .= q{ } . $cpp_output_file_name_group->{CPP};
        $subcompile_command .= q{ } . '-o ';

        if (($modes->{subcompile} eq 'ASSEMBLE') or 
            ($modes->{subcompile} eq 'ARCHIVE')) {
            $subcompile_command .= q{ } . $cpp_output_file_name_group->{O};
        }
        elsif ($modes->{subcompile} eq 'SHARED') {
            $subcompile_command .= q{ } . $cpp_output_file_name_group->{SO};
        }
        elsif (($modes->{subcompile} eq 'STATIC') or 
               ($modes->{subcompile} eq 'DYNAMIC')) {
            $subcompile_command .= q{ } . $cpp_output_file_name_group->{EXE};
        }

        if ($modes->{subcompile} eq 'SHARED') {
            $subcompile_command .= q{ } . '-shared';
        }
        elsif ($modes->{subcompile} eq 'STATIC') {
            $subcompile_command .= q{ } . '-static';
        }

        if (($modes->{subcompile} eq 'STATIC') or 
            ($modes->{subcompile} eq 'DYNAMIC')) {
            $subcompile_command .= q{ } . '-lperl';  # not in original Inline::CPP subcompile command
        }

        if ($modes->{subcompile} eq 'STATIC') {
            $subcompile_command .= q{ } . '-lcrypt';  # not in original Inline::CPP subcompile command
        }

        if ($modes->{subcompile} eq 'ARCHIVE') {
            $subcompile_command .= q{ } . ' ; ar -cvq ' . $cpp_output_file_name_group->{A} . q{ } . $cpp_output_file_name_group->{O};
            # NEED ANSWER: is this always the correct output redirect mechanism M$ Windows?  I think it is correct for cmd.exe, but what about Cygwin, etc?
            if ( $OSNAME eq 'MSWin32' ) { $subcompile_command .= q{ } . ' > nul'; }
            else { $subcompile_command .= q{ } . ' > /dev/null'; }
        }

#        RPerl::diag( 'in Compiler::cpp_to_xsbinary__subcompile(), have $subcompile_command =' . "\n\n" . $subcompile_command . "\n" );

        # ACTUALLY RUN SUBCOMPILE COMMAND
        my $pid = open3( 0, \*SUBCOMPILE_STDOUT, \*SUBCOMPILE_STDERR, $subcompile_command );    # disable STDIN w/ 0

        my $stdout_select;
        my $stderr_select;
        if ( $OSNAME ne 'MSWin32' ) {
            $stdout_select = IO::Select->new();
            $stderr_select = IO::Select->new();
            $stdout_select->add( \*SUBCOMPILE_STDOUT );
            $stderr_select->add( \*SUBCOMPILE_STDERR );
        }

        my string $subcompile_command_stdout = q{};
        my string $subcompile_command_stderr = q{};

        if ( $OSNAME eq 'MSWin32' || $stdout_select->can_read(0) ) { sysread SUBCOMPILE_STDOUT, $subcompile_command_stdout, 4096; }
        if ( $OSNAME eq 'MSWin32' || $stderr_select->can_read(0) ) { sysread SUBCOMPILE_STDERR, $subcompile_command_stderr, 4096; }
        waitpid $pid, 0;
        if ( $OSNAME eq 'MSWin32' || $stdout_select->can_read(0) ) { my $s; sysread SUBCOMPILE_STDOUT, $s, 4096; $subcompile_command_stdout .= $s; }
        if ( $OSNAME eq 'MSWin32' || $stderr_select->can_read(0) ) { my $s; sysread SUBCOMPILE_STDERR, $s, 4096; $subcompile_command_stderr .= $s; }

        my $test_exit_status = $CHILD_ERROR >> 8;

        #    RPerl::diag( 'in Compiler::cpp_to_xsbinary__subcompile(), have $CHILD_ERROR = ' . $CHILD_ERROR . "\n" );
        #    RPerl::diag( 'in Compiler::cpp_to_xsbinary__subcompile(), have $test_exit_status = ' . $test_exit_status . "\n" );
 
        RPerl::verbose( '         done.' . "\n" );

        # delete temporary .o file
        if ($modes->{subcompile} eq 'ARCHIVE') {
            if ( -f $cpp_output_file_name_group->{O} ) {
                unlink( $cpp_output_file_name_group->{O} )
                    or croak( "\n" . 'ERROR ECOCOSU03, COMPILER, SUBCOMPILE: Cannot delete temporary object file ' . 
                        q{'} . $cpp_output_file_name_group->{O} . q{'} . ',' . "\n" . 'croaking:' . $OS_ERROR);
            }
        }

#        if ($subcompile_command_stdout) { RPerl::diag( "===STDOUT=BEGIN===\n" . $subcompile_command_stdout . "===STDOUT=END===\n" ); }
#        if ($subcompile_command_stderr) { RPerl::diag( "===STDERR=BEGIN===\n" . $subcompile_command_stderr . "===STDERR=END===\n" ); }
        my boolean $subcompile_command_stdout_content = ((defined $subcompile_command_stdout) and ($subcompile_command_stdout =~ m/[^\s]+/g));
        my boolean $subcompile_command_stderr_content = ((defined $subcompile_command_stderr) and ($subcompile_command_stderr =~ m/[^\s]+/g));

        if ($subcompile_command_stdout_content or $subcompile_command_stderr_content) {
            RPerl::diag("\n");
            if ($subcompile_command_stdout_content) {
                RPerl::diag( '[[[ SUBCOMPILE STDOUT ]]]' . "\n\n" . $subcompile_command_stdout . "\n" );
            }
            if ($subcompile_command_stderr_content) {
                RPerl::diag( '[[[ SUBCOMPILE STDERR ]]]' . "\n\n" . $subcompile_command_stderr . "\n" );
            }
            if ( $test_exit_status == 0 ) {  # UNIX process return code 0, success
                RPerl::warning('WARNING WCOCOSU00, COMPILER, SUBCOMPILE: C++ compiler returned success code but produced output which may indicate an error,' . "\n" . 
                'please run again with `rperl -D` command or RPERL_DEBUG=1 environmental variable for error messages or other output if none appear above' . "\n");
            }
        }
        
        if ( $test_exit_status ) {  # UNIX process return code not 0, error
            if (not ($subcompile_command_stdout_content or $subcompile_command_stderr_content)) 
                { RPerl::diag( "\n" . '[[[ SUBCOMPILE STDOUT & STDERR ARE BOTH EMPTY ]]]' . "\n\n" ); } 
            croak 'ERROR ECOCOSU04, COMPILER, SUBCOMPILE: C++ compiler returned error code,' . "\n" . 
            'please run again with `rperl -D` command or RPERL_DEBUG=1 environmental variable for error messages if none appear above,' . "\n" . 
            'croaking';
        }
    }
    else {                                 # *.pm module files
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
        foreach my string $INC_directory (@INC_sorted) {

            #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), have $INC_directory = } . $INC_directory . "\n" );
            if ( $directories_pmc =~ /^$INC_directory/ ) {
                substr $directories_pmc, 0, ( length $INC_directory ), q{};
                last;
            }
        }

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
};

1;                                        # end of class

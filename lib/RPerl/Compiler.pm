## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: OFF >>>

# [[[ HEADER ]]]
package RPerl::Compiler;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.005_200;

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

# [[[ SUBROUTINES ]]]

our string_arrayref $find_dependencies = sub {
    ( my string $file_name) = @_;
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
            if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
                die 'ERROR ECVCODE02, COMPILER, FIND DEPENDENCIES: Failed to eval-use package '
                    . $first_package_name
                    . '  ...  '
                    . $EVAL_ERROR
                    . ', dying' . "\n";
            }
        }
        if ( $file_line =~ /^\s*use\s+[\w:]+/xms ) {
            if (   ( $file_line =~ /use\s+strict\s*;/ )
                or ( $file_line =~ /use\s+warnings\s*;/ )
                or ( $file_line =~ /use\s+RPerl::CompileUnit::Module::Class\s*;/ )
                or ( $file_line =~ /use\s+RPerl::Class\s*;/ )
                or ( $file_line =~ /use\s+RPerl\s*;/ )
                or ( $file_line =~ /use\s+RPerl::AfterFilter\s*;/ )
                or ( $file_line =~ /use\s+RPerl::Config\s*;/ )
                or ( $file_line =~ /use\s+parent/ )
                or ( $file_line =~ /use\s+constant/ )
                or ( $file_line =~ /use\s+[0-9]/ ) )
            {
                # safely ignore these possibly-valid but not-subdependency uses
                next;
            }

            if ( $file_line =~ /use\s+lib/ ) {
                die
                    q{ERROR ECVCODE03, COMPILER, FIND DEPENDENCIES: 'use lib...' not currently supported, please set @INC using the PERL5LIB environment variable, dying}
                    . "\n";
            }

            $file_line =~ s/^\s*use\s+([\w:]+)\s*.*\s*;\s*$/$1/gxms;    # remove everything except the package name
            $eval_string = 'use ' . $file_line . '; 1;';

#            RPerl::diag( 'in Compiler::find_dependencies(), about to call DEP $eval_string = ' . $eval_string . "\n" );
            $eval_retval = eval($eval_string);

            #            RPerl::diag('in Compiler::find_dependencies(), have POST-EVAL DEP %INC = ' . Dumper(\%INC) . "\n");
            if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
                die 'ERROR ECVCODE02, COMPILER, FIND DEPENDENCIES: Failed to eval-use package ' . $file_line . '  ...  ' . $EVAL_ERROR . ', dying' . "\n";
            }
            $file_line =~ s/::/\//gxms;                                 # replace double-colon :: scope delineator with forward-slash / directory delineator
            $file_line .= '.pm';
            if ( not exists $INC{$file_line} ) {
                die 'ERROR ECVCODE04, COMPILER, FIND DEPENDENCIES: After successful eval-use, still failed to find package file '
                    . $file_line
                    . ' in %INC, dying' . "\n";
            }

#            RPerl::diag( 'in Compiler::find_dependencies(), have MATCHING $file_line = ' . $file_line . "\n" );
#            RPerl::diag( 'in Compiler::find_dependencies(), have $INC{$file_line} = ' . $INC{$file_line} . "\n" );
            push @{$dependencies}, $INC{$file_line};

#            RPerl::diag( 'in Compiler::find_dependencies(), have PRE-SUBDEPS $dependencies = ' . Dumper($dependencies) . "\n" );

            my string_arrayref $subdependencies = find_dependencies( $INC{$file_line} );

            # discard duplicate dependencies that now appear in subdependencies
            $dependencies = [ uniq @{$subdependencies}, @{$dependencies} ];

#            RPerl::diag( 'in Compiler::find_dependencies(), have POST-SUBDEPS $dependencies = ' . Dumper($dependencies) . "\n" );
        }
    }

    close $FILE_HANDLE
        or die 'ECVCODE05, COMPILER, FIND DEPENDENCIES: Cannot close file ' . $file_name . ' after reading, ' . $OS_ERROR . ', dying' . "\n";

#    RPerl::diag( 'in Compiler::find_dependencies(), returning $dependencies = ' . Dumper($dependencies) . "\n" );
    return $dependencies;
};

# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]

our void $rperl_to_rperl__parse_generate = sub {
    ( my string $rperl_input_file_name, my string_hashref $rperl_output_file_name_group, my string_hashref $modes ) = @_;
    my object $rperl_ast;
    my string_hashref $rperl_source_group;

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

    if ( $modes->{compile} eq 'SAVE' ) {
        save_source_files( $rperl_source_group, $rperl_output_file_name_group, $modes );
    }
};

# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]

our void $rperl_to_xsbinary__parse_generate_compile = sub {
    ( my string $rperl_input_file_name, my string_hashref $cpp_output_file_name_group, my string_hashref $modes ) = @_;
    my object $rperl_ast;
    my string_hashref $source_group;

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
        $source_group = RPerl::Generator::ast_to_cpp__generate( $rperl_ast, $modes );
    }

    # [[[ SAVE C++ TO DISK ]]]

    if (   ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'SUBCOMPILE' ) )
    {
        save_source_files( $source_group, $cpp_output_file_name_group, $modes );
    }

    # [[[ SUBCOMPILE C++ TO XS & BINARY ]]]

    if ( $modes->{compile} eq 'SUBCOMPILE' ) {
        cpp_to_xsbinary__subcompile( $source_group, $cpp_output_file_name_group );
    }
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

    foreach my string $suffix_key ( sort keys %{$source_group} ) {
        if (   ( not exists $file_name_group->{$suffix_key} )
            or ( not defined $file_name_group->{$suffix_key} )
            or ( $file_name_group->{$suffix_key} eq q{} ) )
        {
            croak("\nERROR ECVCOFI00, COMPILER, SAVE OUTPUT FILES: Expecting file name for suffix '$suffix_key', but received empty or no value, croaking");
        }
    }

    # finally create PMC file and set H path in CPP file for CPPOPS
    if ( $modes->{ops} eq 'CPP' ) {
        RPerl::verbose('SAVE  PHASE 0:      Deferred file modifications... ');

        if ( $source_group->{PMC} ne q{} ) {
            die 'ERROR ECVCOFI01, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Received non-empty PMC source, dying' . "\n";
        }

        # NEED ADDRESS: replace $RPerl::INCLUDE_PATH/RPerl/CompileUnit/Module.cpp different than RPerl/CompileUnit/Module.cpp ???
        # is this file path munging done correctly for files that do not reside in RPerl/* directories, or even those that are in RPerl/* ?
        # NEED FIX WIN32: handle back-slash for Win32 instead of forward-slash only for *NIX

        my string $module_path        = $file_name_group->{CPP};
        my string $module_header_path = $file_name_group->{H};

        # remove leading './' if present
        if ( ( substr $module_path, 0, 2 ) eq './' ) {
            substr $module_path, 0, 2, '';
        }
        if ( ( substr $module_header_path, 0, 2 ) eq './' ) {
            substr $module_header_path, 0, 2, '';
        }

        # remove leading 'lib/' if present
        if ( ( substr $module_path, 0, 4 ) eq 'lib/' ) {
            substr $module_path, 0, 4, '';
        }
        if ( ( substr $module_header_path, 0, 4 ) eq 'lib/' ) {
            substr $module_header_path, 0, 4, '';
        }

        # deferred, finally set path to H module header file in CPP module file
        $source_group->{CPP} =~ s/__NEED_MODULE_HEADER_PATH/$module_header_path/gxms;

        # deferred, finally change hard-coded PERLOPS_PERLTYPES to CPPOPS_*TYPES
        my string $mode_tagline = $modes->{ops} . 'OPS_' . $modes->{types} . 'TYPES';
        $source_group->{H} =~ s/PERLOPS_PERLTYPES/$mode_tagline/gxms;
        $source_group->{CPP} =~ s/PERLOPS_PERLTYPES/$mode_tagline/gxms;

        my string $module_name = $module_path;

        # remove trailing '.cpp' if present
        if ( ( substr $module_name, -4, 4 ) eq '.cpp' ) {
            substr $module_name, -4, 4, '';
        }

        # replace forward-slashes with double underscores
        my string $module_underscores = $module_name;
        $module_underscores =~ s/\//__/gxms;

        # replace forward-slashes with scopes (double colons)
        $module_name =~ s/\//\:\:/gxms;

        #RPerl::diag( q{in Compiler::save_source_files(), have $module_path = }, $module_path, "\n" );
        #RPerl::diag( q{in Compiler::save_source_files(), have $module_name = }, $module_name, "\n" );
        #RPerl::diag( q{in Compiler::save_source_files(), have $module_underscores = }, $module_underscores, "\n" );

        # utilize modified copy of Module PMC template file
        my string $module_pmc_filename_manual = $RPerl::INCLUDE_PATH . '/RPerl/CompileUnit/Module.pmc.CPPOPS_DUALTYPES';

        #RPerl::diag('in Compiler::save_source_files(), have $module_pmc_filename_manual = ' . $module_pmc_filename_manual . "\n");

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

        # deferred, finally read in Module PMC template file, replace package name and paths
        my string $file_line;
        my string $file_string = q{};
        while ( $file_line = <$FILE_HANDLE> ) {
            $file_line =~ s/RPerl\/CompileUnit\/Module\.cpp/$module_path/gxms;
            $file_line =~ s/RPerl::CompileUnit::Module/$module_name/gxms;
            $file_line =~ s/RPerl__CompileUnit__Module/$module_underscores/gxms;
            $source_group->{PMC} .= $file_line;
        }

        close $FILE_HANDLE
            or die 'ECVCOFI04, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Cannot close file '
            . $module_pmc_filename_manual
            . ' after reading, '
            . $OS_ERROR
            . ', dying' . "\n";

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
    ( my string $file_name_group ) = @_;

    #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), received $file_name_group =} . "\n" . Dumper($file_name_group) . "\n" );

    RPerl::verbose('SUBCOMPILE:         Generate XS & binary...     ');

    # ADD CALLS TO TRIGGER Inline::CPP COMPILATION

    RPerl::verbose( ' skipped.' . "\n" );
};

1;    # end of class

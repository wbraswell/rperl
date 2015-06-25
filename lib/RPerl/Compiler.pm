## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: OFF >>>

# [[[ HEADER ]]]
package RPerl::Compiler;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_220;

# [[[ CRITICS ]]]

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 9: allow complex processing with open filehandle

# [[[ INCLUDES ]]]

use RPerl::Parser;
use RPerl::Generator;
use File::Temp qw(tempfile);
use File::Basename;
use English qw(-no_match_vars);    # for $OSNAME; why isn't this included from 'require RPerl::Config', which is included from 'use RPerl' above?

# [[[ SUBROUTINES ]]]

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
        or ( $modes->{compile} eq 'COMPILE' ) )
    {
        $rperl_ast = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);
    }

    # [[[ GENERATE AST TO C++ ]]]

    if (   ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'COMPILE' ) )
    {
        $source_group = RPerl::Generator::ast_to_cpp__generate( $rperl_ast, $modes );
    }

    # [[[ SAVE C++ TO DISK ]]]

    if (   ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'COMPILE' ) )
    {
        save_source_files( $source_group, $cpp_output_file_name_group, $modes );
    }

    # [[[ COMPILE C++ TO XS & BINARY ]]]

    if ( $modes->{compile} eq 'COMPILE' ) {
        cpp_to_xsbinary__subcompile( $source_group, $cpp_output_file_name_group );
    }
};

# generate output file name group(s) based on input file name(s)
#sub generate_output_file_names {
our hashref_arrayref $generate_output_file_names = sub {
    ( my string_arrayref $input_file_names, my string_arrayref $output_file_name_prefixes, my string_hashref $modes, my integer $input_files_count ) = @_;

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
                die "ERROR EARG08: Invalid RPerl source code output file option specified, dying\n";
            }
        }

        # if output file prefix(es) not provided, then generate output file name(s) from input file name(s)
        else {
            #            RPerl::diag 'have $input_file_name = ' . $input_file_name . "\n";
            # should not already be only prefix, fileparse() to isolate prefix
            ( $input_file_name_prefix, $input_file_name_path, $input_file_name_suffix ) = fileparse( $input_file_name, qr/[.][^.]*/xms );
        }

        #        RPerl::diag '$output_file_name_groups->[' . $i . ']' . "\n" . Dumper($output_file_name_groups->[$i]) . "\n";

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

#        RPerl::diag 'in rperl::generate_output_file_names(), bottom of loop ' . $i . ' of ' . $input_files_count . ", have \$output_file_name_groups->[$i] = \n" . Dumper( $output_file_name_groups->[$i] ) . "\n";
    }

    return $output_file_name_groups;
};

# Write Source Code Files To File System
our void $save_source_files = sub {
    ( my string_hashref $source_group, my string_hashref $file_name_group, my string_hashref $modes ) = @_;

    #    RPerl::diag( q{in Compiler::save_source_files(), received $source_group =}, "\n", Dumper($source_group), "\n" );
    #    RPerl::diag( q{in Compiler::save_source_files(), received $file_name_group =}, "\n", Dumper($file_name_group), "\n" );

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

        if ( $source_group->{PMC} ne q{} ) {
            die 'ERROR ECVCOFI01, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Received non-empty PMC source, dying' . "\n";
        }

        # NEED ADDRESS: replace $RPerl::INCLUDE_PATH/RPerl/CompileUnit/Module.cpp different than RPerl/CompileUnit/Module.cpp ???
        # is this file path munging done correctly for files that do not reside in RPerl/* directories, or even those that are in RPerl/* ?
        # NEED FIX WIN32: handle back-slash for Win32 instead of forward-slash only for *NIX

        my string $module_path = $file_name_group->{CPP};
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
        #RPerl::diag 'in Compiler::save_source_files(), have $module_pmc_filename_manual = ' . $module_pmc_filename_manual . "\n";

        if ( not -f $module_pmc_filename_manual ) {
            die 'ERROR ECVCOFI02, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: File not found, ' . q{'}
                . $module_pmc_filename_manual . q{'} . "\n"
                . ', dying' . "\n";
        }

        open my filehandleref $FILE_HANDLE, '<', $module_pmc_filename_manual
            or die 'ERROR ECVCOFI03, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Cannot open file '
            . $module_pmc_filename_manual
            . ' for reading,'
            . $OS_ERROR
            . ', dying' . "\n";

        # deferred, finally read in Module PMC template file, replace package name and paths
        my string $file_line;
        my string $file_string = q{};
        while ( $file_line = <$FILE_HANDLE> ) {
            $file_line =~ s/RPerl\/CompileUnit\/Module\.cpp/$module_path/xms;
            $file_line =~ s/RPerl::CompileUnit::Module/$module_name/xms;
            $file_line =~ s/RPerl__CompileUnit__Module/$module_underscores/xms;
            $source_group->{PMC} .= $file_line;
        }

        close $FILE_HANDLE
            or die 'ECVCOFI04, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Cannot close file '
            . $module_pmc_filename_manual
            . ' after reading,'
            . $OS_ERROR
            . ', dying' . "\n";
    }

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

        if ( ( $suffix_key eq 'PMC' ) or ( $suffix_key eq 'EXE' ) ) {

            #            `perltidy -pbp --ignore-side-comment-lengths --converge -b -nst -bext='/' -q $file_name`;
            system 'perltidy', '-pbp', '--ignore-side-comment-lengths', '--converge', '-b', '-nst', q{-bext='/'}, '-q', $file_name;
        }
    }

};

# Sub-Compile from C++-Parsable String to Perl-Linkable XS & Machine-Readable Binary
our void $cpp_to_xsbinary__subcompile = sub {
    ( my string $file_name_group ) = @_;

    #RPerl::diag( q{in Compiler::cpp_to_xsbinary__subcompile(), received $file_name_group =}, "\n", Dumper($file_name_group), "\n" );

    # ADD CALLS TO TRIGGER Inline::CPP COMPILATION
};

1;    # end of package

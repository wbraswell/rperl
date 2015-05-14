## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 5: allow complex code outside subroutines, must be on line 1
# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: OFF >>>

# [[[ HEADER ]]]
package RPerl::Compiler;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_200;

# [[[ CRITICS ]]]

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 10: allow complex processing with open filehandle

# [[[ INCLUDES ]]]

use RPerl::Parser;
use RPerl::Generator;

# [[[ SUBROUTINES ]]]

# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]

our void $rperl_to_rperl__parse_generate = sub {
    (   my string $rperl_input_file_name,
        my string $rperl_output_file_name_group,
        my string_hashref $modes
    ) = @_;
    my object $rperl_ast;
    my string_hashref $rperl_source_group;

    # [[[ PARSE RPERL TO AST ]]]

    if (   ( $modes->{compile} eq 'PARSE' )
        or ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' ) )
    {
        $rperl_ast
            = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);
    }

    # [[[ GENERATE AST TO RPERL ]]]

    if (   ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' ) )
    {
        $rperl_source_group
            = RPerl::Generator::ast_to_rperl__generate( $rperl_ast, $modes );
    }

    # [[[ SAVE RPERL TO DISK ]]]

    if ( $modes->{compile} eq 'SAVE' ) {
        save_source_files( $rperl_source_group,
            $rperl_output_file_name_group );
    }
};

# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]

our void $rperl_to_xsbinary__parse_generate_compile = sub {
    (   my string $rperl_input_file_name,
        my string $cpp_output_file_name_group,
        my string_hashref $modes
    ) = @_;
    my object $rperl_ast;
    my string_hashref $source_group;

    # [[[ PARSE RPERL TO AST ]]]

    if (   ( $modes->{compile} eq 'PARSE' )
        or ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'COMPILE' ) )
    {
        $rperl_ast
            = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);
    }

    # [[[ GENERATE AST TO C++ ]]]

    if (   ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'COMPILE' ) )
    {
        $source_group
            = RPerl::Generator::ast_to_cpp__generate( $rperl_ast, $modes );
    }

    # [[[ SAVE C++ TO DISK ]]]

    if (   ( $modes->{compile} eq 'SAVE' )
        or ( $modes->{compile} eq 'COMPILE' ) )
    {
        save_source_files( $source_group, $cpp_output_file_name_group );
    }

    # [[[ COMPILE C++ TO XS & BINARY ]]]

    if ( $modes->{compile} eq 'COMPILE' ) {
        cpp_to_xsbinary__compile( $source_group,
            $cpp_output_file_name_group );
    }
};

# Write Source Code Files To File System
our void $save_source_files = sub {
    ( my string_hashref $source_group, my string_hashref $file_name_group )
        = @_;

#    RPerl::diag( q{in Compiler::save_source_files(), received $source_group =}, "\n", Dumper($source_group), "\n" );
#    RPerl::diag( q{in Compiler::save_source_files(), received $file_name_group =}, "\n", Dumper($file_name_group), "\n" );

    foreach my string $suffix_key ( sort keys %{$source_group} ) {
        if (   ( not exists $file_name_group->{$suffix_key} )
            or ( not defined $file_name_group->{$suffix_key} )
            or ( $file_name_group->{$suffix_key} eq q{} ) )
        {
            croak(
                "\nERROR ECVCOFI00, COMPILER, SAVE OUTPUT FILES: Expecting file name for suffix '$suffix_key', but received empty or no value, croaking"
            );
        }
    }

    foreach my string $suffix_key ( sort keys %{$file_name_group} ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 7: PERL CRITIC UNFILED ISSUE, not postfix foreach or if
        if (   ( not exists $source_group->{$suffix_key} )
            or ( not defined $source_group->{$suffix_key} )
            or ( $source_group->{$suffix_key} eq q{} ) )
        {
            croak(
                "\nERROR ECVCOFI01, COMPILER, SAVE OUTPUT FILES: Expecting source code for suffix '$suffix_key', but received empty or no value, croaking"
            );
        }
        my string $file_name = $file_name_group->{$suffix_key};
        my string $source    = $source_group->{$suffix_key};

        # actually save file(s)
        if ( -f $file_name ) {
            unlink $file_name
                or croak(
                "\nERROR ECVCOFI02, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot delete existing file,\ncroaking: $OS_ERROR"
                );
        }

        my $SOURCE_FILEHANDLE;
        open $SOURCE_FILEHANDLE, '>', $file_name
            or croak(
            "\nERROR ECVCOFI03, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot open file for writing,\ncroaking: $OS_ERROR"
            );

        print {$SOURCE_FILEHANDLE} $source
            or croak(
            "\nERROR ECVCOFI04, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot write to file,\ncroaking: $OS_ERROR"
            );

        close $SOURCE_FILEHANDLE
            or croak(
            "\nERROR ECVCOFI05, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot close file,\ncroaking: $OS_ERROR"
            );

        if ( ( $suffix_key eq 'PMC' ) or ( $suffix_key eq 'EXE' ) ) {

#            `perltidy -pbp --ignore-side-comment-lengths --converge -b -nst -bext='/' -q $file_name`;
            system 'perltidy', '-pbp', '--ignore-side-comment-lengths',
                '--converge', '-b', '-nst', q{-bext='/'}, '-q', $file_name;
        }
    }

};

# Compile from C++-Parsable String to Perl-Linkable XS & Machine-Readable Binary
our void $cpp_to_xsbinary__compile = sub {
    ( my string $file_name_group ) = @_;

    RPerl::diag(
        q{in Compiler::cpp_to_xsbinary__compile(), received $file_name_group =},
        "\n", Dumper($file_name_group), "\n"
    );

    # ADD CALLS TO TRIGGER Inline::CPP COMPILATION
};

1;    # end of package

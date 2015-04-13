# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: OFF >>>

# [[[ HEADER ]]]
package RPerl::Compiler;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_011;

# [[[ CRITICS ]]]

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]

use RPerl::Parser;
use RPerl::Generator;

# [[[ SUBROUTINES ]]]

our void $rperl_to_rperl__parse_generate = sub {
    (   my string $rperl_input_file_name,
        my hash_ref $mode
    ) = @_;
    my object $rperl_ast;
    my string $rperl_source;

    # [[[ PARSE RPERL TO AST ]]]
    # [[[ PARSE RPERL TO AST ]]]
    # [[[ PARSE RPERL TO AST ]]]

    if (   ( $mode->{compile} eq 'PARSE' )
        or ( $mode->{compile} eq 'GENERATE' ) )
    {
        $rperl_ast = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);
    }

    # [[[ GENERATE AST TO RPERL ]]]
    # [[[ GENERATE AST TO RPERL ]]]
    # [[[ GENERATE AST TO RPERL ]]]

    if ( $mode->{compile} eq 'GENERATE' )
    {
        $rperl_source = RPerl::Generator::ast_to_rperl__generate( $rperl_ast, $mode );
    }
};

our void $rperl_to_xsbinary__parse_generate_compile = sub {
    (   my string $rperl_input_file_name,
        my string $cpp_output_file_name,
        my hash_ref $mode
    ) = @_;
    my object $rperl_ast;
    my string $cpp_source;

    # [[[ PARSE RPERL TO AST ]]]
    # [[[ PARSE RPERL TO AST ]]]
    # [[[ PARSE RPERL TO AST ]]]

    if (   ( $mode->{compile} eq 'PARSE' )
        or ( $mode->{compile} eq 'GENERATE' )
        or ( $mode->{compile} eq 'COMPILE' ) )
    {
        $rperl_ast = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);
    }

    # [[[ GENERATE AST TO C++ ]]]
    # [[[ GENERATE AST TO C++ ]]]
    # [[[ GENERATE AST TO C++ ]]]

    if (   ( $mode->{compile} eq 'GENERATE' )
        or ( $mode->{compile} eq 'COMPILE' ) )
    {
        $cpp_source = RPerl::Generator::ast_to_cpp__generate( $rperl_ast, $mode );
    }

    # [[[ COMPILE C++ TO XS & BINARY ]]]
    # [[[ COMPILE C++ TO XS & BINARY ]]]
    # [[[ COMPILE C++ TO XS & BINARY ]]]

    if ( $mode->{compile} eq 'COMPILE' ) {
        cpp_to_xsbinary__compile( $cpp_source, $cpp_output_file_name );
    }
};

# Compile from C++-Parsable String to Perl-Linkable XS & Machine-Readable Binary
our void $cpp_to_xsbinary__compile = sub {
    ( my string $cpp_source, my string $cpp_file_name ) = @_;

    RPerl::diag( "in cpp_to_xsbinary__compile(), received \$cpp_source =\n\n",
        $cpp_source, "\n" );
    RPerl::diag(
              q{in cpp_to_xsbinary__compile(), received $cpp_file_name = '}
            . $cpp_file_name
            . "'\n" );

    # save file(s)
    if ( -f $cpp_file_name ) {
        unlink $cpp_file_name
            or croak(
            "\nERROR ECVCOFI00, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot delete existing file,\ncroaking: $OS_ERROR"
            );
    }

    my $CPP_FILEHANDLE;
    open $CPP_FILEHANDLE, '>', $cpp_file_name
        or croak(
        "\nERROR ECVCOFI01, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot open file for writing,\ncroaking: $OS_ERROR"
        );

    print {$CPP_FILEHANDLE} $cpp_source
        or croak(
        "\nERROR ECVCOFI02, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot write to file,\ncroaking: $OS_ERROR"
        );

    close $CPP_FILEHANDLE
        or croak(
        "\nERROR ECVCOFI03, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot close file,\ncroaking: $OS_ERROR"
        );

    # NEED FIX: call Inline to run tests
};

1;    # end of package

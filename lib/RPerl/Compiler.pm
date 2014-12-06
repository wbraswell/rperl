# [[[ CHECK: OFF ]]]
package RPerl::Compiler;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_000;

# [[[ SETUP ]]]

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(RequireInterpolationOfMetachars)  # SYSTEM DEFAULT 2: allow single-quoted control characters, sigils, and regexes

use RPerl::Parser;

# [[[ PROCEDURAL SUBROUTINES ]]]

our void $rperl_to_xsbinary__compile = sub {
    ( my string $rperl_input_file_name, 
    my string $cpp_output_file_name, 
    my hash_ref $mode ) = @_;

    # [[[ PARSE RPERL TO AST ]]]
    # [[[ PARSE RPERL TO AST ]]]
    # [[[ PARSE RPERL TO AST ]]]

    my object $rperl_ast = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);

    # [[[ GENERATE AST TO C++ ]]]
    # [[[ GENERATE AST TO C++ ]]]
    # [[[ GENERATE AST TO C++ ]]]

#    my string $cpp_source = ast_to_cpp__generate( $rperl_ast, $mode );

    # [[[ COMPILE C++ TO XS & BINARY ]]]
    # [[[ COMPILE C++ TO XS & BINARY ]]]
    # [[[ COMPILE C++ TO XS & BINARY ]]]

#    cpp_to_xsbinary__compile( $cpp_source, $cpp_output_file_name );

};

our string $ast_to_cpp__generate = sub {
    ( my object $rperl_ast ) = @_;
    my string $cpp_source;

    #...
    return ($cpp_source);
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
            "\nERROR ECVCOFI00, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot delete existing file,\ncroaking: $ERRNO"
            );
    }

    my $CPP_FILEHANDLE;
    open $CPP_FILEHANDLE, '>', $cpp_file_name
        or croak(
        "\nERROR ECVCOFI01, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot open file for writing,\ncroaking: $ERRNO"
        );

    print {$CPP_FILEHANDLE} $cpp_source
        or croak(
        "\nERROR ECVCOFI02, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot write to file,\ncroaking: $ERRNO"
        );

    close $CPP_FILEHANDLE
        or croak(
        "\nERROR ECVCOFI03, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot close file,\ncroaking: $ERRNO"
        );

    # NEED FIX: call Inline to run tests
};

1;
1;
package RPerl::Compiler;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SETUP ]]]

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(RequireInterpolationOfMetachars)  # SYSTEM DEFAULT 2: allow single-quoted control characters, sigils, and regexes
## no critic qw(ProhibitPunctuationVars)  ## RPERL SYSTEM allow error codes in $!
use Data::Dumper;

# [[[ PROCEDURAL SUBROUTINES ]]]


# START HERE: move functionality from bin/rperl to perl_to_cpp() below; link RPerl::pmc_compile() to perl_to_cpp(); enable Module::Compile
# START HERE: move functionality from bin/rperl to perl_to_cpp() below; link RPerl::pmc_compile() to perl_to_cpp(); enable Module::Compile
# START HERE: move functionality from bin/rperl to perl_to_cpp() below; link RPerl::pmc_compile() to perl_to_cpp(); enable Module::Compile


our string $perl_to_cpp = sub {
    ( my string $perl_source ) = @_;
    my string $cpp_source;
    #...
    return($cpp_source);
};


# Compile from C++-Parsable String to Perl-Linkable XS & Machine-Readable Binary
our void $cpp_to_xsbinary__compile = sub {
    ( my string $cpp_source, my string $cpp_file_name ) = @_;

    RPerl::diag(
        "in cpp_to_xsbinary__compile(), received \$cpp_source =\n\n"
        ,$cpp_source,"\n");
    RPerl::diag(
        q{in cpp_to_xsbinary__compile(), received $cpp_file_name = '}
        . $cpp_file_name . "'\n");

    # save file(s)
    if ( -f $cpp_file_name ) {
        unlink $cpp_file_name
            or croak(
            "\nERROR ECVCOFI00, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot delete existing file,\ncroaking: $!"
            );
    }

    my $CPP_FILEHANDLE;
    open $CPP_FILEHANDLE, '>', $cpp_file_name
        or croak(
        "\nERROR ECVCOFI01, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot open file for writing,\ncroaking: $!"
        );

    print {$CPP_FILEHANDLE} $cpp_source
        or croak(
        "\nERROR ECVCOFI02, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot write to file,\ncroaking: $!"
        );

    close $CPP_FILEHANDLE
        or croak(
        "\nERROR ECVCOFI03, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot close file,\ncroaking: $!"
        );

    # NEED FIX: call Inline to run tests
};

1;

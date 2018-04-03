#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: "P183c, CODE GENERATOR, ABSTRACT SYNTAX TO" >>>
# <<< GENERATE_ERROR: "subroutine argument name 'foo__argument' must not include a double-underscore, forbidden by C++ specification as a reserved identifier" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Reserved::Class_03_Good;

# [[[ SUBROUTINES ]]]
sub foo_subroutine_in_main {
    { my void $RETURN_TYPE };
    ( my integer $foo__argument ) = @ARG;

    print 'Howdy from foo_subroutine_in_main()...', "\n";
    print 'in foo_subroutine_in_main(), received $foo__argument = ', $foo__argument, "\n";
    return;
}

# [[[ OPERATIONS ]]]
print 'Hello, World!', "\n";
foo_subroutine_in_main(23);


#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< GENERATOR_ERROR: 'ERROR ECVGEASRP04' >>>
# <<< GENERATOR_ERROR: 'Attempt to return dereferenced hash' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
our integer_arrayref $foo = sub {
# DEV NOTE: DO NOT RUN PERLTIDY ON THIS FILE!  the line below should read 'return(...' not 'return (...'
    return( ( ( %{ { a => 2 } } ) ) );
};

# [[[ OPERATIONS ]]]
foo();

#!/usr/bin/env perl

# <<< EXECUTE_SUCCESS: '$VAR1 = 2;' >>>
# <<< EXECUTE_SUCCESS: '$VAR2 = 3;' >>>
# <<< EXECUTE_SUCCESS: '$VAR3 = 5;' >>>
# <<< EXECUTE_SUCCESS: '$VAR4 = 7;' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
sub foo {
    { my integer_arrayref $RETURN_TYPE };

# DEV NOTE: DO NOT RUN PERLTIDY ON THIS FILE!  the line below should read 'return (...);' not 'return(...);'
    return ( 2, 3, 5, 7 );
}

# [[[ OPERATIONS ]]]
print Dumper(foo());

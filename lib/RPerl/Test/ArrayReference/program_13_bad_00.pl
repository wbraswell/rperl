#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected Token:  ]' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my unknown__array_ref $u_array = [
    my integer $TYPED_u_array_0           = -23,
    my number__array_ref $TYPED_u_array_1 = [ 42 / 1_701, 21.12, 2_112.23 ],
    my string__hash_ref $TYPED_u_array_2  = {
        alpha => 'strings are scalars, too',
        beta  => 'hello world',
        gamma => 'last one'
    },
];

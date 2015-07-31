#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  ]' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my scalartype $mystery_scalar      = 'FOOBAZ';
my scalartype_arrayref $sc_array = [
    my integer $TYPED_sc_array_0    = 17,
    my number $TYPED_sc_array_1     = 42 / 1_701,
    my string $TYPED_sc_array_2     = 'strings are scalars, too',
    my scalartype $TYPED_sc_array_3 = $mystery_scalar,
];

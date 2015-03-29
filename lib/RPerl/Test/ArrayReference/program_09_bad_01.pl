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

# homogeneous 2-dimensional array of arrays, using inner types
my array_ref__array_ref $array_array = [
    my integer__array_ref $TYPED_array_array_0 = [ 17,   -23, 1_701 ],
    my integer__array_ref $TYPED_array_array_1 = [ -1,   444, 2_987, ],
    my integer__array_ref $TYPED_array_array_2 = [ -321, 7,   24_851 ]
];
print 'have $array_array =', "\n", Dumper($array_array), "\n";

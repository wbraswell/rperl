#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "before loop" >>>
# <<< EXECUTE_SUCCESS: "$array = [ 17, -23, 1_701 ]" >>>
# <<< EXECUTE_SUCCESS: "$array = [ -1, 444, 2_987 ]" >>>
# <<< EXECUTE_SUCCESS: "$array = [ -321, 7, 24_851 ]" >>>
# <<< EXECUTE_SUCCESS: "after loop" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireTrailingCommas)  # USER DEFAULT 11: no trailing commas in RPerl lists

# [[[ OPERATIONS ]]]

print 'before loop', "\n";

# homogeneous 2-dimensional array of arrays, using inner types
my arrayref_array @array_array = (
    my integer_arrayref $TYPED_array_array_0 = [ 17,   -23, 1_701 ],
    my integer_arrayref $TYPED_array_array_1 = [ -1,   444, 2_987 ],
    my integer_arrayref $TYPED_array_array_2 = [ -321, 7,   24_851 ]
);
foreach my arrayref $array ( @array_array ) {
    print '$array = ', integer_arrayref_to_string($array), "\n";
}

print 'after loop', "\n";

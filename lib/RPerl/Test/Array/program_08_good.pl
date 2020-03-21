#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "before loop" >>>
# <<< EXECUTE_SUCCESS: "$sc = 17" >>>
# <<< EXECUTE_SUCCESS: "$sc = 0.02469135802" >>>
# <<< EXECUTE_SUCCESS: "$sc = strings are scalars, too" >>>
# <<< EXECUTE_SUCCESS: "$sc = 21.12" >>>
# <<< EXECUTE_SUCCESS: "after loop" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

print 'before loop', "\n";

my scalartype $mystery_scalar = 21.12;
my scalartype_array @sc_array = (
    my integer $TYPED_sc_array_0 = 17,
    my number $TYPED_sc_array_1 = 42 / 1_701,
    my string $TYPED_sc_array_2 = 'strings are scalars, too',
    my scalartype $TYPED_sc_array_3 = $mystery_scalar
);

foreach my scalartype $sc ( @sc_array ) {
    print '$sc = ', $sc, "\n";
}

print 'after loop', "\n";

#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "before loop" >>>
# <<< EXECUTE_SUCCESS: "$n = 0.6736455102" >>>
# <<< EXECUTE_SUCCESS: "$n = 0.9996951839" >>>
# <<< EXECUTE_SUCCESS: "$n = -0.7650690644" >>>
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

my number_array @n_array = ( sin( 17 / 23 ), cos( 42 / 1_701 ), -( sin 21.12 ) );
foreach my number $n ( @n_array ) {
    print '$n = ', $n, "\n";
}

print 'after loop', "\n";

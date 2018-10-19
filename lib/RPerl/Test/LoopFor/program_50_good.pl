#!/usr/bin/env perl

# Learning RPerl, Section 3.12.1: The Range for Loop

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'in first loop, have $i = 0' >>>
# <<< EXECUTE_SUCCESS: 'in first loop, have $i = 1' >>>
# <<< EXECUTE_SUCCESS: 'in first loop, have $i = 2' >>>
# <<< EXECUTE_SUCCESS: 'in first loop, have $i = 3' >>>
# <<< EXECUTE_SUCCESS: 'in first loop, have $i = 4' >>>
# <<< EXECUTE_SUCCESS: 'in first loop, have $i = 5' >>>
# <<< EXECUTE_SUCCESS: 'in first loop, have $i = 6' >>>
# <<< EXECUTE_SUCCESS: 'in first loop, have $i = 7' >>>
# <<< EXECUTE_SUCCESS: 'in first loop, have $i = 8' >>>
# <<< EXECUTE_SUCCESS: 'in first loop, have $i = 9' >>>
# <<< EXECUTE_SUCCESS: 'in first loop, have $i = 10' >>>
# <<< EXECUTE_SUCCESS: 'between loops, have $x = 100' >>>
# <<< EXECUTE_SUCCESS: 'in second loop, have $i = 20' >>>
# <<< EXECUTE_SUCCESS: 'in second loop, have $i = 21' >>>
# <<< EXECUTE_SUCCESS: 'in second loop, have $i = 22' >>>
# <<< EXECUTE_SUCCESS: 'in second loop, have $i = 23' >>>
# <<< EXECUTE_SUCCESS: 'in second loop, have $i = 24' >>>
# <<< EXECUTE_SUCCESS: 'in second loop, have $i = 25' >>>
# <<< EXECUTE_SUCCESS: 'in second loop, have $i = 26' >>>
# <<< EXECUTE_SUCCESS: 'in second loop, have $i = 27' >>>
# <<< EXECUTE_SUCCESS: 'in second loop, have $i = 28' >>>
# <<< EXECUTE_SUCCESS: 'in second loop, have $i = 29' >>>
# <<< EXECUTE_SUCCESS: 'in second loop, have $i = 30' >>>
# <<< EXECUTE_SUCCESS: 'after loops, have $x = 100' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]
for my integer $i ( 0 .. 10 ) {
    # do stuff inside first loop, using $i; fine
    print 'in first loop, have $i = ', $i, "\n";
}

# do stuff outside loops, not using $i; fine
my integer $x = 100;
print 'between loops, have $x = ', $x, "\n";

# fine
for my integer $i ( 20 .. 30 ) {
    # do stuff inside second loop,
    # using totally independent instance of $i
    print 'in second loop, have $i = ', $i, "\n";
}

print 'after loops, have $x = ', $x, "\n";


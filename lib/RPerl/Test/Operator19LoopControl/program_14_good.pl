#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'before    loop, have current $i = 0' >>>
# <<< EXECUTE_SUCCESS: 'top    of loop, have current $i = 0' >>>
# <<< EXECUTE_SUCCESS: 'top    of loop, have current $i = 1' >>>
# <<< EXECUTE_SUCCESS: 'bottom of loop, have next    $i = 2' >>>
# <<< EXECUTE_SUCCESS: 'top    of loop, have current $i = 2' >>>
# <<< EXECUTE_SUCCESS: 'top    of loop, have current $i = 3' >>>
# <<< EXECUTE_SUCCESS: 'bottom of loop, have next    $i = 4' >>>
# <<< EXECUTE_SUCCESS: 'top    of loop, have current $i = 4' >>>
# <<< EXECUTE_SUCCESS: 'top    of loop, have current $i = 5' >>>
# <<< EXECUTE_SUCCESS: 'bottom of loop, have next    $i = 6' >>>
# <<< EXECUTE_SUCCESS: 'top    of loop, have current $i = 6' >>>
# <<< EXECUTE_SUCCESS: 'top    of loop, have current $i = 7' >>>
# <<< EXECUTE_SUCCESS: 'bottom of loop, have next    $i = 8' >>>
# <<< EXECUTE_SUCCESS: 'top    of loop, have current $i = 8' >>>
# <<< EXECUTE_SUCCESS: 'top    of loop, have current $i = 9' >>>
# <<< EXECUTE_SUCCESS: 'bottom of loop, have next    $i = 10' >>>
# <<< EXECUTE_SUCCESS: 'after     loop, have current $i = 10' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $i = 0;

print 'before    loop, have current $i = ', $i, "\n";

MY_LOOP:
while ( $i < 10 ) {
    print "\n";
    print 'top    of loop, have current $i = ', $i, "\n";
    $i++;
    if ( $i % 2 ) {
        redo MY_LOOP;
    }
    print 'bottom of loop, have next    $i = ', $i, "\n";
}

print "\n";
print 'after     loop, have current $i = ', $i, "\n";

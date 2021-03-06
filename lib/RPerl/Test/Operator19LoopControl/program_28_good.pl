#!/usr/bin/env perl

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
my integer $j = 0;

print 'before    outer loop, have current $i = ', $i, "\n";
print 'before    outer loop, have current $j = ', $j, "\n";

# DEV NOTE: infinite loop
OUTER_LOOP:
while ( $i < 3 ) {
    print "\n";
    print 'top    of outer loop, have current $i = ', $i, "\n";
    $i++;
    $j = 0;
    INNER_LOOP:
    while ( $j < 5 ) {
        print 'top    of inner loop, have current $j = ', $j, "\n";
        $j++;
        if ( $j > 2 ) {
            redo OUTER_LOOP;
        }
        print 'bottom of inner loop, have current $j = ', $j, "\n";
    }
    print 'bottom of outer loop, have next    $i = ', $i, "\n";
}

print "\n";
print 'after     outer loop, have current $i = ', $i, "\n";
print 'after     outer loop, have current $j = ', $j, "\n";

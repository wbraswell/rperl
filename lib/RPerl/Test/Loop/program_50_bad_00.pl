#!/usr/bin/perl

# Learning RPerl, Section 3.12.1: The Range for Loop

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECOGEASCP11' >>>
# <<< COMPILE_ERROR: 'variable i already declared in this scope, namespace main::, subroutine/method main(), dying' >>>

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

# do stuff outside loops, using $i; causes error in second loop below
my integer $i = 100;
print 'between loops, have $i = ', $i, "\n";

# error
for my integer $i ( 20 .. 30 ) {
    # do stuff inside second loop,
    # using totally independent instance of $i
    print 'in second loop, have $i = ', $i, "\n";
}

print 'after loops, have $i = ', $i, "\n";


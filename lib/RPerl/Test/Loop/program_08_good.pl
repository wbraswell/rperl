#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

TESTFORLOOP:
for my integer $i ( 0 .. 4 ) {
    print 'Production rule Loop matched by LoopFor, iteration number ', $i,
        "\n";
    if ( $i > 1 ) {
        last TESTFORLOOP;
    }
}

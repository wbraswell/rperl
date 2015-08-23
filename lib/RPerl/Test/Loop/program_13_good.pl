#!/usr/bin/perl
# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

TESTFOREACHLOOP:
foreach my number $my_number ( 1.1, 2.2, 3.3, 4.4 ) {
    if ( $my_number == 3.3 ) {
        next TESTFOREACHLOOP;
    }
    print 'Production rule Loop matched by LoopForEach, iteration item ',
        $my_number, "\n";
}

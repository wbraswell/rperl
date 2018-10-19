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

my unknown $foo = [
    'strange', { weird => 'goofy', beard => [ 'goatee', -17.01 ] },
    23.42, 'heterogeneous'
];
print $foo->[1]->{beard}->[ 1 * 100 ];

#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

# homogeneous 2-dimensional array of arrays, using outer type
my integer__array_ref__array_ref $array_array
    = [ [ 17, -23, 1_701 ], [ -1, 444, 2_987 ], [ -321, 7, 24_851 ] ];
print 'have $array_array =', "\n", Dumper($array_array), "\n";

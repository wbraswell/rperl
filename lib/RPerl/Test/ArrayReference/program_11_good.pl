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

# homogeneous 2-dimensional array of arrays, using outer type
my integer_arrayref_arrayref $array_array = [ [ 17, -23, 1_701 ], [ -1, 444, 2_987 ], [ -321, 7, 24_851 ] ];
foreach my arrayref $array ( @{$array_array} ) {
    print '$array = ', Dumper($array), "\n";
}

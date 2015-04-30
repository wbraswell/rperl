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

my arrayref_arrayref $array_array = [
    my integer_arrayref $TYPED_array_array_0 = [ 17, -23, 1_701 ],
    my number_arrayref $TYPED_array_array_1
        = [ 42 / 1_701, 21.12, 2_112.23 ],
    my string_arrayref $TYPED_array_array_2
        = [ 'strings are scalars, too', 'hello world', 'last one' ]
];
foreach my arrayref $array ( @{$array_array} ) { print '$array = ', Dumper($array), "\n"; }
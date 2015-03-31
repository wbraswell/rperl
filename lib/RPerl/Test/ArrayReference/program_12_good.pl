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

my array_ref__array_ref $array_array = [
    my integer__array_ref $TYPED_array_array_0 = [ 17, -23, 1_701 ],
    my number__array_ref $TYPED_array_array_1
        = [ 42 / 1_701, 21.12, 2_112.23 ],
    my string__array_ref $TYPED_array_array_2
        = [ 'strings are scalars, too', 'hello world', 'last one' ]
];
foreach my array_ref $array ( @{$array_array} ) { print '$array = ', Dumper($array), "\n"; }
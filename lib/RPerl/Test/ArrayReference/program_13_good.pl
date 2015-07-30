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

my arrayref $unknown_array = [
    my integer $TYPED_unknown_array_0           = -23,
    my number_arrayref $TYPED_unknown_array_1 = [ 42 / 1_701, 21.12, 2_112.23 ],
    my string_hashref $TYPED_unknown_array_2  = { alpha => 'strings are scalars, too', beta  => 'hello world', gamma => 'last one' }
];
foreach my unknown $u ( @{$unknown_array} ) {
    print '$u = ', Dumper($u), "\n";
}

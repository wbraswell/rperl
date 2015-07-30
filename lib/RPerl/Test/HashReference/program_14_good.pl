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

my number $key_number = 0.1;
my string $key_string = '0.1';

my hashref $unknown_hash = {
    key0 => my integer $TYPED_key0              = -23,
    0    => my number_arrayref $TYPED_zero      = [ 42 / 1_701, 21.12, 2_112.23 ],
    0.1  => my string_hashref $TYPED_zerodotone = { 'alpha' => 'strings are scalars, too', 12.345_678 => 'hello world', gamma => 'last one' },
    '0.1'       => 'replacement',
    "0.1\n"     => 'close but not quite',
    $key_number => 'another replacement',
    $key_string => 'final replacement'
};

print Dumper($unknown_hash);

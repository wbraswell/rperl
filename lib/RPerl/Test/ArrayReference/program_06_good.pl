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

my string__array_ref $s_array_0 = [ 'a', 'b', 'c' ];
my string__array_ref $s_array_1 = [ 'd', 'e', 'f' ];
my string__array_ref $s_array_2 = [ 'g', 'h', 'i' ];
my string__array_ref $s_array_all
    = [ @{$s_array_0}, 'howdy' x 3, @{$s_array_1}, 'doody' x 2,
    @{$s_array_2} ];
foreach my string__array_ref $s ( @{$s_array_all} ) { print '$s = ', Dumper($s), "\n"; }

#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected Token:  ]' >>>

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
    = [ @{$s_array_0}, @{$s_array_1}, @{$s_array_2}, ];
print 'have $s_array_all = ', "\n", Dumper($s_array_all), "\n";

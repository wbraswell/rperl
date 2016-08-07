#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $bar = 723.555777' >>>
# <<< EXECUTE_SUCCESS: 'have $double_bar = 1447.111554' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string $foo = '723.555_777';
my number $bar = string_to_number($foo);
my number $double_bar = $bar * 2;
print 'have $bar = ', $bar, "\n";
print 'have $double_bar = ', $double_bar, "\n";

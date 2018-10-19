#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = 3' >>>
# <<< EXECUTE_SUCCESS: 'have $bar = -3' >>>
# <<< EXECUTE_SUCCESS: 'have $result = 100' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my number $foo = abs 3;
my number $bar = -3;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";

my number $result = (abs $bar) * 23 + 1;
$result += abs $bar * 10;

print 'have $result = ', $result, "\n";

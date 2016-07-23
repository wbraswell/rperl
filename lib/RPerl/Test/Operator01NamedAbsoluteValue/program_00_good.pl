#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = 3' >>>
# <<< EXECUTE_SUCCESS: 'have $bar = -3' >>>
# <<< EXECUTE_SUCCESS: 'have $foo = 3' >>>
# <<< EXECUTE_SUCCESS: 'have $bar = 6' >>>
# <<< EXECUTE_SUCCESS: 'have $float_number = -5' >>>
# <<< EXECUTE_SUCCESS: 'have $positive_float_number = -5' >>>
# <<< EXECUTE_SUCCESS: 'have $float_number = 5' >>>
# <<< EXECUTE_SUCCESS: 'have $positive_float_number = 5' >>>

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

$bar = $foo + $foo;
$bar = abs $bar;

my number $float_number = -5.0;
my number $positive_float_number = -5.0;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $float_number = ', $float_number, "\n";
print 'have $positive_float_number = ', $positive_float_number, "\n";

$float_number = abs $float_number;
$positive_float_number = abs $positive_float_number;

print 'have $float_number = ', $float_number, "\n";
print 'have $positive_float_number = ', $positive_float_number, "\n";

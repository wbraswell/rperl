#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $bat = ' >>>
# <<< EXECUTE_SUCCESS: 'have $baz = ' >>>
# <<< EXECUTE_SUCCESS: 'have $bax = ' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]
my number $bat  = rand;
my number $baz  = rand 10;
my number $bax  = rand 30;

print 'have $bat = ', number_to_string($bat), "\n";
print 'have $baz = ', number_to_string($baz), "\n";
print 'have $bax = ', number_to_string($bax), "\n";

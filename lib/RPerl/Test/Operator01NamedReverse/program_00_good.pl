#!/usr/bin/perl

# Learning RPerl, Section 3.14: reverse Operator

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $forward  = [ 2, 8, 24, 76, 238, 748 ]' >>>
# <<< EXECUTE_SUCCESS: 'have $reversed = [ 748, 238, 76, 24, 8, 2 ]' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

# reverse array elements
my integer_arrayref $forward  = [2, 8, 24, 76, 238, 748];
my integer_arrayref $reversed = [reverse @{$forward}];
print 'have $forward  = ', integer_arrayref_to_string($forward), "\n";
print 'have $reversed = ', integer_arrayref_to_string($reversed), "\n";

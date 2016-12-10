#!/usr/bin/perl

# Learning RPerl, Section 3.15: sort Operator

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $random = [6, 4, 8, 1, 5, 0, 9, 2, 7, 3]' >>>
# <<< EXECUTE_SUCCESS: 'have $sorted = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

# sort array elements
my integer_arrayref $random = [6, 4, 8, 1, 5, 0, 9, 2, 7, 3];
my integer_arrayref $sorted = [sort @{$random}];
print 'have $random = ', integer_arrayref_to_string($random), "\n";
print 'have $sorted = ', integer_arrayref_to_string($sorted), "\n";

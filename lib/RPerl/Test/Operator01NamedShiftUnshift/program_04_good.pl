#!/usr/bin/env perl

# Learning RPerl, Section 3.9: shift & unshift Operators

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $frob = [ 21, 12, 23 ]' >>>
# <<< EXECUTE_SUCCESS: 'have $frob_length = 3' >>>
# <<< EXECUTE_SUCCESS: 'have $frob_shift = 21' >>>
# <<< EXECUTE_SUCCESS: 'have $frob = [ 12, 23 ]' >>>
# <<< EXECUTE_SUCCESS: 'have $frob_length = 2' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]
my integer_arrayref $frob = [];
my integer $frob_length = ( unshift @{$frob}, 21, 12, 23 );  # Operator grammar production, parentheses required for builtin in non-void context
print 'have $frob = ', integer_arrayref_to_string($frob), "\n";
print 'have $frob_length = ', $frob_length, "\n";

my integer $frob_shift = shift @{$frob};
$frob_length = scalar @{$frob};
print 'have $frob_shift = ', $frob_shift, "\n";
print 'have $frob = ', integer_arrayref_to_string($frob), "\n";
print 'have $frob_length = ', $frob_length, "\n";

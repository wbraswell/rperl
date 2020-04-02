#!/usr/bin/env perl

# Learning RPerl, Section 3.6: qw() Operator

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "have $foo_1 = [ 'a', 'c', 'e' ]" >>>
# <<< EXECUTE_SUCCESS: "have $bar_1 = [ 'a', 'c', 'e' ]" >>>
# <<< EXECUTE_SUCCESS: "have $foo_2 = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g' ]" >>>
# <<< EXECUTE_SUCCESS: "have $bar_2 = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g' ]" >>>
# <<< EXECUTE_SUCCESS: "have $foo_3 = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm' ]" >>>
# <<< EXECUTE_SUCCESS: "have $bar_3 = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm' ]" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_arrayref $foo_1 = [qw(a c e)];
my string_arrayref $bar_1 = ['a', 'c', 'e'];  # 4 characters less

my string_arrayref $foo_2 = [qw(a b c d e f g)];
my string_arrayref $bar_2 = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];  # 16 characters less

my string_arrayref $foo_3 = [qw(a b c d e f g h i j k l m)];
my string_arrayref $bar_3 = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm'];  # 34 characters less

print 'have $foo_1 = ', string_arrayref_to_string($foo_1), "\n";
print 'have $bar_1 = ', string_arrayref_to_string($bar_1), "\n";
print 'have $foo_2 = ', string_arrayref_to_string($foo_2), "\n";
print 'have $bar_2 = ', string_arrayref_to_string($bar_2), "\n";
print 'have $foo_3 = ', string_arrayref_to_string($foo_3), "\n";
print 'have $bar_3 = ', string_arrayref_to_string($bar_3), "\n";

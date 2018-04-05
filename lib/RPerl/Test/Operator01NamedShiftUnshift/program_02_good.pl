#!/usr/bin/perl

# Learning RPerl, Section 3.9: shift & unshift Operators

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = [ 21, 12, 23 ]' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]
my integer_arrayref $foo = [17, 21, 12, 23];
shift @{$foo};
print 'have $foo = ', integer_arrayref_to_string($foo), "\n";

#!/usr/bin/env perl

# Learning RPerl, Section 3.8: push & pop Operators

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = [ 17, 21, 12 ]' >>>

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
pop @{$foo};
print 'have $foo = ', integer_arrayref_to_string($foo), "\n";

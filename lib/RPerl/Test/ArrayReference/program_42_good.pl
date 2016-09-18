#!/usr/bin/perl

# Learning RPerl, Section 3.3: How To Access Array Elements

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "have 1-D single dereference = 9" >>>
# <<< EXECUTE_SUCCESS: "have 2-D double dereference = 9" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer_arrayref          $foo_1D =  [3, 6, 9];
my integer_arrayref_arrayref $foo_2D = [[3, 6, 9]];

print 'have 1-D single dereference = ', $foo_1D->[2],      "\n";
print 'have 2-D double dereference = ', $foo_2D->[0]->[2], "\n";

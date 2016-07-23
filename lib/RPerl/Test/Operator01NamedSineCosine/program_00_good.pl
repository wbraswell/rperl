#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $op_sin = 0.909_297' >>>
# <<< EXECUTE_SUCCESS: 'have $op_cos = -0.416_146' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]
my number $op_sin = sin 2;
my number $op_cos = cos 2;

print 'have $op_sin = ', number_to_string($op_sin), "\n";
print 'have $op_cos = ', number_to_string($op_cos), "\n";

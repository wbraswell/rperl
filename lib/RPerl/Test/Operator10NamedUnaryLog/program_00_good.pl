#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $op_log_1 = 0' >>>
# <<< EXECUTE_SUCCESS: 'have $op_log_2 = 0.693_147_180_559_945' >>>
# <<< EXECUTE_SUCCESS: 'have $op_log_10 = 2.302_585_092_994_05' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]
my number $op_log_1  = log 1;
my number $op_log_2  = log 2;
my number $op_log_10 = log 10;

print 'have $op_log = ', number_to_string($op_log_1), "\n";
print 'have $op_log = ', number_to_string($op_log_2), "\n";
print 'have $op_log = ', number_to_string($op_log_10), "\n";


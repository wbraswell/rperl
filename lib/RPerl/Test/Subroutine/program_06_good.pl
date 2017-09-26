#!/usr/bin/perl

# Learning RPerl, Section 4.3.2: Multiple Return Values

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $retval0 = 21' >>>
# <<< EXECUTE_SUCCESS: 'have $retval1 = 22' >>>
# <<< EXECUTE_SUCCESS: 'have $retval2 = 23' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
sub foo_multi { { my integer_arrayref $RETURN_TYPE }; return [21, 22, 23]; }

# [[[ OPERATIONS ]]]
my integer_arrayref $retvals = foo_multi();
my integer $retval0 = $retvals->[0];
my integer $retval1 = $retvals->[1];
my integer $retval2 = $retvals->[2];
print 'have $retval0 = ', $retval0, "\n";
print 'have $retval1 = ', $retval1, "\n";
print 'have $retval2 = ', $retval2, "\n";

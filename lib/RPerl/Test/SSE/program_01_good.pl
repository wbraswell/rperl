#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $x->[0] = 1' >>>
# <<< EXECUTE_SUCCESS: 'have $x->[1] = 0' >>>
# <<< EXECUTE_SUCCESS: 'have $y->[0] = 0' >>>
# <<< EXECUTE_SUCCESS: 'have $y->[1] = 4' >>>
# <<< EXECUTE_SUCCESS: 'have $squared->[0] = 1' >>>
# <<< EXECUTE_SUCCESS: 'have $squared->[1] = 16' >>>
# <<< EXECUTE_SUCCESS: 'have $divide_by_zero_xy->[0] = inf' >>>
# <<< EXECUTE_SUCCESS: 'have $divide_by_zero_xy->[1] = 0' >>>
# <<< EXECUTE_SUCCESS: 'have $divide_by_zero_yx->[0] = 0' >>>
# <<< EXECUTE_SUCCESS: 'have $divide_by_zero_yx->[1] = inf' >>>
# DEV NOTE: Perl v5.22 & newer uses 'Inf', older uses 'inf', must use regex to match both
# <<< EXECUTE_SUCCESS_REGEX: 'have \$subtract_infinity->\[0\] = [iI]nf' >>>
# <<< EXECUTE_SUCCESS_REGEX: 'have \$subtract_infinity->\[1\] = -[iI]nf' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use rperlsse;

# [[[ OPERATIONS ]]]

my sse_number_pair $x = sse_number_pair->new();
my sse_number_pair $y = sse_number_pair->new();

$x->[0] = 1;
$x->[1] = 0;
$y->[0] = 0;
$y->[1] = 4;

print 'have $x->[0] = ', $x->[0], "\n";
print 'have $x->[1] = ', $x->[1], "\n";
print 'have $y->[0] = ', $y->[0], "\n";
print 'have $y->[1] = ', $y->[1], "\n";

# PERLTIDY BUG: must use strange formatting instead of clean formatting to avoid PERLOPS_PERLTYPES generation failure to match
#my sse_number_pair $squared = ( $x sse_mul $x ) sse_add ( $y sse_mul $y );
#my sse_number_pair $divide_by_zero_xy = ( $x sse_div $y );
#my sse_number_pair $divide_by_zero_yx = ( $y sse_div $x );
#my sse_number_pair $subtract_infinity = ( $x sse_div $y ) sse_sub ( $y sse_div $x );

my sse_number_pair $squared = ( $x sse_mul $x) sse_add( $y sse_mul $y);
my sse_number_pair $divide_by_zero_xy = ( $x sse_div $y);
my sse_number_pair $divide_by_zero_yx = ( $y sse_div $x);
my sse_number_pair $subtract_infinity = ( $x sse_div $y) sse_sub( $y sse_div $x);

print 'have $squared->[0] = ', $squared->[0], "\n";
print 'have $squared->[1] = ', $squared->[1], "\n";
print 'have $divide_by_zero_xy->[0] = ', $divide_by_zero_xy->[0], "\n";
print 'have $divide_by_zero_xy->[1] = ', $divide_by_zero_xy->[1], "\n";
print 'have $divide_by_zero_yx->[0] = ', $divide_by_zero_yx->[0], "\n";
print 'have $divide_by_zero_yx->[1] = ', $divide_by_zero_yx->[1], "\n";
print 'have $subtract_infinity->[0] = ', $subtract_infinity->[0], "\n";
print 'have $subtract_infinity->[1] = ', $subtract_infinity->[1], "\n";


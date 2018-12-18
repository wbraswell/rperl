#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $x->[0] = 1' >>>
# <<< EXECUTE_SUCCESS: 'have $x->[1] = 2' >>>
# <<< EXECUTE_SUCCESS: 'have $y->[0] = 3' >>>
# <<< EXECUTE_SUCCESS: 'have $y->[1] = 4' >>>
# <<< EXECUTE_SUCCESS: 'have $squared->[0] = 10' >>>
# <<< EXECUTE_SUCCESS: 'have $squared->[1] = 20' >>>
# <<< EXECUTE_SUCCESS: 'have $foo->[0] = -2.66' >>>
# <<< EXECUTE_SUCCESS: 'have $foo->[1] = -1.5' >>>

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
$x->[1] = 2;
$y->[0] = 3;
$y->[1] = 4;

print 'have $x->[0] = ', $x->[0], "\n";
print 'have $x->[1] = ', $x->[1], "\n";
print 'have $y->[0] = ', $y->[0], "\n";
print 'have $y->[1] = ', $y->[1], "\n";

# PERLTIDY BUG: must use strange formatting instead of clean formatting to avoid PERLOPS_PERLTYPES generation failure to match
#my sse_number_pair $squared = ( $x sse_mul $x ) sse_add ( $y sse_mul $y );
#my sse_number_pair $foo =     ( $x sse_div $y ) sse_sub ( $y sse_div $x );
my sse_number_pair $squared = ( $x sse_mul $x) sse_add( $y sse_mul $y);
my sse_number_pair $foo = ( $x sse_div $y) sse_sub( $y sse_div $x);

print 'have $squared->[0] = ', $squared->[0], "\n";
print 'have $squared->[1] = ', $squared->[1], "\n";
print 'have $foo->[0] = ', $foo->[0], "\n";
print 'have $foo->[1] = ', $foo->[1], "\n";


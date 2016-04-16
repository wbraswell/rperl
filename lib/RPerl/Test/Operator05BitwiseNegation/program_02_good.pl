#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = 0' >>>
# <<< EXECUTE_SUCCESS: 'have $bar = 1' >>>
# <<< EXECUTE_SUCCESS: 'have $bat = -1' >>>
# <<< EXECUTE_SUCCESS: 'have $baz = -2' >>>
# <<< EXECUTE_SUCCESS: 'have $foo = -6' >>>
# <<< EXECUTE_SUCCESS: 'have $bar = -7' >>>
# <<< EXECUTE_SUCCESS: 'have $bat = 5' >>>
# <<< EXECUTE_SUCCESS: 'have $baz = -2' >>>
# <<< EXECUTE_SUCCESS: 'have $bax = -6' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use integer;

# [[[ OPERATIONS ]]]

my integer $foo = 0;
my integer $bar = 1;
my integer $bat = ~($foo);
my integer $baz = ~($bar);

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";

$foo = ~(5);
$bar = ~(6);
$bat = ~(-6);
$baz = ~( $foo - $bar );
my integer $bax = ~(~($foo));

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

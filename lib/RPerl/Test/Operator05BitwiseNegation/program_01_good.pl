#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS_INTEGER_32: 'have $foo = 0' >>>
# <<< EXECUTE_SUCCESS_INTEGER_32: 'have $bar = 1' >>>
# <<< EXECUTE_SUCCESS_INTEGER_32: 'have $bat = 4294967295' >>>
# <<< EXECUTE_SUCCESS_INTEGER_32: 'have $baz = 4294967294' >>>
# <<< EXECUTE_SUCCESS_INTEGER_32: 'have $foo = 4294967290' >>>
# <<< EXECUTE_SUCCESS_INTEGER_32: 'have $bar = 4294967289' >>>
# <<< EXECUTE_SUCCESS_INTEGER_32: 'have $bat = 5' >>>
# <<< EXECUTE_SUCCESS_INTEGER_32: 'have $baz = 4294967294' >>>
# <<< EXECUTE_SUCCESS_INTEGER_32: 'have $bax = 4294967290' >>>

# <<< EXECUTE_SUCCESS_INTEGER_64: 'have $foo = 0' >>>
# <<< EXECUTE_SUCCESS_INTEGER_64: 'have $bar = 1' >>>
# <<< EXECUTE_SUCCESS_INTEGER_64: 'have $bat = 18446744073709551615' >>>
# <<< EXECUTE_SUCCESS_INTEGER_64: 'have $baz = 18446744073709551614' >>>
# <<< EXECUTE_SUCCESS_INTEGER_64: 'have $foo = 18446744073709551610' >>>
# <<< EXECUTE_SUCCESS_INTEGER_64: 'have $bar = 18446744073709551609' >>>
# <<< EXECUTE_SUCCESS_INTEGER_64: 'have $bat = 5' >>>
# <<< EXECUTE_SUCCESS_INTEGER_64: 'have $baz = 18446744073709551614' >>>
# <<< EXECUTE_SUCCESS_INTEGER_64: 'have $bax = 18446744073709551610' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my unsigned_integer $foo = 0;
my unsigned_integer $bar = 1;
my unsigned_integer $bat = ~($foo);
my unsigned_integer $baz = ~($bar);

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";

$foo = ~(5);
$bar = ~(6);
$bat = ~(-6);
$baz = ~( $foo - $bar );
my unsigned_integer $bax = ~(~($foo));

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

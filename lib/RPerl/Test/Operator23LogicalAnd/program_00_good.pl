#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "have $foo_integer = 9_123" >>>
# <<< EXECUTE_SUCCESS: "have $foo_number  = 9_123.45" >>>
# <<< EXECUTE_SUCCESS: "have $foo_string  = howdy" >>>
# <<< EXECUTE_SUCCESS: "have $aaa_boolean = 0" >>>
# <<< EXECUTE_SUCCESS: "have $bbb_boolean = 0" >>>
# <<< EXECUTE_SUCCESS: "have $ccc_boolean = 0" >>>
# <<< EXECUTE_SUCCESS: "have $ddd_boolean = 1" >>>
# <<< EXECUTE_SUCCESS: "have $aaa_integer = 9_123" >>>
# <<< EXECUTE_SUCCESS: "have $bbb_integer = 22" >>>
# <<< EXECUTE_SUCCESS: "have $aaa_number  = 9_123.45" >>>
# <<< EXECUTE_SUCCESS: "have $bbb_number  = -22.3" >>>
# <<< EXECUTE_SUCCESS: "have $aaa_string  = howdy" >>>
# <<< EXECUTE_SUCCESS: "have $bbb_string  = doody" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $foo_integer = 9_123;
my number  $foo_number  = 9_123.456_789;
my string  $foo_string  = 'howdy';

print 'have $foo_integer = ', integer_to_string($foo_integer), "\n";
print 'have $foo_number  = ',  number_to_string($foo_number), "\n";
print 'have $foo_string  = ',  $foo_string, "\n";
print "\n";

my boolean $aaa_boolean = (0 and 0);
my boolean $bbb_boolean = (0 and 1);
my boolean $ccc_boolean = (1 and 0);
my boolean $ddd_boolean = (1 and 1);

my integer $aaa_integer = (22 and $foo_integer);
my integer $bbb_integer = ($foo_integer and 22);

my number  $aaa_number = (-22.3 and $foo_number);
my number  $bbb_number = ($foo_number and -22.3);

my string  $aaa_string = ('doody' and $foo_string);
my string  $bbb_string = ($foo_string and 'doody');

print 'have $aaa_boolean = ', $aaa_boolean, "\n";
print 'have $bbb_boolean = ', $bbb_boolean, "\n";
print 'have $ccc_boolean = ', $ccc_boolean, "\n";
print 'have $ddd_boolean = ', $ddd_boolean, "\n";

print 'have $aaa_integer = ', integer_to_string($aaa_integer), "\n";
print 'have $bbb_integer = ', integer_to_string($bbb_integer), "\n";

print 'have $aaa_number  = ', number_to_string($aaa_number), "\n";
print 'have $bbb_number  = ', number_to_string($bbb_number), "\n";

print 'have $aaa_string  = ', $aaa_string, "\n";
print 'have $bbb_string  = ', $bbb_string, "\n";


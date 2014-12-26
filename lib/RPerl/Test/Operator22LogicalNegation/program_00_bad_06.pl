#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'near "not ;"' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $foo = 0;
my integer $bar = 1;
my integer $bat = not $foo;
my integer $baz = not ($bar);

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";

$foo = 2;
$bar = 3;
not ;
$baz = not ( $foo - $bar );    # returns empty string ''
my integer $bax = not not $foo;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

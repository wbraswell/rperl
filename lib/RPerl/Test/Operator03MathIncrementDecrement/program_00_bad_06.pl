#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'Can't modify constant item in postincrement' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $foo = 2;
my integer $bar = 3;

3++;

my integer $bat = $foo++;

$bar--;

my integer $baz = $bar--;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";

++$foo;

$bat = ++$foo;

--$bar;

$baz = --$bar;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";

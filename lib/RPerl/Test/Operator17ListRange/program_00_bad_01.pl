#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected Token:  *' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my number $foo = 123;
my string $bar = 'ab';
my integer__array_ref $bat;
$bat = [ $foo .. 22 ];
my integer__array_ref $baz;
$baz = [ 22 .. * $foo ];
my integer__array_ref $bax;
$bax = [ 0 .. 23 ];

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', ::integer__array_ref__to_string($bat), "\n";
print 'have $baz = ', ::integer__array_ref__to_string($baz), "\n";
print 'have $bax = ', ::integer__array_ref__to_string($bax), "\n";

my string__array_ref $bat2;
$bat2 = [ $bar .. 'ac' ];
my string__array_ref $baz2;
$baz2 = [ 'a2' .. 'a4' ];
my string__array_ref $bax2;
$bax2 = [ 'a' .. $bar ];

print 'have $bat2 = ', ::string__array_ref__to_string($bat2), "\n";
print 'have $baz2 = ', ::string__array_ref__to_string($baz2), "\n";
print 'have $bax2 = ', ::string__array_ref__to_string($bax2), "\n";

#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  .' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my number $foo = 123;
my string $bar = 'ab';
my integer_arrayref $bat;
$bat = [ $foo ... 22 ];
my integer_arrayref $baz;
$baz = [ 22 .. $foo ];
my integer_arrayref $bax;
$bax = [ 0 .. 23 ];

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', ::integer_arrayref_to_string($bat), "\n";
print 'have $baz = ', ::integer_arrayref_to_string($baz), "\n";
print 'have $bax = ', ::integer_arrayref_to_string($bax), "\n";

my string_arrayref $bat2;
$bat2 = [ $bar .. 'ac' ];
my string_arrayref $baz2;
$baz2 = [ 'a2' .. 'a4' ];
my string_arrayref $bax2;
$bax2 = [ 'a' .. $bar ];

print 'have $bat2 = ', ::string_arrayref_to_string($bat2), "\n";
print 'have $baz2 = ', ::string_arrayref_to_string($baz2), "\n";
print 'have $bax2 = ', ::string_arrayref_to_string($bax2), "\n";

#!/usr/bin/perl
# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $foo = abs 3;
my integer $bar = -3;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";

$bar = $foo + $foo;
$bar = abs $bar;

my integer $other_integer = abs -5;
my integer $onemore_integer = -5;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $other_integer = ', $other_integer, "\n";
print 'have $onemore_integer = ', $onemore_integer, "\n";

$other_integer = abs $other_integer;
$onemore_integer = abs $onemore_integer;

print 'have $other_integer = ', $other_integer, "\n";
print 'have $onemore_integer = ', $onemore_integer, "\n";

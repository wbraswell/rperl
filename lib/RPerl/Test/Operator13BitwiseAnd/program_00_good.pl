#!/usr/bin/env perl
# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my number $foo  = 9_123.456_789;
my string $bar  = 'howdy';
my integer $bat = $foo & 22;
my integer $baz = 9_123.456_789 & $foo;
my integer $bax = 33 & 44;
my unsigned_integer $unsignedfoo = 0;
my unsigned_integer $unsignedbar = 1;
my unsigned_integer $unsignedbat = $unsignedfoo & 22 ;
my unsigned_integer $unsignedbaz = $unsignedfoo & $unsignedbar ;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";
print 'have $unsignedfoo = ', $unsignedfoo, "\n";
print 'have $unsignedbar = ', $unsignedbar, "\n";
print 'have $unsignedbat = ', $unsignedbat, "\n";
print 'have $unsignedbaz = ', $unsignedbaz, "\n";

$bat = $bar & 'abc';
$baz = '444' & '222';
$bax = '33' & $bar;
$unsignedfoo = 2;
$unsignedbar = 3;
$unsignedbat = $unsignedfoo & 33;
$unsignedbaz = $unsignedfoo & $unsignedbar ;

print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";
print 'have $unsignedfoo = ', $unsignedfoo, "\n";
print 'have $unsignedbar = ', $unsignedbar, "\n";
print 'have $unsignedbat = ', $unsignedbat, "\n";
print 'have $unsignedbaz = ', $unsignedbaz, "\n";

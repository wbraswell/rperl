#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  (' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my number $foo = 9_123.456_789;
my number $bar = 2_112;
my number $bat = ( 22 > 21 ) ? $foo : $bar;
my number $baz = 0 ? $foo : ( 4 <= 4 );
my number $bax = 1 ? 99.9 : 100.1;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

$bat = ( 'howdy' ne 'dowdy' ) ? $foo : 22_222.33;
$baz = ( 4 <= 4 )             ? 88   : $bar;
$bax = ( 88 > 99 )            ? 21   : 12;

print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

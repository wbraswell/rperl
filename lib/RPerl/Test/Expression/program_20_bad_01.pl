#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected token:  <<< NO TOKEN FOUND >>>' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# BUG BOUNTY #000, 50 CodeCoin: modify all ::number*__stringify() to output underscores, to match LITERAL_STRING grammar token input

# [[[ OPERATIONS ]]]

my number $foo            = 9_123.456_789;
my number__array_ref $bar = [ 21, 12, 43.23, 987.654_321 ];
my string $bat            = main::number__stringify($foo);
my string $baz            = ::number__array_ref__stringify($bar);
my string $bax = ::string__array_ref__stringify( [ 'abc', '123', 'lalala' ] );

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

$bat = ::integer__hash_ref__stringify(
    { foo => 23, bar => 56, quux => 123_456 } );
$baz = ::number__hash_ref__stringify(
    { foo => 23.4, bar => 56.789, quux => 123_456.789_012 } );
$bax = ::string__hash_ref__stringify
    { foo => 'howdy', bar => 'dowdy', quux => 'doo' };

print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

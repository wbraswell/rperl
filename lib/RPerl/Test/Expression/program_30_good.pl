#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my number $foo            = 9_123.456_789;
my number_arrayref $bar = [ 21, 12, 43.23, 987.654_321 ];
my string $bat            = main::number_to_string($foo);
my string $baz            = ::number_arrayref_to_string($bar);
my string $bax = ::string_arrayref_to_string( [ 'abc', '123', 'lalala' ] );

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

$bat = ::integer_hashref_to_string(
    { foo => 23, bar => 56, quux => 123_456 } );
$baz = ::number_hashref_to_string(
    { foo => 23.4, bar => 56.789, quux => 123_456.789_012 } );
$bax = ::string_hashref_to_string(
    { foo => 'howdy', bar => 'dowdy', quux => 'doo' } );

print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

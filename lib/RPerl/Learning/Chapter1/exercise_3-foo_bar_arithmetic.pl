#!/usr/bin/perl

# Learning RPerl, Chapter 1, Exercise 3
# Foo Bar Arithmetic Example

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]
my integer $foo = 21 + 12;
my integer $bar = 23 * 42;
my number  $baz = to_number($bar) / $foo;
my number  $zab = to_number($foo) / $bar;
print 'have $foo = ' . to_string($foo) . "\n";
print 'have $bar = ' . to_string($bar) . "\n";
print 'have $baz = ' . to_string($baz) . "\n";
print 'have $zab = ' . to_string($zab) . "\n";

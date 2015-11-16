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
my number $foo = 21 + 12;
my number $bar = 23 * 42;
#my number $baz = $foo / $bar;
my number $baz = $bar / $foo;
print 'have $foo = ' . $foo . "\n";
print 'have $bar = ' . $bar . "\n";
print 'have $baz = ' . $baz . "\n";

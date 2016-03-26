#!/usr/bin/perl

# Learning RPerl, Chapter 2, Exercise 7
# Calculate the sum of the first n integers, without using a loop; 1 + 2 + 3 + ... + n = ?

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ OPERATIONS ]]]
print 'Please input a positive integer: ';
my string $n_string = <STDIN>;
my integer $n = string_to_integer($n_string);

if ($n < 0) { die to_string($n) . ' is not positive, dying' . "\n"; }

my integer $sum = 0;
my integer $n_original = $n;
my integer $n_odd = 0;

if ($n % 2) {
    $n_odd = $n;
    $n--;
}

$sum = (($n + 1) * ($n / 2)) + $n_odd;

print 'The sum of the first ' . to_string($n_original) . ' integers = ' . to_string($sum) . "\n";
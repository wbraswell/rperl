#!/usr/bin/perl

# Learning RPerl, Chapter 2, Exercise 6
# Calculate the sum of the first n integers; 1 + 2 + 3 + ... + n = ?

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ OPERATIONS ]]]
print 'Please input a positive integer: ';
my string $n_string = <STDIN>;
my integer $n = string_to_integer($n_string);

if ($n < 0) { die 'ERROR: ', to_string($n), ' is not positive, dying', "\n"; }

my integer $sum = 0;
my integer $i = 1;

while ($i <= $n) {
    $sum += $i;
    $i++;
}

print 'The sum of the first ', to_string($n), ' integers = ', to_string($sum), "\n";
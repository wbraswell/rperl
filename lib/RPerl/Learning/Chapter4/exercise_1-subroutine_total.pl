#!/usr/bin/perl

# Learning RPerl, Chapter 4, Exercise 1
# Subroutine & driver to calculate the totals of arrays of stringified numbers, both hard-coded and user-supplied

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ SUBROUTINES ]]]

our number $total_stringified = sub {
    (my string_arrayref $input_numbers_stringified) = @_;
    my number $retval = 0;
    foreach my string $input_number_stringified (@{$input_numbers_stringified}) {
        $retval += string_to_number($input_number_stringified);
    }
    return $retval;
};

# [[[ OPERATIONS ]]]

my string_arrayref $fred = [qw(1 3 5 7 9)];
my number $fred_total = total_stringified($fred);
print 'The total of $fred is ' . $fred_total . '.' . "\n";

print 'Please input zero or more numbers, separated by <ENTER>, ended by <CTRL-D>:' . "\n";
my number $user_total = total_stringified([<STDIN>]);
print 'The total of those numbers is ' . $user_total . '.' . "\n";
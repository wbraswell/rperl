#!/usr/bin/env perl

# Learning RPerl, Chapter 4, Exercise 1
# Subroutine & driver to calculate the totals of arrays of stringified numbers, both hard-coded and user-supplied

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ SUBROUTINES ]]]

sub total {
    { my number $RETURN_TYPE };
    (my number_arrayref $input_numbers) = @ARG;
    my number $retval = 0;
    foreach my number $input_number (@{$input_numbers}) {
        $retval += $input_number;
    }
    return $retval;
}

# [[[ OPERATIONS ]]]

my number_arrayref $fred = [1, 3, 5, 7, 9];
my number $fred_total = total($fred);
print 'The total of $fred is ', to_string($fred_total), "\n";

print 'Please input zero or more numbers, separated by <ENTER>, ended by <CTRL-D>:', "\n";

my number_arrayref $input_numbers = [];
while (my string $input_string = <STDIN>) {
    push @{$input_numbers}, string_to_number($input_string);
}

my number $user_total = total($input_numbers);
print 'The total of those numbers is ', to_string($user_total), "\n";

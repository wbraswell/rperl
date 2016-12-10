#!/usr/bin/perl

# Learning RPerl, Chapter 4, Exercise 3
# Subroutines & driver to calculate the above-average elements of hard-coded arrays

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]

our number $total = sub {
    ( my number_arrayref $input_numbers ) = @ARG;
    my number $retval = 0;
    foreach my number $input_number ( @{$input_numbers} ) {
        $retval += $input_number;
    }
    return $retval;
};

our number $average = sub {
    ( my number_arrayref $input_numbers ) = @ARG;
    return (total($input_numbers) / (scalar @{$input_numbers}));
};

our number_arrayref $above_average = sub {
    ( my number_arrayref $input_numbers ) = @ARG;
    my number $average = average($input_numbers);
    my number_arrayref $retval = [];
    foreach my number $input_number (@{$input_numbers}) {
        if ($input_number > $average) {
            push @{$retval}, $input_number;
        }
    }
    return $retval;
};

# [[[ OPERATIONS ]]]

my string_arrayref $fred = [1 .. 10];
my number $fred_above_average = above_average($fred);
print '$fred is ', number_arrayref_to_string($fred), "\n";
print 'The above-average elements of $fred are ', number_arrayref_to_string($fred_above_average), "\n";
print '(Should be [6, 7, 8, 9, 10])', "\n\n";

my string_arrayref $barney = [100, 1 .. 10];
my number $barney_above_average = above_average($barney);
print '$barney is ', number_arrayref_to_string($barney), "\n";
print 'The above-average elements of $barney are ', number_arrayref_to_string($barney_above_average), "\n";
print '(Should be just [100])', "\n";

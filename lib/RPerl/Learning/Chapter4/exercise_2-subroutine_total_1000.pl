#!/usr/bin/perl

# Learning RPerl, Chapter 4, Exercise 2
# Subroutine & driver to calculate the total of 1 to 1,000

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]

sub total {
    { my number $RETURN_TYPE };
    ( my number_arrayref $input_numbers ) = @ARG;
    my number $retval = 0;
    foreach my number $input_number ( @{$input_numbers} ) {
        $retval += $input_number;
    }
    return $retval;
}

# [[[ OPERATIONS ]]]

my number_arrayref $one_to_one_thousand = [ 1 .. 1_000 ];
my number $one_to_one_thousand_total    = total($one_to_one_thousand);
print 'The total of 1 to 1_000 is ', to_string($one_to_one_thousand_total), q{.}, "\n";

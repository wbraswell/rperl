#!/usr/bin/perl

# Learning RPerl, Chapter 5, Exercise 3
# Accept column width followed by one or more input lines, and print lines in a right-justified format

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ SUBROUTINES ]]]

our string_arrayref $right_justify_20 = sub {
    my string_arrayref $input_strings = [];
    print 'Please input integer column width, then press <ENTER>, then press <CTRL-D>:' . "\n";
    my integer $column_width = string_to_integer(<STDIN>);
 
    print 'Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:' . "\n";
    while (my string $input_string = <STDIN>) {
        push @{$input_strings}, $input_string;
    } 

    my integer $ruler_width_tens = 6;  # default to ruler line width 60
    if ($column_width > 60) {
# START HERE: fix number-to-integer math
# START HERE: fix number-to-integer math
# START HERE: fix number-to-integer math
        $ruler_width_tens = (number_to_integer($column_width / 10) * 10) + 10;
    }

    print "\n";
    print '1234567890' x $ruler_width_tens;
    print "\n";

    foreach my $input_string (@{$input_strings}) {
        print q{ } x (($column_width + 1) - (length $input_string));
        print $input_string;
    }
};

# [[[ OPERATIONS ]]]

right_justify_20();
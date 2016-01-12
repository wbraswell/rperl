#!/usr/bin/perl

# Learning RPerl, Chapter 5, Exercise 3
# Accept column width followed by one or more input lines, and print lines in a right-justified format

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ SUBROUTINES ]]]

our void $right_justify_variable = sub {
    my string_arrayref $input_strings = [];
    print 'Please input integer column width, then press <ENTER>:' . "\n";
    my string $column_width_string = <STDIN>;
    my integer $column_width       = string_to_integer($column_width_string);

    print 'Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:' . "\n";
    while ( my string $input_string = <STDIN> ) {
        push @{$input_strings}, $input_string;
    }

    my integer $ruler_width_tens = 6;    # default to ruler line width 60
    if ( $column_width > 60 ) {
        $ruler_width_tens = number_to_integer( $column_width / 10 ) + 1;
    }

    print "\n";
    print '1234567890' x $ruler_width_tens;
    print "\n";

    foreach my string $input_string ( @{$input_strings} ) {
        chomp $input_string;
        print q{ } x ( $column_width - ( length $input_string ) );
        print $input_string . "\n";
    }
};

# [[[ OPERATIONS ]]]

right_justify_variable();

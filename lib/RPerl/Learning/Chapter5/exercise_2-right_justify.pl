#!/usr/bin/perl

# Learning RPerl, Chapter 5, Exercise 2
# Accept one or more input lines, and print them in a right-justified 20-column format

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ SUBROUTINES ]]]

our void $right_justify_20 = sub {
    my string_arrayref $input_strings = [];
    print 'Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:' . "\n";
    while ( my string $input_string = <STDIN> ) {
        push @{$input_strings}, $input_string;
    }

    print "\n";
    print '1234567890'x 6;
    print "\n";

    foreach my string $input_string ( @{$input_strings} ) {
        print q{ }x ( 21 - ( length $input_string ) );
        print $input_string;
    }
};

# [[[ OPERATIONS ]]]

right_justify_20();

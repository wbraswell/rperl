#!/usr/bin/perl

# Learning RPerl, Chapter 6, Exercise 2
# Accept a list of words, and print the count of each unique word

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]

our void $unique_word_count = sub {
    my string_hashref $words = {};

    print 'Please input zero or more words, separated by <ENTER>, ended by <CTRL-D>:' . "\n";
    while (my string $input_word = <STDIN>) {
        chomp $input_word;
        if (not exists $words->{$input_word}) {
            $words->{$input_word} = 1;
        }
        else {
            $words->{$input_word} += 1;
        }
    } 

    print "\n" . 'Unique word count:' . "\n";

    foreach my string $unique_word (sort keys %{$words}) {
        print $unique_word . ' appeared ' . $words->{$unique_word} . ' time(s)' . "\n";
    }
};

# [[[ OPERATIONS ]]]

unique_word_count();
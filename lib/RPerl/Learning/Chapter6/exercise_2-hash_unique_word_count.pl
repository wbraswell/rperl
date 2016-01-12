#!/usr/bin/perl

# Learning RPerl, Chapter 6, Exercise 2
# Accept a list of words, and print the count of each unique word

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ SUBROUTINES ]]]

our void $unique_word_count = sub {
    my integer_hashref $word_counts = {};

    print 'Please input zero or more words, separated by <ENTER>, ended by <CTRL-D>:' . "\n";
    while (my string $input_word = <STDIN>) {
        chomp $input_word;
        if (not exists $word_counts->{$input_word}) {
            $word_counts->{$input_word} = 1;
        }
        else {
            $word_counts->{$input_word} += 1;
        }
    }

    print "\n" . 'Unique word count:' . "\n";

    foreach my string $unique_word (sort keys %{$word_counts}) {
        print $unique_word . ' appeared ' . to_string($word_counts->{$unique_word}) . ' time(s)' . "\n";
    }
};

# [[[ OPERATIONS ]]]

unique_word_count();
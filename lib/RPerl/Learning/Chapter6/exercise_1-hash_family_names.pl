#!/usr/bin/perl

# Learning RPerl, Chapter 6, Exercise 1
# Accept one input given (first) name, and print the corresponding family (last) name

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ SUBROUTINES ]]]

our void $given_to_family_name = sub {
    my string_hashref $names = {
        fred => 'flintstone',
        barney => 'rubble',
        wilma => 'flintstone'
    };

    print 'Please input a given (first) name in all lowercase, then press <ENTER>:', "\n";
    my string $given_name = <STDIN>;
    chomp $given_name;

    if ((not exists $names->{$given_name}) or (not defined $names->{$given_name})) {
        croak 'ERROR: No family (last) name found for given (first) name ', $given_name, ', croaking', "\n";
    }

    print 'The family (last) name of ', $given_name, ' is ', $names->{$given_name}, q{.}, "\n";
};

# [[[ OPERATIONS ]]]

given_to_family_name();

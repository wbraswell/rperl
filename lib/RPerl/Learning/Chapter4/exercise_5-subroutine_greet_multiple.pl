#!/usr/bin/perl

# Learning RPerl, Chapter 4, Exercise 5
# Subroutine & driver to greet multiple users

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]

our string_arrayref $greet = sub {
    ( my string $name, my string_arrayref $previous_names ) = @ARG;
    print 'Hi ', $name, '!  ';
    if ((scalar @{$previous_names}) == 0) {
        print 'You are the first one here!', "\n";
    }
    else {
        print q{I've seen: }, (join q{ }, @{$previous_names}), "\n";
    }
    push @{$previous_names}, $name;
    return $previous_names;
};

# [[[ OPERATIONS ]]]

my string_arrayref $previous_names = [];
$previous_names = greet('Fred', $previous_names);
$previous_names = greet('Barney', $previous_names);
$previous_names = greet('Wilma', $previous_names);
$previous_names = greet('Betty', $previous_names);

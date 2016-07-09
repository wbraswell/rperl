#!/usr/bin/perl

# Learning RPerl, Chapter 4, Exercise 4
# Subroutine & driver to greet users

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]

our string $greet = sub {
    ( my string $name, my string $previous_name ) = @_;
    print 'Hi ', $name, '!  ';
    if ($previous_name eq q{}) {
        print 'You are the first one here!', "\n";
    }
    else {
        print $previous_name, ' is also here!', "\n";
    }
    return $name;
};

# [[[ OPERATIONS ]]]

my string $previous_name = q{};
$previous_name = greet('Fred', $previous_name);
$previous_name = greet('Barney', $previous_name);
$previous_name = greet('Wilma', $previous_name);
$previous_name = greet('Betty', $previous_name);
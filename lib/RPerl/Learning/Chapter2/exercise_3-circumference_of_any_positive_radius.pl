#!/usr/bin/perl

# Learning RPerl, Chapter 2, Exercise 3
# Find the circumference of a circle with any positive radius entered by the user

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

use constant PI => 3.141_592_654;

# [[[ OPERATIONS ]]]
print 'Please input radius: ';
my string $radius_string = <STDIN>;
my number $radius = string_to_number($radius_string);
my number $circumference;

if ($radius >= 0) {
    $circumference = 2 * PI() * $radius;
}
else {
    print 'Negative radius detected, defaulting to zero circumference!' . "\n";
    $circumference = 0;
}

print "\n";
print 'Pi = ' . PI() . "\n";
print 'Radius = ' . $radius . "\n";
print 'Circumference = 2 * Pi * Radius = 2 * ' . PI() . ' * ' . $radius . ' = ' . $circumference . "\n";

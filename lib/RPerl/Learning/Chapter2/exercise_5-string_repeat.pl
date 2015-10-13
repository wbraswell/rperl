#!/usr/bin/perl

# Learning RPerl, Chapter 2, Exercise 5
# Repeat any string any number of times, both values entered by the user

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ OPERATIONS ]]]
print 'Please input string to be repeated: ';
my string $repeat_string = <STDIN>;

print 'Please input integer (whole number) times to repeat string: ';
my string $repeat_integer_string = <STDIN>;
my integer $repeat_integer = string_to_integer($repeat_integer_string);

print "\n";
print $repeat_string x $repeat_integer;

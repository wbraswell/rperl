#!/usr/bin/perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ OPERATIONS ]]]

my string $input_strings = q{};

print 'Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D> on a blank line:', "\n";

while ( my string $input_string = <STDIN> ) {
    $input_strings .= $input_string;
}

print "\n";
print 'after loop, have $input_strings = ', "\n", $input_strings, "\n";

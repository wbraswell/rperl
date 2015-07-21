#!/usr/bin/perl

# Learning RPerl, Chapter 3, Exercise 3
# Print user-supplied list of strings in ASCIIbetical order, optionally on single line of output

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ CONSTANTS ]]]
use constant SINGLE_LINE_OUTPUT  => my integer $TYPED_SINGLE_LINE_OUTPUT = 0;

# [[[ OPERATIONS ]]]
my string_arrayref $input_strings = [];

print 'Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:' . "\n";

while (my string $input_string = <STDIN>) {
    push @{$input_strings}, $input_string;
}

print "\n";
print 'Strings in ASCIIbetical order:' . "\n";

my string_arrayref $input_strings_sorted = [sort @{$input_strings}];

foreach my string $input_strings_sorted_element (@{$input_strings_sorted}) {
    if (SINGLE_LINE_OUTPUT()) {
        # strip trailing newline, if present
        chomp($input_strings_sorted_element);
        $input_strings_sorted_element .= q{ };
    }
    print $input_strings_sorted_element;
}

print "\n";
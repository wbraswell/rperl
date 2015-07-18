#!/usr/bin/perl

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ OPERATIONS ]]]
my string_arrayref $input_strings = [];

print 'Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:' . "\n";

while (my string $input_string = <STDIN>) {
    push @{$input_strings}, $input_string;
}

print "\n";
print 'Strings in reverse order:' . "\n";

my string_arrayref $input_strings_reversed = [reverse @{$input_strings}];

foreach my string $input_strings_reversed_element (@{$input_strings_reversed}) {
    print $input_strings_reversed_element;
}

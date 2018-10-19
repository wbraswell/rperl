#!/usr/bin/env perl

# Learning RPerl, Section 3.4: Array Length & Negative Indices

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $greetings_length = 3' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_arrayref $greetings        = ['hello', 'hi', 'howdy'];
my integer         $greetings_length = scalar @{$greetings};
print 'have $greetings_length = ', $greetings_length, "\n";

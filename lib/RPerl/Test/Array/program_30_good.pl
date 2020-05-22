#!/usr/bin/env perl

# Learning RPerl, Section 3.1: Lists vs Arrays

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "@variable_storing_array = ( 'list', 'enclosed', 'within', 'square', 'brackets' )" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitQuotedWordLists)  # USER DEFAULT 10: allow ('lists', 'of', 'quoted', 'literal', 'words')

# [[[ OPERATIONS ]]]

my string_array @variable_storing_array = ('list', 'enclosed', 'within', 'square', 'brackets');
print '@variable_storing_array = ', string_array_to_string(@variable_storing_array), "\n";

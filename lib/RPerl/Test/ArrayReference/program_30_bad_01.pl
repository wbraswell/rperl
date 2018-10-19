#!/usr/bin/env perl

# Learning RPerl, Section 3.1: Lists vs Arrays

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::CodeLayout::ProhibitQuotedWordLists' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my @variable_storing_array_by_value = ('list', 'enclosed', 'within', 'round',  'parentheses');
my ($list, $of, $variables) = @variable_storing_array_by_value;
print '$list = ', $list, "\n";

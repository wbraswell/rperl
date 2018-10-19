#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  777' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::ValuesAndExpressions::RequireNumberSeparators' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string $foo = '723.555777';
my number $faa = 723.555777;
my number $bar = string_to_number($foo);
my number $double_bar = $bar * 2;
print 'have $bar = ', number_to_string($bar), "\n";
print 'have $double_bar = ', number_to_string($double_bar), "\n";

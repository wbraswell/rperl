#!/usr/bin/env perl

# Learning RPerl, Section 3.3: How To Access Array Elements

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'The first born is Chico' >>>
# <<< EXECUTE_SUCCESS: 'The middle child is Groucho' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_arrayref $marx_brothers = ['Chico', 'Harpo', 'Groucho', 'Gummo', 'Zeppo'];
print 'The first born is ',   $marx_brothers->[0], "\n";
print 'The middle child is ', $marx_brothers->[2], "\n";

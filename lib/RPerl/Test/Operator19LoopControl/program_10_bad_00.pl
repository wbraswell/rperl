#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPC13' >>>
# <<< PARSE_ERROR: 'RPerl source code input file' >>>
# <<< PARSE_ERROR: 'does not end with newline character or line of all-whitespace characters, dying' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $i = 0;

while ( $i < 10 ) {
    $i++;
    if ( $i % 2 ) {
        next;
    }
    print 'have $i = ', $i, "\n";
}
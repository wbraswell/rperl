#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'foo-bar' >>>
# <<< EXECUTE_SUCCESS: 'quux' >>>
# <<< EXECUTE_SUCCESS: 'zorg+blop' >>>
# <<< EXECUTE_SUCCESS: 'munge/sqap' >>>
# <<< EXECUTE_SUCCESS: 'frob*grul' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_arrayref $s_array = [qw(foo-bar quux zorg+blop munge/sqap frob*grul)];
foreach my string $s ( @{$s_array} ) {
    print '$s = ', $s, "\n";
}

#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'foo-bar-bat' >>>
# <<< EXECUTE_SUCCESS: 'quux' >>>
# <<< EXECUTE_SUCCESS: 'zorg+blop+frun' >>>
# <<< EXECUTE_SUCCESS: 'munge/sqap/cruft' >>>
# <<< EXECUTE_SUCCESS: 'frob*grul*jick' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_arrayref $s_array = [qw(foo-bar-bat quux zorg+blop+frun munge/sqap/cruft frob*grul*jick)];
foreach my string $s ( @{$s_array} ) {
    print '$s = ', $s, "\n";
}

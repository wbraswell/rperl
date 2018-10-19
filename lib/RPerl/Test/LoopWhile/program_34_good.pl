#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'Hello, World #1!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #2!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #3!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #4!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, World #5!' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $i = 1;
while ( $i <= 5 ) {
    print 'Hello, World #', $i, q{!}, "\n";
    $i++;
}

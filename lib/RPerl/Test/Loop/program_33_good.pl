#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'Hello, world #0!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, world #1!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, world #2!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, world #3!' >>>
# <<< EXECUTE_SUCCESS: 'Hello, world #4!' >>>

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
while ( $i < 5 ) {
    print 'Hello, world #', $i, q{!}, "\n";
    $i++;
}

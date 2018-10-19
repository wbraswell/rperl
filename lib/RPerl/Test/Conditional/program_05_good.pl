#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '$foo = 0' >>>
# <<< EXECUTE_SUCCESS: '$foo = 1' >>>
# <<< EXECUTE_SUCCESS: '$foo = 2' >>>
# <<< EXECUTE_SUCCESS: '$foo = 3' >>>
# <<< EXECUTE_SUCCESS: '$foo = 3' >>>
# <<< EXECUTE_SUCCESS: '$foo = 3' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $foo = 0;
print '$foo = ', $foo, "\n";

if ( $foo < 3 ) {
    $foo++;
}
print '$foo = ', $foo, "\n";

if ( $foo < 3 ) {
    $foo++;
}
print '$foo = ', $foo, "\n";

if ( $foo < 3 ) {
    $foo++;
}
print '$foo = ', $foo, "\n";

if ( $foo < 3 ) {
    $foo++;
}
print '$foo = ', $foo, "\n";

if ( $foo < 3 ) {
    $foo++;
}
print '$foo = ', $foo, "\n";

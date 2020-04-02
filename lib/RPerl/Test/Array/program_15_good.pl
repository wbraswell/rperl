#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '$s = buffalo' >>>
# <<< EXECUTE_SUCCESS: '$s = alpha' >>>
# <<< EXECUTE_SUCCESS: '$s = beta' >>>
# <<< EXECUTE_SUCCESS: '$s = gamma' >>>
# <<< EXECUTE_SUCCESS: '$s = howdy' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_array @s_array = ('buffalo', qw(alpha beta gamma), 'howdy');
foreach my string $s ( @s_array ) {
    print '$s = ', $s, "\n";
}

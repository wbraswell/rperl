#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '$s = -1bar-5bat' >>>
# <<< EXECUTE_SUCCESS: '$s = qu23ux' >>>
# <<< EXECUTE_SUCCESS: '$s = zorg0+blop+0frun' >>>
# <<< EXECUTE_SUCCESS: '$s = munge4/4sqap6/6cruft' >>>
# <<< EXECUTE_SUCCESS: '$s = 88frob*99grul99*jick88' >>>
# <<< EXECUTE_SUCCESS: '$s = `~!@$%^&*-_=+[]{}|;:'".<>/?' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_array @s_array = qw(-1bar-5bat qu23ux zorg0+blop+0frun munge4/4sqap6/6cruft 88frob*99grul99*jick88 `~!@$%^&*-_=+[]{}|;:'".<>/?);
foreach my string $s ( @s_array ) {
    print '$s = ', $s, "\n";
}

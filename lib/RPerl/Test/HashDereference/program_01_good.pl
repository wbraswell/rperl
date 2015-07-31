#!/usr/bin/perl
# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

foreach my string $key (
    sort keys %{
        my integer_hashref $TYPED_i_hash
            = { a => 10, b => 20, c => 30, d => 40, e => 50 }
    }
    )
{
    print '$key = ', $key, "\n";
}

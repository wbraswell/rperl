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

my string_hashref $my_hash
    = { a_key => 'howdy', b_key => 'doody', c_key => 'clarabell' };
foreach my string $my_key ( keys %{$my_hash} ) {
    print 'Production rule Loop matched by LoopForEach, iteration item ',
        $my_key, "\n";
}

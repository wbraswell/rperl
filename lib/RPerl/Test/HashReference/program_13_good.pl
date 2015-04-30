#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my unknown_hashref $u_hash = {
    key0 => my integer $TYPED_key0 = -23,
    key1 => my number_arrayref $TYPED_key1
        = [ 42 / 1_701, 21.12, 2_112.23 ],
    key2 => my string_hashref $TYPED_key2 = {
        alpha => 'strings are scalars, too',
        beta  => 'hello world',
        gamma => 'last one'
    }
};
foreach my string $hash_key ( sort keys %{$u_hash} ) {
    print $hash_key, ' => ', Dumper( $u_hash->{$hash_key} ), "\n";
}

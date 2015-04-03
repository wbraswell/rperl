#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected Token:  <<< NO TOKEN FOUND >>>' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

# homogeneous 2-dimensional hash of hashes, using inner types
my hash_ref__hash_ref $hash_hash = {
    key_0 => my integer__hash_ref $TYPED_key_0
        = { a => 17, b => -23, c => 1_701 },
    key_1 => my integer__hash_ref $TYPED_key_1
        = { d => -1, e => 444, f => 2_987 },
    key_2 => my integer__hash_ref $TYPED_key_2
        = { g => -321, h => 7, i => 24_851 }
}

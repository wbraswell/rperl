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

my string__hash_ref $s_hash_0
    = { alpha => 'a', bravo => 'b', charlie => 'c' };
my string__hash_ref $s_hash_1 = { delta => 'd', echo => 'e', foxtrot => 'f' };
my string__hash_ref $s_hash_2 = { golf => 'g', hotel => 'h', india => 'i' };
my string__hash_ref $s_hash_all = {
    subhash_0 => $s_hash_0,
    subhash_3 => { hey => 'you', howdy => 'me' },
    subhash_1 => $s_hash_1,
    subhash_4 => { wahoo => 'yeehaw', hoowee => 'haayee' },
    subhash_2 => $s_hash_2
}

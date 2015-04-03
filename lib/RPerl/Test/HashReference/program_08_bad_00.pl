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

my scalartype $mystery_scalar    = 21.12;
my scalartype__hash_ref $sc_hash = {
    foo => my integer $TYPED_sc_hash_foo    = 17,
    bar => my number $TYPED_sc_hash_bar     = 42 / 1_701,
    bat => my string $TYPED_sc_hash_bat     = 'strings are scalars, too',
    baz => my scalartype $TYPED_sc_hash_baz = $mystery_scalar
}

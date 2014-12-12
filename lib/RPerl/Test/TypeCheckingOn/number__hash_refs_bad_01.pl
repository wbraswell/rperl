#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR ENVHVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: "number__hash_ref element value expected but non-number value found at key 'b'" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingOn::AllTypes;

# [[[ OPERATIONS ]]]
my number__hash_ref $input_1
    = { a => -999_999, b => 3.0, c => 4.0, d => -12.0 };
my number__hash_ref $input_2
    = { a => -999_999, b => 3.0, c => 4.0, d => -12.0 };
my number__hash_ref $input_3
    = { a => -999_999.123_456, b => "23.0\n", c => 42.0, d => -2112.0 };
check__number__hash_refs( $input_1, $input_2, $input_3 );

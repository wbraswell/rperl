#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR ENVHVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< EXECUTE_ERROR: "number_hashref element value expected but non-number value found at key 'd'" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingOn::AllTypes;

# [[[ OPERATIONS ]]]
my number_hashref $input_1
    = { a => -999_999, b => 3.0, c => 4.0, d => 'howdy' };
my number_hashref $input_2
    = { a => -999_999, b => 3.0, c => 4.0, d => -12.0 };
my number_hashref $input_3
    = { a => -999_999.123_456, b => 23.0, c => 42.0, d => -2112.0 };
check_number_hashrefs( $input_1, $input_2, $input_3 );

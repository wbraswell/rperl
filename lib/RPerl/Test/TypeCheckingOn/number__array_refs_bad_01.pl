#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR ENVAVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: 'number__array_ref element value expected but non-number value found at index 1' >>>

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
my number__array_ref $input_1 = [ -999_999,         3.0,      4.0,  12.0 ];
my number__array_ref $input_2 = [ -999_999,         3.0,      4.0,  -12.0 ];
my number__array_ref $input_3 = [ -999_999.123_456, "23.0\n", 42.0, -2112.0 ];
check__number__array_refs( $input_1, $input_2, $input_3 );

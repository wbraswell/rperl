#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR ENVAVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: 'number_arrayref element value expected but non-number value found at index 3' >>>
# <<< RUN_ERROR: 'in variable $input_1 from subroutine check_number_arrayrefs()' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingTrace::AllTypes;

# [[[ OPERATIONS ]]]
my number_arrayref $input_1 = [ -999_999,         3.0,  4.0,  'howdy' ];
my number_arrayref $input_2 = [ -999_999,         3.0,  4.0,  -12.0 ];
my number_arrayref $input_3 = [ -999_999.123_456, 23.0, 42.0, -2112.0 ];
check_number_arrayrefs( $input_1, $input_2, $input_3 );

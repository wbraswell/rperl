#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR EIVHVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< EXECUTE_ERROR: "integer_hashref element value expected but non-integer value found at key 'd'" >>>
# <<< EXECUTE_ERROR: 'in variable $input_1 from subroutine check_integer_hashref()' >>>

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
check_integer_hashref( { a => -999_999, b => 3, c => 4, d => { a => 0, b => 1, c => 2 } } );

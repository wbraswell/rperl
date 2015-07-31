#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR EHVRV01, TYPE-CHECKING MISMATCH' >>>
# <<< EXECUTE_ERROR: 'hashref value expected but non-hashref value found' >>>
# <<< EXECUTE_ERROR: 'in variable $input_1 from subroutine check_hashref()' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingTrace::AllTypes;

# [[[ OPERATIONS ]]]
check_hashref( [ 0, 1, 2 ] );

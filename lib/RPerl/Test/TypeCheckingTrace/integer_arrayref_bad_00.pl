#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR EIVAVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< EXECUTE_ERROR: 'integer value expected but non-integer value found at index 3' >>>
# <<< EXECUTE_ERROR: 'in variable $input_1 from subroutine check_integer_arrayref()' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingTrace::AllTypes;

# [[[ OPERATIONS ]]]
check_integer_arrayref( [ -999_999, 3, 4, -12.1 ] );

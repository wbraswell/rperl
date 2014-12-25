#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR EPVAVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: 'string__array_ref element value expected but non-string value found at index 3' >>>
# <<< RUN_ERROR: 'in variable $input_1 from subroutine check__string__array_ref()' >>>

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
check__string__array_ref( [ 'hello', 'howdy', 'ahoy', [ 0, 1, 2 ] ] );

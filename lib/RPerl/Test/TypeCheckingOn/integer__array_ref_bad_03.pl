#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR EIVAVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: 'integer__array_ref element value expected but non-integer value found at index 3' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingOn::AllTypes;

# [[[ OPERATIONS ]]]
check__integer__array_ref( [ -999_999, 3, 4, { a => 0, b => 1, c => 2 } ] );

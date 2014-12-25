#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR EAVRV01, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: 'array_ref value expected but non-array_ref value found' >>>
# <<< RUN_ERROR: 'in variable $input_1 from subroutine check__array_ref()' >>>

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
check__array_ref( { a => 0, b => 1, c => 2 } );

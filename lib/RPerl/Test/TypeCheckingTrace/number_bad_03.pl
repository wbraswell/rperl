#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR ENV01, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: 'number value expected but non-number value found' >>>
# <<< RUN_ERROR: 'in variable $input_1 from subroutine check__number()' >>>

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
check__number( { a => 0, b => 1, c => 2 } );

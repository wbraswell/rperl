#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR EIV01, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: 'integer value expected but non-integer value found' >>>
# <<< RUN_ERROR: 'in variable $input_1 from subroutine check__integer()' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingTrace::AllTypes;

# [[[ OPERATIONS ]]]
check__integer( { a => 0, b => 1, c => 2 } );

#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR EHVRV01, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: 'hash_ref value expected but non-hash_ref value found' >>>
# <<< RUN_ERROR: 'in variable $input_1 from subroutine check__hash_ref()' >>>

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
check__hash_ref(q{abcd});

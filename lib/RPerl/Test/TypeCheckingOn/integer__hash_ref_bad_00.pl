#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_ERROR: 'ERROR EIVHVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< RUN_ERROR: "integer__hash_ref element value expected but non-integer value found at key 'd'" >>>

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
check__integer__hash_ref( { a => -999_999, b => 3, c => 4, d => -12.1 } );

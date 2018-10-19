#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR EIV01, TYPE-CHECKING MISMATCH' >>>
# <<< EXECUTE_ERROR: 'integer value expected but non-integer value found' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::TypeCheckingOn::AllTypes;

# [[[ OPERATIONS ]]]
check_integer('abcd');

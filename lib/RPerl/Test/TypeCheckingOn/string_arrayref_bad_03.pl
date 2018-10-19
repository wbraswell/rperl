#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR EPVAVRV03, TYPE-CHECKING MISMATCH' >>>
# <<< EXECUTE_ERROR: 'string value expected but non-string value found at index 3' >>>

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
check_string_arrayref( [ 'hello', 'howdy', 'ahoy', { a => 0, b => 1, c => 2 } ] );

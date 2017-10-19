#!/usr/bin/perl

# NEED UPGRADE: we currently have no way to test for the presence of STDERR WARNING messages in otherwise-successful programs

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: "WARNING WCOPR01, PRE-PROCESSOR: Likely typo of '$RETURN_VALUE' instead of '$RETURN_TYPE' in subroutine empty_sub()" >>>
# <<< EXECUTE_SUCCESS: 'did not error!' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::SubroutineArguments::Package_10_Bad_01;

# [[[ OPERATIONS ]]]
RPerl::Test::SubroutineArguments::Package_10_Bad_01::empty_sub(23);
print 'did not error!', "\n";

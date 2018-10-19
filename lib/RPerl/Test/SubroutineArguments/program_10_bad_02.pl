#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'main::empty_sub' >>>
# <<< EXECUTE_ERROR_V5_10_V5_12: 'Use of inherited AUTOLOAD for non-method main::empty_sub() is deprecated' >>>  # DEV NOTE: Perl v5.10 & v5.12
# <<< EXECUTE_ERROR_V5_14_NEWER: 'Undefined subroutine &main::empty_sub' >>>  # DEV NOTE: Perl v5.14 and newer

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::SubroutineArguments::Package_10_Bad_02;

# [[[ OPERATIONS ]]]
empty_sub(23);

#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: "ERROR ESYXP03, Subroutine & Variable Exporter: Failed to export symbol '+exported' from package 'RPerl::Test::Exporter::Class_C_Exporter_20_Bad_00' into requesting package 'main', symbol begins with unrecognized character '+'" >>>

# DEV NOTE: medium magic grammar required to parse etc.
# <<< PARSE: OFF >>>
# <<< GENERATE: OFF >>>
# <<< COMPILE: OFF >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Class_C_Exporter_20_Bad_00;


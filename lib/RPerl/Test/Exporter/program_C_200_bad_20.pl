#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: "ERROR EVAXP02, Variable Exporter: Failed to export forced variable '$not_exported_scalar' from package 'RPerl::Test::Exporter::Class_C_Exporter_20_Bad_10' into requesting package 'main', variable does not exist" >>>

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
use RPerl::Test::Exporter::Class_C_Exporter_20_Bad_10;

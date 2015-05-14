#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: "$qui::bat = 'hal';  # string" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitPackageVars)  # SYSTEM SPECIAL 4e: allow testing scope_type_name_value()

# [[[ OPERATIONS ]]]

$Data::Dumper::Indent = 0;
$main::qui::bat = 'hal';
print scope_type_name_value($main::qui::bat) . "\n";

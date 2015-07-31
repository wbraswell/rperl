#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'our integer_hashref $properties = {'some_integer' => 23};' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::ScopeTypeNameValue::Class_00_Good;

# [[[ OPERATIONS ]]]

$Data::Dumper::Indent = 0;
print RPerl::Test::ScopeTypeNameValue::Class_00_Good::properties_stnv()
    . "\n";

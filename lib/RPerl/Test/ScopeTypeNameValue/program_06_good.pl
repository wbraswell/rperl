#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: "{'mixed_hashref_arrayref_arrayref' => [{'string_hashref_arrayref' => [{'string_hashref' => {'g' => 'string','h' => 'string'}}]},{'string_hashref_arrayref' => [{'string_hashref' => {'m' => 'string','n' => 'string'}}]},{'mixed_hashref_arrayref' => [{'mixed_hashref' => {'a' => 'string','b' => 'integer'}}]}]}" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitPackageVars)  # SYSTEM SPECIAL 4d: allow $rperlnamespaces::*

# [[[ OPERATIONS ]]]

$Data::Dumper::Indent = 0;
my unknown $u = [
    [ { g => q{11},  h => '2' } ],
    [ { m => '23.3', n => '1' } ],
    [ { a => '23',   b => 3 } ]
];
print Dumper( types($u) ) . "\n";

# START HERE: create more type() and types() tests
# START HERE: create more type() and types() tests
# START HERE: create more type() and types() tests
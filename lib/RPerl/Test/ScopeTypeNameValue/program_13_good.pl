#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "$VAR1 = {'string_hashref_arrayref' => [{'string_hashref' => {'g' => 'string','h' => 'string'}},{'string_hashref' => {'m' => 'string','n' => 'string'}},{'string_hashref' => {'a' => 'string','b' => 'string'}}]};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref_arrayref' => [{'string_hashref' => {'g' => 'string','h' => 'string'}},{'string_hashref' => {'m' => 'string','n' => 'string'}},{'hashref' => {'a' => 'string','b' => 'integer'}}]};" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

$Data::Dumper::Indent = 0;
my arrayref $u = [
    { g => q{11},  h => '2' },
    { m => '23.3', n => '1' },
    { a => '23',   b => '3' }
];
print Dumper( types($u) ) . "\n";

$u = [
    { g => q{11},  h => '2' },
    { m => '23.3', n => '1' },
    { a => '23',   b => 3 }
];
print Dumper( types($u) ) . "\n";

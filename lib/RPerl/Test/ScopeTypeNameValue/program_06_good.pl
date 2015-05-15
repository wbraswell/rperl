#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: "$VAR1 = {'integer_hashref' => {'a' => 'integer'}};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'integer_hashref' => {'a' => 'integer','b' => 'integer'}};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'hashref' => {'a' => 'integer','b' => 'number'}};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'integer_hashref' => {'a' => 'integer','b' => 'integer','c' => 'integer','d' => 'integer','e' => 'integer'}};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'hashref' => {'a' => 'integer','b' => 'integer','c' => 'integer','d' => 'number','e' => 'integer'}};" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

$Data::Dumper::Indent = 0;
my hashref $u = { a => 2 };
print Dumper( types($u) ) . "\n";
$u = { a => 2, b => 3 };
print Dumper( types($u) ) . "\n";
$u = { a => 2, b => 3.3 };
print Dumper( types($u) ) . "\n";
$u = { a => 2, b => 3, c => 5, d => 7, e => 9 };
print Dumper( types($u) ) . "\n";
$u = { a => 2, b => 3, c => 5, d => 7.7, e => 9 };
print Dumper( types($u) ) . "\n";

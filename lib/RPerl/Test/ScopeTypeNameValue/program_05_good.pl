#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {'a' => 'unknown'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {'a' => 'unknown','b' => 'unknown'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {'a' => 'unknown','b' => 'integer'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {'a' => 'unknown','b' => 'unknown','c' => 'unknown','d' => 'unknown','e' => 'unknown'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {'a' => 'unknown','b' => 'unknown','c' => 'unknown','d' => 'integer','e' => 'unknown'}};" >>>

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
my hashref $u = {};
print Dumper( types($u) ) . "\n";
$u = { a => undef };
print Dumper( types($u) ) . "\n";
$u = { a => undef, b => undef };
print Dumper( types($u) ) . "\n";
$u = { a => undef, b => 1 };
print Dumper( types($u) ) . "\n";
$u = { a => undef, b => undef, c => undef, d => undef, e => undef };
print Dumper( types($u) ) . "\n";
$u = { a => undef, b => undef, c => undef, d => 1, e => undef };
print Dumper( types($u) ) . "\n";

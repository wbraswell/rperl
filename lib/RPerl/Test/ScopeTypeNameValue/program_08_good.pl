#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "$VAR1 = {'string_hashref' => {'a' => 'string'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'string_hashref' => {'a' => 'string','b' => 'string'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {'a' => 'string','b' => 'integer'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'string_hashref' => {'a' => 'string','b' => 'string','c' => 'string','d' => 'string','e' => 'string'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {'a' => 'string','b' => 'string','c' => 'string','d' => 'integer','e' => 'string'}};" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

$Data::Dumper::Indent = 0;
my hashref $u = { a => '2' };
print Dumper( types($u) ) . "\n";
$u = { a => '2', b => '3' };
print Dumper( types($u) ) . "\n";
$u = { a => '2', b => 3 };
print Dumper( types($u) ) . "\n";
$u = { a => '2', b => '3', c => '5', d => '7', e => '9' };
print Dumper( types($u) ) . "\n";
$u = { a => '2', b => '3', c => '5', d => 7, e => '9' };
print Dumper( types($u) ) . "\n";

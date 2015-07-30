#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "$VAR1 = {'number_hashref' => {'a' => 'number'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'number_hashref' => {'a' => 'number','b' => 'number'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {'a' => 'number','b' => 'integer'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'number_hashref' => {'a' => 'number','b' => 'number','c' => 'number','d' => 'number','e' => 'number'}};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'hashref' => {'a' => 'number','b' => 'number','c' => 'number','d' => 'integer','e' => 'number'}};" >>>

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
my hashref $u = { a => 2.2 };
print Dumper( types($u) ) . "\n";
$u = { a => 2.2, b => 3.2 };
print Dumper( types($u) ) . "\n";
$u = { a => 2.2, b => 3 };
print Dumper( types($u) ) . "\n";
$u = { a => 2.2, b => 3.3, c => 5.5, d => 7.7, e => 9.9 };
print Dumper( types($u) ) . "\n";
$u = { a => 2.2, b => 3.3, c => 5.5, d => 7, e => 9.9 };
print Dumper( types($u) ) . "\n";

#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: "$VAR1 = {'integer_arrayref' => ['integer']};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'integer_arrayref' => ['integer','integer']};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'arrayref' => ['integer','number']};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'integer_arrayref' => ['integer','integer','integer','integer','integer']};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'arrayref' => ['integer','integer','integer','number','integer']};" >>>

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
my arrayref $u = [2];
print Dumper( types($u) ) . "\n";
$u = [ 2, 3 ];
print Dumper( types($u) ) . "\n";
$u = [ 2, 3.3 ];
print Dumper( types($u) ) . "\n";
$u = [ 2, 3, 5, 7, 9 ];
print Dumper( types($u) ) . "\n";
$u = [ 2, 3, 5, 7.7, 9 ];
print Dumper( types($u) ) . "\n";

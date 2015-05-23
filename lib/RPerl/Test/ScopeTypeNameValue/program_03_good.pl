#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "$VAR1 = {'string_arrayref' => ['string']};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'string_arrayref' => ['string','string']};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'arrayref' => ['string','integer']};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'string_arrayref' => ['string','string','string','string','string']};" >>>
# <<< EXECUTE_SUCCESS: "$VAR1 = {'arrayref' => ['string','string','string','integer','string']};" >>>

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
my arrayref $u = ['2'];
print Dumper( types($u) ) . "\n";
$u = [ '2', '3' ];
print Dumper( types($u) ) . "\n";
$u = [ '2', 3 ];
print Dumper( types($u) ) . "\n";
$u = [ '2', '3', '5', '7', '9' ];
print Dumper( types($u) ) . "\n";
$u = [ '2', '3', '5', 7, '9' ];
print Dumper( types($u) ) . "\n";

#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: "$VAR1 = {'string_arrayref_hashref' => {'a' => {'string_arrayref' => ['string','string']},'b' => {'string_arrayref' => ['string','string']},'c' => {'string_arrayref' => ['string','string']}}};" >>>
# <<< RUN_SUCCESS: "$VAR1 = {'arrayref_hashref' => {'a' => {'string_arrayref' => ['string','string']},'b' => {'string_arrayref' => ['string','string']},'c' => {'arrayref' => ['string','integer']}}};" >>>

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
my hashref $u
    = { a => [ q{11}, '2' ], b => [ '23.3', '1' ], c => [ '23', '3' ] };
print Dumper( types($u) ) . "\n";

$u = { a => [ q{11}, '2' ], b => [ '23.3', '1' ], c => [ '23', 3 ] };
print Dumper( types($u) ) . "\n";

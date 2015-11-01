#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  m' >>>

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
my hashref $u = { z => { g => q{11}, h => '2' }, yy => { m => '23.3', n => '1' }, x => { a => '23', b => '3' } };
print Dumper( types($u) ) . "\n";

$u = { z => { g => q{11}, h => '2' }, yy => { m => '23.3', n => '1' }, x => { a => '23', b => 3 } };
print Dumper( types($u) ) . "\n";

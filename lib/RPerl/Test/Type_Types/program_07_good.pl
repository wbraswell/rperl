#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: "$VAR1 = {'a' => '42','b' => 'is','c' => 'the','d' => 'answer'}; string_hashref" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my hashref $foo   = {};
my string $my_key = 'any old thing';
my integer_hashref $bar
    = { zero => 0, one => 1, two => 2, "three\nhowdy" => 3, $my_key => 12 };
$foo = { a => '42', b => 'is', c => 'the', d => 'answer' };

$Data::Dumper::Indent = 0;
print Dumper($foo) . q{ } . type($foo) . "\n";

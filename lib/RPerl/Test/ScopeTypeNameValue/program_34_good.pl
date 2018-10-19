#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "my integer_hashref $bar = {'any old thing' => 12,'one' => 1,'three" >>>
# <<< EXECUTE_SUCCESS: "howdy' => 3,'two' => 2,'zero' => 0};" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string $my_key = 'any old thing';
my integer_hashref $bar
    = { zero => 0, one => 1, two => 2, "three\nhowdy" => 3, $my_key => 12 };

$Data::Dumper::Indent = 0;
print scope_type_name_value($bar) . "\n";

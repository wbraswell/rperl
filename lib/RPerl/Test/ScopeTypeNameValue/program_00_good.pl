#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: 'my undefined $foo = undef;' >>>
# <<< RUN_SUCCESS: 'my integer $bar = 23_456;' >>>
# <<< RUN_SUCCESS: 'my number $bat = 9_123.456_789;' >>>
# <<< RUN_SUCCESS: "my string $baz = 'howdy';" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my unknown $foo = undef;
my integer $bar = 23_456;
my number $bat  = 9_123.456_789;
my string $baz  = 'howdy';

print scope_type_name_value($foo) . "\n";
print scope_type_name_value($bar) . "\n";
print scope_type_name_value($bat) . "\n";
print scope_type_name_value($baz) . "\n";
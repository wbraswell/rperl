#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'my unknown $foo = undef;' >>>
# <<< EXECUTE_SUCCESS: 'my integer $bar = -23_456;' >>>
# <<< EXECUTE_SUCCESS: 'my number $bat = 9_123.456_789;' >>>
# <<< EXECUTE_SUCCESS: "my string $baz = 'howdy';" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my unknown $foo = undef;
my integer $bar = -23_456;
my number $bat  = 9_123.456_789;
my string $baz  = 'howdy';

print scope_type_name_value($foo) . "\n";
print scope_type_name_value($bar) . "\n";
print scope_type_name_value($bat) . "\n";
print scope_type_name_value($baz) . "\n";


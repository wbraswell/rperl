#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'my unknown $foo = undef;' >>>
# <<< EXECUTE_SUCCESS: 'my integer $foo = 23_456;' >>>
# <<< EXECUTE_SUCCESS: 'my number $foo = -9_123.456_789;' >>>
# <<< EXECUTE_SUCCESS: "my string $foo = 'howdy';" >>>
# <<< EXECUTE_SUCCESS: 'my unknown $foo = undef;' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my scalartype $foo = undef;
print scope_type_name_value($foo) . "\n";
$foo = 23_456;
print scope_type_name_value($foo) . "\n";
$foo = -9_123.456_789;
print scope_type_name_value($foo) . "\n";
$foo = 'howdy';
print scope_type_name_value($foo) . "\n";
$foo = undef;
print scope_type_name_value($foo) . "\n";


#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: 'my unknown $foo = undef;' >>>
# <<< RUN_SUCCESS: 'my integer $bar = 234_567_889;' >>>
# <<< RUN_SUCCESS: 'my number $bat = -1_234_567_889.012_35;' >>>
# <<< RUN_SUCCESS: 'my string $baz = 'silly string';' >>>

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

my unknown $foo = undef;
my integer $bar = 234_567_889;
my number $bat  = -1_234_567_889.012_345_6;
my string $baz  = 'silly string';

print scope_type_name_value($foo) . "\n";
print scope_type_name_value($bar) . "\n";
print scope_type_name_value($bat) . "\n";
print scope_type_name_value($baz) . "\n";

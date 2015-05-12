#!/usr/bin/perl

# START HERE: continue updating Type_Types/* to print on different lines, finish Type_Types/*; continue code generating for subroutines
# START HERE: continue updating Type_Types/* to print on different lines, finish Type_Types/*; continue code generating for subroutines
# START HERE: continue updating Type_Types/* to print on different lines, finish Type_Types/*; continue code generating for subroutines

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: 'undef' >>>
# <<< RUN_SUCCESS: 'integer' >>>
# <<< RUN_SUCCESS: 'number' >>>
# <<< RUN_SUCCESS: 'string' >>>

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
my integer $bar = 23;
my number $bat  = 9_123.456_789;
my string $baz  = 'howdy';

print type($foo) . "\n";
print type($bar) . "\n";
print type($bat) . "\n";
print type($baz) . "\n";

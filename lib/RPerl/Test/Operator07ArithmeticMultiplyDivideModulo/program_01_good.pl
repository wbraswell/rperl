#!/usr/bin/env perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my number  $bar = 17.0;
my number  $bat = 2_112.42;
my integer $baz = 23;
my number  $foo;

print {*STDERR} 'before arithmetic, have $bar = ', number_to_string($bar), "\n";
print {*STDERR} 'before arithmetic, have $bat = ', number_to_string($bat), "\n";
print {*STDERR} 'before arithmetic, have $baz = ', integer_to_string($baz), "\n";

$bat = $bar;
$bar = $baz / ($bar * 3);
$baz = $baz + 1;
$foo = $bar + $bat;

print '$foo = ', number_to_string($foo), "\n";

print {*STDERR} 'after arithmetic, have $bar = ', number_to_string($bar), "\n";
print {*STDERR} 'after arithmetic, have $bat = ', number_to_string($bat), "\n";
print {*STDERR} 'after arithmetic, have $baz = ', integer_to_string($baz), "\n";

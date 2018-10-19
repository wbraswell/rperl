#!/usr/bin/env perl

use RPerl;
use strict;
use warnings;
our $VERSION = 0.002_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

my number_hashref $retvals = [POSIX::modf(-3.141_59)];
my number $fraction_part = $retvals->[0];
my number $integer_part = $retvals->[1];

print 'have $retvals = ' . Dumper($retvals) . "\n";
print 'have $integer_part = ' . $integer_part . "\n";
print 'have $fraction_part = ' . $fraction_part . "\n";

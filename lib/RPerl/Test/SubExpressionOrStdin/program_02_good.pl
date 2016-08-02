#!/usr/bin/perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ OPERATIONS ]]]

print 'Please input your age in years: ';
my string $age_string = <STDIN>;
my integer $age       = string_to_integer($age_string);
print 'You are ', integer_to_string($age), ' years old.', "\n";
print 'In one year from now, you will be ', integer_to_string( $age + 1 ), ' years old.', "\n";

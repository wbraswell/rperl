#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'Bareword "a" not allowed' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string $foo = 'foo' x a;
my string $bar = 'bar' x 1;
my string $bat = 'bat' x 2;
my string $baz = 'baz' x 4;
my string $bax = 'bax' x 8;

print q{have $foo = '}, $foo, q{'}, "\n";
print q{have $bar = '}, $bar, q{'}, "\n";
print q{have $bat = '}, $bat, q{'}, "\n";
print q{have $baz = '}, $baz, q{'}, "\n";
print q{have $bax = '}, $bax, q{'}, "\n";
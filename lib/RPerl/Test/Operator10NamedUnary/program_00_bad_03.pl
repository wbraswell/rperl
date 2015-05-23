#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'Bareword "ran" not allowed' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# FEATURE BOUNTY #000, 1_000 CodeCoin: Implement all Perl functions AKA builtins (PERLOPS_PERLTYPES) as C++ functions (CPPOPS_PERLTYPES & CPPOPS_CPPTYPES)

# [[[ OPERATIONS ]]]

my integer $foo = chdir;
my integer $bar = chdir 'INVALID__DIRECTORY__NAME';
my number $bat  = rand;
my number $baz  = rand 10;
my number $bax  = ran;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

my integer_arrayref $quux = [ 5, 6, 7, 8 ];
$foo = scalar @{$quux};
$bar = scalar @{ [] };
$bat = scalar @{ [0] };
$baz = scalar @{ [ 0, 1, 2, 3, 4, 5, 6, 7 ] };
$bax = scalar @{ [ 0 .. 22 ] };

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

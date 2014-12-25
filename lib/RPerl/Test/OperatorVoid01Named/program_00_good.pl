#!/usr/bin/perl
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
my number $op_sin = sin 2;
my number $op_cos = cos 2;

my integer__array_ref $frob = [];
push @{$frob}, 21, 12, 23;    # OperatorVoid, no parentheses required for builtin w/ multiple arguments in void context
print 'have $frob = ', "\n", Dumper($frob), "\n";

pop @{$frob};
print 'have $frob = ', "\n", Dumper($frob), "\n";


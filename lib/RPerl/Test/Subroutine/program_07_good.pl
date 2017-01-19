#!/usr/bin/perl

# Learning RPerl, Section 4.4: Subroutine Arguments

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'inside foo_arg(), have $arg1 = 1_701' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
our void $foo_arg  = sub {
    (my integer $arg1) = @ARG;
    print 'inside foo_arg(), have $arg1 = ', integer_to_string($arg1), "\n";
};

# [[[ OPERATIONS ]]]
foo_arg(1_701);

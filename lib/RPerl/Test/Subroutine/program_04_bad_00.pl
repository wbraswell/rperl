#!/usr/bin/perl

# Learning RPerl, Section 4.3.1: C<return> Operator

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECOCOSU04' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
our integer $unpredictable = sub {
    return 'howdy' . 'doody';
};

# [[[ OPERATIONS ]]]
print 'have unpredictable() = ', unpredictable(), "\n";

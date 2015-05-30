#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< GENERATOR_ERROR: 'ERROR ECVGEASRP03' >>>
# <<< GENERATOR_ERROR: 'Attempt to return dereferenced array' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]
our integer_arrayref $foo = sub { return((@{[2]})); };
foo();
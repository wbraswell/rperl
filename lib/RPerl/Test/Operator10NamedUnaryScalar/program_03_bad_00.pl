#!/usr/bin/perl

# Learning RPerl, Section 3.16: Scalar & Array Contexts

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECOGEASCP13' >>>
# <<< COMPILE_ERROR: 'Array dereference of array reference must provide data type for array reference' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]
my integer $i =                   3;  # scalar variable receiving scalar value, context    match, fine in Perl, fine  in RPerl
my integer $j = scalar @{[2, 4, 6]};  # scalar variable receiving scalar value, context    match, fine in Perl, fine  in RPerl
my integer $k =        @{[2, 4, 6]};  # scalar variable receiving array  value, context mismatch, fine in Perl, error in RPerl compiled modes
print 'have $i = ', $i, "\n";
print 'have $j = ', $j, "\n";
print 'have $k = ', $k, "\n";

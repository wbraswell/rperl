#!/usr/bin/perl

# Learning RPerl, Section 4.3.2: Multiple Return Values

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  foo_multi' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
sub foo_multi { return 21, 22, 23; }

# [[[ OPERATIONS ]]]
(my $retval0, my $retval1, my $retval2) = foo_multi();
print 'have $retval0 = ', $retval0, "\n";
print 'have $retval1 = ', $retval1, "\n";
print 'have $retval2 = ', $retval2, "\n";



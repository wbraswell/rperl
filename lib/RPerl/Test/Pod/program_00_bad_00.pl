#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR_PERL_5_22_AND_NEWER: 'syntax error' >>>  # DEV NOTE: disabled this part of the error message which is only generated in Perl v5.22 and newer

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

print 'Mark 0', "\n";

=_pod
HOWDY
!@#$%^
this is pod!
=cut

print 'Mark 1', "\n";

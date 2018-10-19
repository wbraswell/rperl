#!/usr/bin/env perl

# Learning RPerl, Section 4.3.1: C<return> Operator

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Useless use of a constant' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
sub jedi { { my integer $RETURN_TYPE }; print q{"You love him, don't you?"}, "\n"; 6; return; }

# [[[ OPERATIONS ]]]

my integer $episode = jedi();
print 'Return (value) of the Jedi, Episode ', $episode, "\n";


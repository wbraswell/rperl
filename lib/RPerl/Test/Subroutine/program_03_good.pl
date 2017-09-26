#!/usr/bin/perl

# Learning RPerl, Section 4.3: Subroutine Return Values

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "You love him, don't you?" >>>
# <<< EXECUTE_SUCCESS: 'Return (value) of the Jedi, Episode 6' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
sub jedi { { my integer $RETURN_TYPE }; print q{"You love him, don't you?"}, "\n"; return 6; }

# [[[ OPERATIONS ]]]
my integer $episode = jedi();
print 'Return (value) of the Jedi, Episode ', $episode, "\n";

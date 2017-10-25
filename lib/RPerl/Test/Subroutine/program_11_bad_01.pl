#!/usr/bin/perl

# Learning RPerl, Section 4.5: Subroutine Variables, Variable Scope & Persistence

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: "ERROR ECOPARP00" >>>
# <<< PARSE_ERROR: "Unexpected Token:  'state'" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

use feature 'state';  ## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUBROUTINES ]]]
#print 'before defining quux(), have $local_persistent = ', $local_persistent, "\n";  # YES ERROR
sub quux {
    { my void $RETURN_TYPE };
    state integer $local_persistent = 23;
    print 'inside quux(), have $local_persistent = ', $local_persistent, "\n";        # NO  ERROR
    $local_persistent++;
    return;
}
#print 'after  defining quux(), have $local_persistent = ', $local_persistent, "\n";  # YES ERROR

# [[[ OPERATIONS ]]]
quux();
#print 'after   calling quux(), have $local_persistent = ', $local_persistent, "\n";  # YES ERROR
quux();
#print 'after   calling quux(), have $local_persistent = ', $local_persistent, "\n";  # YES ERROR


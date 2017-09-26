#!/usr/bin/perl

# Learning RPerl, Section 4.5: Subroutine Variables, Variable Scope & Persistence

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  =' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
our integer $global_persistent = 23;
print 'before defining quux(), have $global_persistent = ', $global_persistent, "\n";  # NO ERROR
sub quux {
    { my void $RETURN_TYPE };
    print 'inside          quux(), have $global_persistent = ', $global_persistent, "\n";       # NO ERROR
    $global_persistent++;
    return;
}
print 'after  defining quux(), have $global_persistent = ', $global_persistent, "\n";  # NO ERROR

# [[[ OPERATIONS ]]]
quux();
print 'after   calling quux(), have $global_persistent = ', $global_persistent, "\n";  # NO ERROR
quux();
print 'after   calling quux(), have $global_persistent = ', $global_persistent, "\n";  # NO ERROR

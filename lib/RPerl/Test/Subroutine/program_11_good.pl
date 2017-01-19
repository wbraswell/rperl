#!/usr/bin/perl

# Learning RPerl, Section 4.5: Subroutine Variables, Variable Scope & Persistence

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'inside quux(), have $local_intermittent = 23' >>>
# <<< EXECUTE_SUCCESS: 'inside quux(), have $local_intermittent = 23' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
#print 'before defining quux(), have $local_intermittent = ', $local_intermittent, "\n";  # YES ERROR
our void $quux = sub {
    my integer $local_intermittent = 23;
    print 'inside quux(), have $local_intermittent = ', $local_intermittent, "\n";        # NO  ERROR
    $local_intermittent++;
};
#print 'after  defining quux(), have $local_intermittent = ', $local_intermittent, "\n";  # YES ERROR

# [[[ OPERATIONS ]]]
quux();
#print 'after   calling quux(), have $local_intermittent = ', $local_intermittent, "\n";  # YES ERROR
quux();
#print 'after   calling quux(), have $local_intermittent = ', $local_intermittent, "\n";  # YES ERROR

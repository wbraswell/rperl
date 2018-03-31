#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: 'P06, CODE GENERATOR, ABSTRACT SYNTAX TO' >>>
# <<< GENERATE_ERROR: "initial-condition variable '$i' is different than exit-condition variable '$j'" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitCStyleForLoops)  # USER DEFAULT 6: allow C-style for() loop headers

# [[[ OPERATIONS ]]]

my integer $j = 5;
for ( my integer $i = 0; $j < 5; $i++ ) {
    print 'Production rule Loop matched by C-Style LoopFor, iteration number ', $i, "\n";
}

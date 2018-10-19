#!/usr/bin/env perl

use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# ERROR ECOPARP00, Unexpected Token:  {
#print q{\ } . "\n";
print q{\\n} . "\n";
#print q{\\\ } . "\n";
print q{\\\\n} . "\n";
#print q{\\\\\ } . "\n";
print q{\\\\\\n} . "\n";
#print q{\\\\\\\ } . "\n";
print q{\\\\\\\\n} . "\n";

#print '\n' . "\n";
print '\\n' . "\n";
#print '\\\n' . "\n";
print '\\\\n' . "\n";
#print '\\\\\n' . "\n";
print '\\\\\\n' . "\n";
#print '\\\\\\\n' . "\n";
print '\\\\\\\\n' . "\n";

# ERROR ECOPAPC02, ProhibitInterpolationOfLiterals
#print "\\n" . "\n";
#print "\\\\n" . "\n";
#print "\\\\\\n" . "\n";
#print "\\\\\\\\n" . "\n";


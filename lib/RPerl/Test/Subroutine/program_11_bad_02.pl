#!/usr/bin/perl

# Learning RPerl, Section 4.5: Subroutine Variables, Variable Scope & Persistence

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Global symbol "$autovivified" requires explicit package name (did you forget to declare "my $autovivified"?)' >>>

# [[[ HEADER ]]]
use RPerl;
#use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
print 'before defining quux(), have $autovivified = ', $autovivified, "\n";  # NO ERROR
our void $quux = sub {
    $autovivified = 23;
    print 'inside quux(), have $autovivified = ', $autovivified, "\n";       # NO ERROR
    $autovivified++;
};
print 'after  defining quux(), have $autovivified = ', $autovivified, "\n";  # NO ERROR

# [[[ OPERATIONS ]]]
quux();
print 'after   calling quux(), have $autovivified = ', $autovivified, "\n";  # NO ERROR
quux();
print 'after   calling quux(), have $autovivified = ', $autovivified, "\n";  # NO ERROR

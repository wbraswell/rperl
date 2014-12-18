#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ OPERATIONS ]]]
# NEED FIX: add all builtins
#my number $op_sin = sin 2;
#my number $op_cos = cos 2;

#open {*STDOUT}, '>', '/tmp/howdy' or croak();
#print {*STDOUT} 2;
#close {*STDOUT} or croak();

#open my filehandle_ref $HOWDY, '>', '/tmp/howdy' or croak();
#print {$HOWDY} 2;
#close $HOWDY or croak();

#my integer $bar = 3;
#my integer $foo = 5 - -4;
#my integer $fun = 5 - -$bar;
#my integer $bun = 5 - -($bar);

my integer__array_ref $frob = [];
my integer $quux = ( push @{$frob}, 21, 12, 23 );
#my integer $quux = push @{$frob}, 21, 12, 23 ;

print 'have quux = ', $quux, "\n";


# START HERE: create operator tests
# START HERE: create operator tests
# START HERE: create operator tests
#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ OPERATIONS ]]]

my integer $bar = 3;
my integer $foo = 5 - -4;
my integer $fun = 5 - -$bar;
my integer $bun = 5 - -($bar);

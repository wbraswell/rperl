#!/usr/bin/env perl

use RPerl;
use strict;
use warnings;
our $VERSION = 0.003_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

#my integer $foo = POSIX::ceil 2.5;  # RPERL ERROR: missing parentheses
#my integer $foo = POSIX::ceil(2.5);  # NO ERROR

#my integer $foo = int 2.5;  # NO ERROR
my integer $foo = int(2.5);  # CRITIC ERROR: incorrect parentheses

print $foo . "\n";

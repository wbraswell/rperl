#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ OPERATIONS ]]]

open {*STDOUT}, '>', '/tmp/howdy' or croak();
print {*STDOUT} 2;
close {*STDOUT} or croak();

open my filehandle_ref $HOWDY, '>', '/tmp/howdy' or croak();
print {$HOWDY} 2;
close $HOWDY or croak();

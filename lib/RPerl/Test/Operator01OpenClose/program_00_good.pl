#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ OPERATIONS ]]]

#open {*STDOUT}, '>', '/tmp/howdy' or croak 'ERROR: Failed to open file /tmp/howdy for writing, croaking';
#print {*STDOUT} 2;
#close {*STDOUT} or croak();  # BAD

#open my filehandle_ref $HOWDY, '>', '/tmp/howdy' or croak 'ERROR: Failed to open file /tmp/howdy for writing, croaking';  # BAD
my integer $open_success = open my filehandle_ref $HOWDY, '>', '/tmp/howdy';
if ( not $open_success ) {
    croak 'ERROR: Failed to open file /tmp/howdy for writing, croaking';
}

print {$HOWDY} 2;

#close $HOWDY or croak 'ERROR: Failed to close file /tmp/howdy after writing, croaking';  # BAD
if (not close $HOWDY) { croak 'ERROR: Failed to close file /tmp/howdy after writing, croaking'; }

# START HERE: continue operator tests
# START HERE: continue operator tests
# START HERE: continue operator tests
#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ OPERATIONS ]]]

my integer $open_success = open my filehandle_ref $HOWDY, '>', '/tmp/howdy';
if ( not $open_success ) {
    croak 'ERROR: Failed to open file /tmp/howdy for writing, croaking';
}

( print {$HOWDY} 2, 3, 4 );  # Operator
print {$HOWDY} 2, 3, 4;  # OperatorVoid

my integer $print_success = ( print {$HOWDY} 2, 3, 4 );  # Operator
if ( not $print_success ) {
    croak 'ERROR: Failed to write to file /tmp/howdy, croaking';
}

if ( not close $HOWDY ) {
    croak 'ERROR: Failed to close file /tmp/howdy after writing, croaking';
}

# START HERE: continue Print tests
# START HERE: continue Print tests
# START HERE: continue Print tests
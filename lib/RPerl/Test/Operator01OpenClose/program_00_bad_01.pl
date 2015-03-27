#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected Token:  croak' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ OPERATIONS ]]]

my integer $open_success = open my filehandle_ref $HOWDY, '>', '/tmp/howdy';
if ( not $open_success ) {
    croak 'ERROR: Failed to open file /tmp/howdy for writing, croaking';
}

my integer $print_success = ( print {$HOWDY} 23, 32, 42 );
if ( not $print_success ) {
    croak 'ERROR: Failed to write to file /tmp/howdy, croaking';
}

close $HOWDY
    or croak
    'ERROR: Failed to close file /tmp/howdy after writing, croaking';

#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  $hOWDY' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ OPERATIONS ]]]

my integer $open_success = open my filehandleref $hOWDY, '>', '/tmp/howdy';
if ( not $open_success ) {
    croak 'ERROR: Failed to open file /tmp/howdy for writing, croaking';
}

my integer $print_success = ( print {$hOWDY} 23, 32, 42 );
if ( not $print_success ) {
    croak 'ERROR: Failed to write to file /tmp/howdy, croaking';
}

if ( not close $hOWDY ) {
    croak 'ERROR: Failed to close file /tmp/howdy after writing, croaking';
}

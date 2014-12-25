#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'near ")' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ OPERATIONS ]]]

# USER NOTE: the Operator (not OperatorVoid) production rule matched by 'print' requires parentheses and filehandle

my integer $open_success = open my filehandle_ref $HOWDY, '>', '/tmp/howdy';
if ( not $open_success ) {
    croak 'ERROR: Failed to open file /tmp/howdy for writing, croaking';
}

# USER NOTE: return values of Operator print are purposefully ignored here, possibly ignoring write errors
( print {$HOWDY} 2 )
( print {$HOWDY} 2, 3, 4, "\n" );
( print {$HOWDY} 2.31 );
( print {$HOWDY} 2.31, 3.21, 4.23, "\n" );
( print {$HOWDY} 'howdy' );
( print {$HOWDY} 'howdy', 'doody', 'foobar', "\n" );
( print {$HOWDY} 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n" );

# USER NOTE: return values of Operator print are utilized here, catching write errors
# long format, 2 RPerl Operations
my integer $print_success = ( print {$HOWDY} 2 );
if ( not $print_success ) {
    croak 'ERROR: Failed to write to file /tmp/howdy, croaking';
}

# short format, 1 RPerl Operation
if (not( print {$HOWDY} 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n" ) )
{
    croak 'ERROR: Failed to write to file /tmp/howdy, croaking';
}

if ( not close $HOWDY ) {
    croak 'ERROR: Failed to close file /tmp/howdy after writing, croaking';
}

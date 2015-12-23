#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL03' >>>
# <<< PARSE_ERROR: 'Name "main::sTDERR" used only once: possible typo' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ OPERATIONS ]]]

# USER NOTE: the OperatorVoid (not Operator) production rule matched by 'print' has optional STDOUT, STDERR, or filehandle

print 2;
print 2, 3, 4, "\n";
print 2.31;
print 2.31, 3.21, 4.23, "\n";
print 'howdy';
print 'howdy', 'doody', 'foobar', "\n";
print 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n";

print {*STDOUT} 2;
print {*STDOUT} 2, 3, 4, "\n";
print {*STDOUT} 2.31;
print {*STDOUT} 2.31, 3.21, 4.23, "\n";
print {*STDOUT} 'howdy';
print {*STDOUT} 'howdy', 'doody', 'foobar', "\n";
print {*STDOUT} 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n";

print {*STDERR} 2;
print {*STDERR} 2, 3, 4, "\n";
print {*sTDERR} 2.31;
print {*STDERR} 2.31, 3.21, 4.23, "\n";
print {*STDERR} 'howdy';
print {*STDERR} 'howdy', 'doody', 'foobar', "\n";
print {*STDERR} 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n";

my integer $open_success = open my filehandleref $HOWDY, '>', '/tmp/howdy';
if ( not $open_success ) {
    croak 'ERROR: Failed to open file /tmp/howdy for writing, croaking';
}

# USER NOTE: return values of OperatorVoid print-to-filehandle are always ignored, possibly ignoring write errors
print {$HOWDY} 2;
print {$HOWDY} 2, 3, 4, "\n";
print {$HOWDY} 2.31;
print {$HOWDY} 2.31, 3.21, 4.23, "\n";
print {$HOWDY} 'howdy';
print {$HOWDY} 'howdy', 'doody', 'foobar', "\n";
print {$HOWDY} 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n";

if ( not close $HOWDY ) {
    croak 'ERROR: Failed to close file /tmp/howdy after writing, croaking';
}

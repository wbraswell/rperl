#!/usr/bin/perl

# Learning RPerl, Chapter 5, Exercise 1
# Accept one or more input files, and print their contents line-by-line in reverse order

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]

our string_arrayref $tac = sub {
    ( my string_arrayref $ARGV ) = @_;
    $ARGV = [ reverse @{$ARGV} ];
    foreach my string $file_name ( @{$ARGV} ) {
        if ( not( -e $file_name ) ) {
            croak 'ERROR: File ' . $file_name . ' does not exist, croaking';
        }
        if ( not( -r $file_name ) ) {
            croak 'ERROR: File ' . $file_name . ' is not readable, croaking';
        }
        if ( not( -f $file_name ) ) {
            croak 'ERROR: File ' . $file_name . ' is not a regular file, croaking';
        }
        if ( not( -T $file_name ) ) {
            croak 'ERROR: File ' . $file_name . ' is (probably) not text, croaking';
        }

        my integer $open_success = open my filehandleref $FILE, '<', $file_name;
        if ( not $open_success ) {
            croak 'ERROR: Failed to open file ' . $file_name . ' for reading, croaking';
        }

        my string_arrayref $file_lines = [];

        # START HERE: read input lines, reverse, print
        # START HERE: read input lines, reverse, print
        # START HERE: read input lines, reverse, print

        if ( not close $FILE ) {
            croak 'ERROR: Failed to close file ' . $file_name . ' after reading, croaking';
        }
    }
};

# [[[ OPERATIONS ]]]

tac( \@ARGV );

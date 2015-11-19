#!/usr/bin/perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]

our void $pod2html_reformat = sub {
    ( my string_arrayref $command_line_arguments ) = @_;
    foreach my string $file_name ( @{$command_line_arguments} ) {
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

        while ( my string $file_line = <$FILE> ) {
            # enable HTML newline <br>
            $file_line =~ s/&lt;br&gt;/<br>/gxms;

            # enable HTML underline <u>...</u>
            $file_line =~ s/&lt;u&gt;/<u>/gxms;
            $file_line =~ s/&lt;\/u&gt;/<\/u>/gxms;
 
            # strip extra newline between list items
            $file_line =~ s/<li><p>(.*)<\/p>/<li>$1/gxms;

            push @{$file_lines}, $file_line;
        }

        foreach my string $file_line ( @{$file_lines} ) {
            print $file_line;
        }

        if ( not close $FILE ) {
            croak 'ERROR: Failed to close file ' . $file_name . ' after reading, croaking';
        }
    }
};

# [[[ OPERATIONS ]]]

pod2html_reformat( [@ARGV] );


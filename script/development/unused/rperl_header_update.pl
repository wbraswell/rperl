#!/usr/bin/env perl

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use File::Find qw(find);

# [[[ OPERATIONS ]]]

find(
    sub {
        my $file = $File::Find::name;

#        RPerl::diag( 'in rperl_header_update.pl, have $file = ' . $file . "\n" );

        if ( ( $file !~ m/.pm$/xms ) and ( $file !~ m/.pl$/xms ) ) {
#            RPerl::diag( 'in rperl_header_update.pl, SKIPPING $file = ' . $file . "\n" );
            return;
        }

        # read file
        my string $input_lines = q{};
        open my filehandleref $FILE_HANDLE, '<', $file or croak 'ERROR, Cannot open file ' . $file . ' for reading,' . $OS_ERROR . ', croaking';
        while ( my $input_line = <$FILE_HANDLE> ) {
            $input_lines .= $input_line;
        }
        close $FILE_HANDLE or croak 'ERROR, Cannot close file ' . $file . ' after reading,' . $OS_ERROR . ', croaking';

#        RPerl::diag( 'in rperl_header_update.pl, have PRE-MODIFICATION $input_lines = ' . "\n" . '<<<<<<<<<<<<<<<<================ BEGIN INPUT FILE ================>>>>>>>>>>>>>>' . "\n" . $input_lines . '<<<<<<<<<<<<<<<<================ END INPUT FILE ================>>>>>>>>>>>>>>' . "\n\n" );

        # make whole-file changes
        if ( $file =~ m/.pm$/xms ) {
            $input_lines =~ s/(package .+;)/use RPerl;\n$1/xms;
            $input_lines =~ s/(use\s+warnings;)\nuse\s+RPerl::AfterSubclass;/$1/xms;
        }
        elsif ( $file =~ m/.pl$/xms ) {
            $input_lines =~ s/(use\s+strict;)/use RPerl;\n$1/xms;
            $input_lines =~ s/(use\s+warnings;)\nuse\s+RPerl::AfterSubclass;/$1/xms;
        }

#        RPerl::diag( 'in rperl_header_update.pl, have POST-MODIFICATION $input_lines = ' . "\n" . '<<<<<<<<<<<<<<<<================ BEGIN OUTPUT FILE ================>>>>>>>>>>>>>>' . "\n" . $input_lines . '<<<<<<<<<<<<<<<<================ END OUTPUT FILE ================>>>>>>>>>>>>>>' . "\n\n" );

#        if ( $file =~ m/.pl$/xms ) {
#            print 'PRESS <ENTER> TO CONTINUE' . "\n";
#            my $pause = <STDIN>;
#        }
        
        # write file
        open $FILE_HANDLE, '>', $file or croak 'ERROR, Cannot open file ' . $file . ' for writing,' . $OS_ERROR . ', croaking';
        print {$FILE_HANDLE} $input_lines;
        close $FILE_HANDLE or croak 'ERROR, Cannot close file ' . $file . ' after writing,' . $OS_ERROR . ', croaking';
    },

    #    $RPerl::INCLUDE_PATH . '/RPerl/Test'
    '/tmp/rperl_tmp/Test'
);

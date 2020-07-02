#!/usr/bin/perl

use Term::ANSIColor;

while(my $line = <STDIN>) {
    # remove plain text "ok" & "not ok", replace w/ colored text
    if ($line =~ s/^ok//g) {
        print colored(['bright_green on_black'], 'ok');
    }
    elsif ($line =~ s/^not ok//g) {
        print colored(['bright_red on_black'], 'not ok');
    }
    print $line;
}

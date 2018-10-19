#!/usr/bin/env perl
use strict;
use warnings;
our $VERSION = 0.001_000;

package Foo;
1;

sub bar {
    foreach my Foo $i ( 0 .. 2 ) { 1; }    # YES BUG in RequireFinalReturn

    # for my Foo $i ( 0 .. 2 ) { 1; } # YES BUG in RequireFinalReturn
    # foreach my $i ( 0 .. 2 ) { 1; } # no bug in RequireFinalReturn
    return 1;
}

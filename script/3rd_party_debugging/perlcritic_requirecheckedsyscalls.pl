#!/usr/bin/perl
use strict;
use warnings;

package Foo;
our $VERSION = 0.001_000;
## no critic qw(ProhibitUselessNoCritic RequireCheckedSyscalls)
foreach my Foo $my_foo ( @{ [ 0, 1 ] } ) {
    print $my_foo;
}
1;
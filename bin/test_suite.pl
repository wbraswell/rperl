#!/usr/bin/perl
use strict;  use warnings;

system("make");

# DEV NOTE: compiler output is getting through even with the redirection of STDERR to /dev/null, why?
for my $t (glob("t/0*.t")) {
  print STDERR "$t\n";
  system("$^X -Iblib/arch -Iblib/lib $t 2> /dev/null");  print STDERR "\n";
}

=disable
BEGIN { package main;  our $RPERL_TESTS_PATH = "/tmp/RPerl-latest/t"; } # NEED REMOVE hard-coded path

system("$main::RPERL_TESTS_PATH/01*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/02*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/03*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/04*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/05*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/06*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/07*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/08*");  print STDERR "\n\n";
=cut
exit();


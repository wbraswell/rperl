#!/usr/bin/perl
use strict;  use warnings;

system("make");

# DEV NOTE: compiler output is getting through even with the redirection of STDERR to /dev/null, why?
for my $t (glob("t/0*.t")) {
  RPerl::diag("$t\n");
  system("$^X -Iblib/arch -Iblib/lib $t 2> /dev/null");
  RPerl::diag("\n");
}

=disable
BEGIN { package main;  our $RPERL_TESTS_PATH = "/tmp/RPerl-latest/t"; } # NEED REMOVE hard-coded path

system("$main::RPERL_TESTS_PATH/01*");  RPerl::diag("\n\n");
system("$main::RPERL_TESTS_PATH/02*");  RPerl::diag("\n\n");
system("$main::RPERL_TESTS_PATH/03*");  RPerl::diag("\n\n");
system("$main::RPERL_TESTS_PATH/04*");  RPerl::diag("\n\n");
system("$main::RPERL_TESTS_PATH/05*");  RPerl::diag("\n\n");
system("$main::RPERL_TESTS_PATH/06*");  RPerl::diag("\n\n");
system("$main::RPERL_TESTS_PATH/07*");  RPerl::diag("\n\n");
system("$main::RPERL_TESTS_PATH/08*");  RPerl::diag("\n\n");
=cut
exit();


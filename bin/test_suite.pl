#!/usr/bin/perl
use strict;  use warnings;

# DEV NOTE: compiler output is getting through even with the redirection of STDERR to /dev/null, why?
system('perl -Ilib t/01*.t 2> /dev/null');  print STDERR "\n\n";
system('perl -Ilib t/02*.t 2> /dev/null');  print STDERR "\n\n";
system('perl -Ilib t/03*.t 2> /dev/null');  print STDERR "\n\n";
system('perl -Ilib t/04*.t 2> /dev/null');  print STDERR "\n\n";
system('perl -Ilib t/05*.t 2> /dev/null');  print STDERR "\n\n";
system('perl -Ilib t/06*.t 2> /dev/null');  print STDERR "\n\n";
system('perl -Ilib t/07*.t 2> /dev/null');  print STDERR "\n\n";
system('perl -Ilib t/08*.t 2> /dev/null');  print STDERR "\n\n";

=disable
BEGIN { package main;  our $RPERL_TESTS_PATH = '/tmp/RPerl-latest/t'; } # NEED REMOVE hard-coded path

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


#!/usr/bin/perl
use strict;  use warnings;

BEGIN { package main;  our $RPERL_TESTS_PATH = '/tmp/RPerl-latest/t'; } # NEED REMOVE hard-coded path

system("$main::RPERL_TESTS_PATH/01*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/02*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/03*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/04*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/05*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/06*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/07*");  print STDERR "\n\n";
system("$main::RPERL_TESTS_PATH/08*");  print STDERR "\n\n";
exit();


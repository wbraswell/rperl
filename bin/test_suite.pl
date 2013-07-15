#!/usr/bin/perl
use strict;  use warnings;

BEGIN { package main;  our $RPERL_TESTS_PATH = '/tmp/RPerl-latest/t'; } # NEED REMOVE hard-coded path

system("$main::RPERL_TESTS_PATH/01*");  print "\n\n";
system("$main::RPERL_TESTS_PATH/02*");  print "\n\n";
system("$main::RPERL_TESTS_PATH/03*");  print "\n\n";
system("$main::RPERL_TESTS_PATH/04*");  print "\n\n";
exit();
system("$main::RPERL_TESTS_PATH/05*");  print "\n\n";

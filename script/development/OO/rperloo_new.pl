#!/usr/bin/perl

use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

use MyRPerlClassNew;

my MyRPerlClassNew $my_rperl_object = MyRPerlClassNew->new({bar => 22});

print 'have $my_rperl_object->get_bar() = ', $my_rperl_object->get_bar(), "\n";

$my_rperl_object->double_bar_save();
print 'have $my_rperl_object->get_bar() = ', $my_rperl_object->get_bar(), "\n";

print 'have $my_rperl_object->double_bar_return() = ', $my_rperl_object->double_bar_return(), "\n";
print 'have $my_rperl_object->get_bar() = ', $my_rperl_object->get_bar(), "\n";

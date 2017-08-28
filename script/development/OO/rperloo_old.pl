#!/usr/bin/perl

use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

use MyRPerlClassOld;

# class example

my MyRPerlClassOld $my_rperl_object = MyRPerlClassOld->new();
$my_rperl_object->set_bar(22);
print 'have $my_rperl_object->get_bar() = ', $my_rperl_object->get_bar(), "\n";

$my_rperl_object->double_bar_save();
print 'have $my_rperl_object->get_bar() = ', $my_rperl_object->get_bar(), "\n";

print 'have $my_rperl_object->double_bar_return() = ', $my_rperl_object->double_bar_return(), "\n";
print 'have $my_rperl_object->get_bar() = ', $my_rperl_object->get_bar(), "\n";

# subclass example

my MyRPerlSubclassOld $my_rperl_object_subclass = MyRPerlSubclassOld->new();
$my_rperl_object_subclass->set_bar(33);
print 'have $my_rperl_object_subclass->get_bar() = ', $my_rperl_object_subclass->get_bar(), "\n";
print 'have $my_rperl_object_subclass->get_bax() = ', $my_rperl_object_subclass->get_bax(), "\n";

$my_rperl_object_subclass->triple_bax_save();
print 'have $my_rperl_object_subclass->get_bax() = ', $my_rperl_object_subclass->get_bax(), "\n";

print 'have $my_rperl_object_subclass->triple_bax_return() = ', $my_rperl_object_subclass->triple_bax_return(), "\n";
print 'have $my_rperl_object_subclass->get_bax() = ', $my_rperl_object_subclass->get_bax(), "\n";

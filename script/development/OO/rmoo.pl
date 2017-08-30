#!/usr/bin/perl


use strict;
use warnings;


use MyRMooClass;

# class example

my MyRMooClass $my_rmoo_object = MyRMooClass->new({bar => 22});

print 'have $my_rmoo_object->bar() = ', $my_rmoo_object->bar(), "\n";

$my_rmoo_object->double_bar_save();
print 'have $my_rmoo_object->bar() = ', $my_rmoo_object->bar(), "\n";

print 'have $my_rmoo_object->double_bar_return() = ', $my_rmoo_object->double_bar_return(), "\n";
print 'have $my_rmoo_object->bar() = ', $my_rmoo_object->bar(), "\n";

# subclass example

my MyRMooSubclass $my_rmoo_object_subclass = MyRMooSubclass->new({bar => 33});

print 'have $my_rmoo_object_subclass->bar() = ', $my_rmoo_object_subclass->bar(), "\n";
print 'have $my_rmoo_object_subclass->bax() = ', $my_rmoo_object_subclass->bax(), "\n";

$my_rmoo_object_subclass->triple_bax_save();
print 'have $my_rmoo_object_subclass->bax() = ', $my_rmoo_object_subclass->bax(), "\n";

print 'have $my_rmoo_object_subclass->triple_bax_return() = ', $my_rmoo_object_subclass->triple_bax_return(), "\n";
print 'have $my_rmoo_object_subclass->bax() = ', $my_rmoo_object_subclass->bax(), "\n";

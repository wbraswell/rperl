#!/usr/bin/perl


use strict;
use warnings;


use MyMooClass;

# class example

my MyMooClass $my_moo_object = MyMooClass->new({bar => 22});

print 'have $my_moo_object->bar() = ', $my_moo_object->bar(), "\n";

$my_moo_object->double_bar_save();
print 'have $my_moo_object->bar() = ', $my_moo_object->bar(), "\n";

print 'have $my_moo_object->double_bar_return() = ', $my_moo_object->double_bar_return(), "\n";
print 'have $my_moo_object->bar() = ', $my_moo_object->bar(), "\n";

# subclass example

my MyMooSubclass $my_moo_object_subclass = MyMooSubclass->new({bar => 33, bax => 123});  # MUST SUPPLY bax TO AVOID: "Missing required arguments: bax"

print 'have $my_moo_object_subclass->bar() = ', $my_moo_object_subclass->bar(), "\n";
print 'have $my_moo_object_subclass->bax() = ', $my_moo_object_subclass->bax(), "\n";

$my_moo_object_subclass->triple_bax_save();
print 'have $my_moo_object_subclass->bax() = ', $my_moo_object_subclass->bax(), "\n";

print 'have $my_moo_object_subclass->triple_bax_return() = ', $my_moo_object_subclass->triple_bax_return(), "\n";
print 'have $my_moo_object_subclass->bax() = ', $my_moo_object_subclass->bax(), "\n";

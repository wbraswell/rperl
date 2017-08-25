#!/usr/bin/perl

use MyMooClass;

my MyMooClass $my_moo_object = MyMooClass->new({bar => 22});
print 'have $my_moo_object->bar() = ', $my_moo_object->bar(), "\n";

#!/usr/bin/perl

use MyRMooClass;

my MyRMooClass $my_rmoo_object = MyRMooClass->new({bar => 22});
print 'have $my_rmoo_object->bar() = ', $my_rmoo_object->bar(), "\n";

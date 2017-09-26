#!/usr/bin/perl

# [[[ HEADER ]]]

use strict;
use warnings;







# [[[ INCLUDES ]]]
use MyClass05MediumMoo;

# [[[ OPERATIONS ]]]

# class example

my MyClass05MediumMoo $my_object = MyClass05MediumMoo->new({bar => 22});

print 'have $my_object->bar() = ', $my_object->bar(), "\n";

$my_object->double_bar_save();
print 'have $my_object->bar() = ', $my_object->bar(), "\n";

print 'have $my_object->double_bar_return() = ', $my_object->double_bar_return(), "\n";
print 'have $my_object->bar() = ', $my_object->bar(), "\n";

# subclass example

my MySubclass05MediumMoo $my_object_subclass = MySubclass05MediumMoo->new({bar => 33, bax => 123});  # MUST SUPPLY bax TO AVOID: "Missing required arguments: bax"

print 'have $my_object_subclass->bar() = ', $my_object_subclass->bar(), "\n";
print 'have $my_object_subclass->bax() = ', $my_object_subclass->bax(), "\n";

$my_object_subclass->triple_bax_save();
print 'have $my_object_subclass->bax() = ', $my_object_subclass->bax(), "\n";

print 'have $my_object_subclass->triple_bax_return() = ', $my_object_subclass->triple_bax_return(), "\n";
print 'have $my_object_subclass->bax() = ', $my_object_subclass->bax(), "\n";

print 'have $my_object_subclass->multiply_bax_return(2) = ', $my_object_subclass->multiply_bax_return(2), "\n";
print 'have $my_object_subclass->bax() = ', $my_object_subclass->bax(), "\n";

print 'have $my_object_subclass->multiply_bax_return(20) = ', $my_object_subclass->multiply_bax_return(20), "\n";
print 'have $my_object_subclass->bax() = ', $my_object_subclass->bax(), "\n";

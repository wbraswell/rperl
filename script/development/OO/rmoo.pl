#!/usr/bin/perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitMultiplePackages ProhibitReusedNames ProhibitPackageVars)  # USER DEFAULT 8: allow additional packages

# [[[ INCLUDES ]]]
use MyRMooClass;

# [[[ OPERATIONS ]]]

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

print 'have $my_rmoo_object_subclass->multiply_bax_return(2) = ', $my_rmoo_object_subclass->multiply_bax_return(2), "\n";
print 'have $my_rmoo_object_subclass->bax() = ', $my_rmoo_object_subclass->bax(), "\n";

print 'have $my_rmoo_object_subclass->multiply_bax_return(20) = ', $my_rmoo_object_subclass->multiply_bax_return(20), "\n";
print 'have $my_rmoo_object_subclass->bax() = ', $my_rmoo_object_subclass->bax(), "\n";

#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $my_object->get_bar() = 22' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object->get_bar() = 44' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object->double_bar_return() = 88' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object->get_bar() = 44' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass->get_bar() = 23' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass->get_bax() = 123' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass->get_bax() = 369' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass->triple_bax_return() = 1107' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass->get_bax() = 369' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass->multiply_bax_return(2) = 738' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass->get_bax() = 369' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass->multiply_bax_return(20) = 1107' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass->get_bax() = 369' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass2->get_bar() = 33' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass2->get_bax() = 88' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass2->get_bax() = 264' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass2->triple_bax_return() = 792' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass2->get_bax() = 264' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass2->multiply_bax_return(2) = 528' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass2->get_bax() = 264' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass2->multiply_bax_return(20) = 792' >>>
# <<< EXECUTE_SUCCESS: 'have $my_object_subclass2->get_bax() = 264' >>>

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
use RPerl::Test::OO::MyClass01Good;

# [[[ OPERATIONS ]]]

# class example

my RPerl::Test::OO::MyClass01Good $my_object = RPerl::Test::OO::MyClass01Good->new({bar => 22});

print 'have $my_object->get_bar() = ', $my_object->get_bar(), "\n";

$my_object->double_bar_save();
print 'have $my_object->get_bar() = ', $my_object->get_bar(), "\n";

print 'have $my_object->double_bar_return() = ', $my_object->double_bar_return(), "\n";
print 'have $my_object->get_bar() = ', $my_object->get_bar(), "\n";

# subclass example 1

my RPerl::Test::OO::MySubclass01Good $my_object_subclass = RPerl::Test::OO::MySubclass01Good->new();

print 'have $my_object_subclass->get_bar() = ', $my_object_subclass->get_bar(), "\n";
print 'have $my_object_subclass->get_bax() = ', $my_object_subclass->get_bax(), "\n";

$my_object_subclass->triple_bax_save();
print 'have $my_object_subclass->get_bax() = ', $my_object_subclass->get_bax(), "\n";

print 'have $my_object_subclass->triple_bax_return() = ', $my_object_subclass->triple_bax_return(), "\n";
print 'have $my_object_subclass->get_bax() = ', $my_object_subclass->get_bax(), "\n";

print 'have $my_object_subclass->multiply_bax_return(2) = ', $my_object_subclass->multiply_bax_return(2), "\n";
print 'have $my_object_subclass->get_bax() = ', $my_object_subclass->get_bax(), "\n";

print 'have $my_object_subclass->multiply_bax_return(20) = ', $my_object_subclass->multiply_bax_return(20), "\n";
print 'have $my_object_subclass->get_bax() = ', $my_object_subclass->get_bax(), "\n";

# subclass example 2

my RPerl::Test::OO::MySubclass01Good $my_object_subclass2 = RPerl::Test::OO::MySubclass01Good->new({bar => 33, bax => 88});

print 'have $my_object_subclass2->get_bar() = ', $my_object_subclass2->get_bar(), "\n";
print 'have $my_object_subclass2->get_bax() = ', $my_object_subclass2->get_bax(), "\n";

$my_object_subclass2->triple_bax_save();
print 'have $my_object_subclass2->get_bax() = ', $my_object_subclass2->get_bax(), "\n";

print 'have $my_object_subclass2->triple_bax_return() = ', $my_object_subclass2->triple_bax_return(), "\n";
print 'have $my_object_subclass2->get_bax() = ', $my_object_subclass2->get_bax(), "\n";

print 'have $my_object_subclass2->multiply_bax_return(2) = ', $my_object_subclass2->multiply_bax_return(2), "\n";
print 'have $my_object_subclass2->get_bax() = ', $my_object_subclass2->get_bax(), "\n";

print 'have $my_object_subclass2->multiply_bax_return(20) = ', $my_object_subclass2->multiply_bax_return(20), "\n";
print 'have $my_object_subclass2->get_bax() = ', $my_object_subclass2->get_bax(), "\n";


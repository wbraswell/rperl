#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '69' >>>
# <<< EXECUTE_SUCCESS: '1656' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.000_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::Properties::Class_00_Good;

# [[[ OPERATIONS ]]]
# set and get object property ourself
# using auto-generated set_test_property() and get_test_property() methods, preserving object encapsulation
my object $test_object = RPerl::Test::Properties::Class_00_Good->new();
$test_object->set_test_property(3);
$test_object->test_method(23);
print $test_object->get_test_property() . "\n";

$test_object->test_method(24);
print $test_object->get_test_property() . "\n";
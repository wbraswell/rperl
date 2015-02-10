#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: '115' >>>
# <<< RUN_SUCCESS: '120' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::Properties::Class_00_Good;

# [[[ OPERATIONS ]]]
# set and get object property ourself
# using direct access to blessed $property hash_ref, breaking object encapsulation
my object $test_object = RPerl::Test::Properties::Class_00_Good->new();
$test_object->{test_property} = 5;
$test_object->test_method(23);
print $test_object->{test_property} . "\n";

$test_object->set_test_property(5);
$test_object->test_method(24);
print $test_object->get_test_property() . "\n";

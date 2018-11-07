#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '[ 'a', 'b', 'c', 'd' ]' >>>
# <<< EXECUTE_SUCCESS: '{ 'a' => 2, 'b' => 4, 'c' => 6, 'd' => 8 }' >>>
# <<< EXECUTE_SUCCESS: '{ 'a' => 46, 'b' => 4, 'c' => 6, 'd' => 8 }' >>>
# <<< EXECUTE_SUCCESS: '6' >>>
# <<< EXECUTE_SUCCESS: '{ 'a' => 46, 'b' => 4, 'c' => 23, 'd' => 8 }' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.000_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::Properties::Class_20_Good;

# [[[ OPERATIONS ]]]
my RPerl::Test::Properties::Class_20_Good $test_object = RPerl::Test::Properties::Class_20_Good->new();
#print string_arrayref_to_string($test_object->get_test_property_keys()) . "\n";  # DEV NOTE: no error, but perhaps unpredictable behavior, so disable for now???

# DEV NOTE, CORRELATION #rp054: auto-generation of OO property accessors/mutators checks the auto-generated RPerl type list for base data types to determine if the entire data structure can be returned by setting ($return_whole = 1)

$test_object->set_test_property({a => 2, b => 4, c => 6, d => 8});
print string_arrayref_to_string($test_object->get_test_property_keys()), "\n";
print integer_hashref_to_string($test_object->get_test_property()), "\n";

my integer_hashref $retval = $test_object->test_method(23);
print integer_hashref_to_string($retval), "\n";

print $test_object->get_test_property_entry_value('c'), "\n";

$test_object->set_test_property_entry_value('c', 23);
print integer_hashref_to_string($test_object->get_test_property()), "\n";

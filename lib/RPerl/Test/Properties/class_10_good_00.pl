#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '4' >>>
# <<< EXECUTE_SUCCESS: '[ 2, 4, 6, 8 ]' >>>
# <<< EXECUTE_SUCCESS: '[ 46, 4, 6, 8 ]' >>>
# <<< EXECUTE_SUCCESS: '6' >>>
# <<< EXECUTE_SUCCESS: '[ 46, 4, 23, 8 ]' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.000_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Test::Properties::Class_10_Good;

# [[[ OPERATIONS ]]]
my RPerl::Test::Properties::Class_10_Good $test_object = RPerl::Test::Properties::Class_10_Good->new();
#print $test_object->get_test_property_size() . "\n";  # ERROR: Can't use an undefined value as an ARRAY reference 

# DEV NOTE, CORRELATION #rp054: auto-generation of OO property accessors/mutators checks the auto-generated RPerl type list for base data types to determine if the entire data structure can be returned by setting ($return_whole = 1)

$test_object->set_test_property([2, 4, 6, 8]);
print $test_object->get_test_property_size() . "\n";
print integer_arrayref_to_string($test_object->get_test_property()) . "\n";

my integer_arrayref $retval = $test_object->test_method(23);
print integer_arrayref_to_string($retval) . "\n";

print $test_object->get_test_property_element(2), "\n";

$test_object->set_test_property_element(2, 23);
print integer_arrayref_to_string($test_object->get_test_property()) . "\n";

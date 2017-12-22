#!/usr/bin/perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Support::MongoDB;

# [[[ OPERATIONS ]]]

my MongoDB::MongoClient $my_client = MongoDB::MongoClient::mongodb_new({host => 'localhost', port => 27_017});

my string $my_database_name = 'rperl_test_database';
print {*STDERR} 'have $my_database_name = ', $my_database_name, "\n";

my MongoDB::Database $my_database = $my_client->mongodb_get_database($my_database_name);
#print {*STDERR} 'have $my_database = ', Dumper($my_database), "\n";  # ERROR IN C++

my string $my_collection_name = 'rperl_test_collection';
print {*STDERR} 'have $my_collection_name = ', $my_collection_name, "\n";

my MongoDB::Collection $my_collection = $my_database->mongodb_get_collection($my_collection_name);
#print {*STDERR} 'have $my_collection = ', Dumper($my_collection), "\n";  # ERROR IN C++

my bson_docval $my_document_value = {
    name => 'rperl_test_data',
    source => 'Perl',
    foo_integer => my integer $TYPED_foo_integer = 1,
    foo_string_arrayref => my bson_arrayref $TYPED_foo_string_arrayref = ['abc', 'def', 'ghi'],
    foo_integer_hashref => my bson_hashref  $TYPED_foo_integer_hashref = { x => 203, y => 102 }
};
my MongoDB::InsertOneResult $my_result = $my_collection->mongodb_insert_one($my_document_value);
#print {*STDERR} 'have $my_result = ', Dumper($my_result), "\n";  # ERROR IN C++

my hashref $my_found_data = $my_collection->mongodb_find_one({ name => 'rperl_test_data' });
if (defined $my_found_data) { print {*STDERR} 'have    $my_found_data = ', Dumper($my_found_data), "\n"; }
else                        { print {*STDERR} 'have NO $my_found_data', "\n"; }

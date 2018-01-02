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

my MongoDB::MongoClient $my_client = MongoDB::MongoClient->new();                                       # YES SUPPORT, default value
#my MongoDB::MongoClient $my_client = MongoDB::MongoClient->new({host => 'mongodb://localhost:27017'});  # YES SUPPORT, host parameter
#my MongoDB::MongoClient $my_client = MongoDB::MongoClient->new({host => q{mongodb://localhost:27017}}); # YES SUPPORT, host parameter

my string $my_database_name = 'rperl_test_database';
print {*STDERR} 'have $my_database_name = ', $my_database_name, "\n";

my MongoDB::Database $my_database = mongodb_get_database($my_client, $my_database_name);   # YES SUPPORT,   wrapped calling convention, procedural
#print {*STDERR} 'have $my_database = ', Dumper($my_database), "\n";  # ERROR IN C++

my string $my_collection_name = 'rperl_test_collection';
print {*STDERR} 'have $my_collection_name = ', $my_collection_name, "\n";

my MongoDB::Collection $my_collection = mongodb_get_collection($my_database, $my_collection_name);   # YES SUPPORT,   wrapped calling convention, procedural
#print {*STDERR} 'have $my_collection = ', Dumper($my_collection), "\n";  # ERROR IN C++

my bson_document $my_document = bson_build({
    name => my string $TYPED_name = 'rperl_test_data',
    source => my string $TYPED_source = 'Perl',
    foo_integer => my integer $TYPED_foo_integer = 1,
    foo_string_arrayref => my bson_arrayref $TYPED_foo_string_arrayref = ['abc', 'def', 'ghi'],
    foo_integer_hashref => my bson_hashref  $TYPED_foo_integer_hashref = { x => 203, y => 102 }
});

my MongoDB::InsertOneResult $my_result = mongodb_insert_one($my_collection, $my_document);   # YES SUPPORT,   wrapped calling convention, procedural
#print {*STDERR} 'have $my_result = ', Dumper($my_result), "\n";  # ERROR IN C++

my bson_document__optional $my_found_data = mongodb_find_one($my_collection, bson_build({ name => 'rperl_test_data' }));   # YES SUPPORT,   wrapped calling convention, procedural

if ($my_found_data) { print {*STDERR} 'have    $my_found_data = ', bson_Dumper($my_found_data), "\n"; }
else                { print {*STDERR} 'have NO $my_found_data', "\n"; }

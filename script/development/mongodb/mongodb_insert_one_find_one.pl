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

my MongoDB::MongoClient $client = MongoDB::MongoClient->new({host => 'localhost', port => 27_017});
my string $db_name = 'rperl_test_db';
print {*STDERR} 'have $db_name = ', $db_name, "\n";

my MongoDB::Database $database = $client->mongodb_get_database($db_name);
print {*STDERR} 'have $database = ', Dumper($database), "\n";

my MongoDB::Collection $collection = $database->mongodb_get_collection('record-collection');
print {*STDERR} 'have $collection = ', Dumper($collection), "\n";

my MongoDB::InsertOneResult $result = $collection->mongodb_insert_one({
    name => 'rperl_test_data',
    source => 'Perl',
    foo_integer => 1,
    foo_stringarrayref => ['abc', 'def', 'ghi'],
    foo_integer_hashref => { x => 203, y => 102 }
});
print {*STDERR} 'have $result = ', Dumper($result), "\n";

my hashref $found_data = $collection->mongodb_find_one({ name => 'rperl_test_data' });
print {*STDERR} 'have $found_data = ', Dumper($found_data), "\n";

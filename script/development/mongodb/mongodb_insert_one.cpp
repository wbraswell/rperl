#include <cstdint>
#include <iostream>
#include <vector>
#include <string>
#include <bsoncxx/json.hpp>
#include <mongocxx/client.hpp>
#include <mongocxx/stdx.hpp>
#include <mongocxx/uri.hpp>
#include <mongocxx/instance.hpp>

using std::cout;  using std::cerr;  using std::endl;

using bsoncxx::builder::stream::close_array;
using bsoncxx::builder::stream::close_document;
using bsoncxx::builder::stream::document;
using bsoncxx::builder::stream::finalize;
using bsoncxx::builder::stream::open_array;
using bsoncxx::builder::stream::open_document;

int main() {
    // this should be done only once; this line does not exist in Perl
    mongocxx::instance my_instance{};

    // my MongoDB::MongoClient $client = MongoDB::MongoClient->mongodb_new({host => 'localhost', port => 27_017});
    mongocxx::client my_client{mongocxx::uri{"mongodb://localhost:27017"}};

    // my string $my_database_name = 'rperl_test_database';
    std::string my_database_name = "rperl_test_database";
    // print {*STDERR} 'have $my_database_name = ', $my_database_name, "\n";
    cerr << "have $my_database_name = " << my_database_name << endl;

    // my MongoDB::Database $my_database = $my_client->mongodb_get_database($my_database_name);
    mongocxx::database my_database = my_client[my_database_name];
    // print {*STDERR} 'have $my_database = ', Dumper($my_database), "\n";
//    cerr << "have $my_database = " << my_database << endl;  // ERROR

    // my string $my_collection_name = 'rperl_test_collection';
    std::string my_collection_name = "rperl_test_collection";
    // print {*STDERR} 'have $my_collection_name = ', $my_collection_name, "\n";
    cerr << "have $my_collection_name = " << my_collection_name << endl;

    // my MongoDB::Collection $my_collection = $my_database->mongodb_get_collection($my_collection_name);
    mongocxx::collection my_collection = my_database[my_collection_name];
    // print {*STDERR} 'have $my_collection = ', Dumper($my_collection), "\n";
//    cerr << "have $my_collection = " << my_collection << endl;  // ERROR

    // my bson_document $my_document = {
    bsoncxx::document::value my_document = bsoncxx::builder::stream::document{}
        // name => 'rperl_test_data',
        << "name" << "rperl_test_data"
        // source => 'Perl',
        << "source" << "C++"
        // foo_integer => my integer $TYPED_foo_integer = 1,
        << "foo_integer" << 1
        // foo_string_arrayref => my bson_arrayref $TYPED_foo_string_arrayref = ['abc', 'def', 'ghi'],
        << "foo_string_arrayref" << bsoncxx::builder::stream::open_array
            << "abc" << "def" << "ghi"
        << close_array
        // foo_integer_hashref => my bson_hashref  $TYPED_foo_integer_hashref = { x => 203, y => 102 }
        << "foo_integer_hashref" << bsoncxx::builder::stream::open_document
            << "x" << 203
            << "y" << 102
        << bsoncxx::builder::stream::close_document
    // };
    << bsoncxx::builder::stream::finalize;

    // my MongoDB::InsertOneResult $my_result = $my_collection->mongodb_insert_one($my_document);
    bsoncxx::stdx::optional<mongocxx::result::insert_one> my_result = my_collection.insert_one(my_document.view());

    // print {*STDERR} 'have $my_result = ', Dumper($my_result), "\n";
//    cerr << "have $my_result = " << my_result << endl;  // ERROR

    // my hashref $my_found_data = $my_collection->mongodb_find_one({ name => 'rperl_test_data' });
    bsoncxx::stdx::optional<bsoncxx::document::value> my_found_data = my_collection.find_one(document{} << "name" << "rperl_test_data" << finalize);

    // if (defined $my_found_data) { print {*STDERR} 'have    $my_found_data = ', Dumper($my_found_data), "\n"; }
    if (my_found_data) { cerr << "have    $my_found_data = " << bsoncxx::to_json(*my_found_data) << endl; }
    // else                     { print {*STDERR} 'have NO $my_found_data', "\n"; }
    else               { cerr << "have NO $my_found_data" << endl; }
}

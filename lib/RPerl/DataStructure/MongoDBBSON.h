using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__MongoDBBSON_h
#define __CPP__INCLUDED__RPerl__DataStructure__MongoDBBSON_h 0.002_000

// [[[ INCLUDES ]]]
/* DISABLED: the following #include directives are set in $RPerl::Inline::ARGS{auto_include} in Compiler.pm
#include <bsoncxx/json.hpp>
#include <bsoncxx/builder/stream/document.hpp>
*/

# ifndef __CPP__INCLUDED__RPerl__DataStructure__MongoDBBSON_h__typedefs
#define __CPP__INCLUDED__RPerl__DataStructure__MongoDBBSON_h__typedefs 1

// [[[ TYPEDEFS ]]]
#define bson_document bsoncxx::document::value
#define bson_document__optional bsoncxx::stdx::optional<bsoncxx::document::value>
//#define bson_arrayref ---  // NOT AN ACTUAL C++ TYPE
//#define bson_hashref ---   // NOT AN ACTUAL C++ TYPE

// [[[ MACROS ]]]
#define bson_begin bsoncxx::builder::stream::document{}
#define bson_end bsoncxx::builder::stream::finalize
#define bson_arrayref_begin bsoncxx::builder::stream::open_array
#define bson_arrayref_end bsoncxx::builder::stream::close_array
#define bson_hashref_begin bsoncxx::builder::stream::open_document
#define bson_hashref_end bsoncxx::builder::stream::close_document
#define bson_Dumper(my_bson_data) bsoncxx::to_json(*my_bson_data)

// [[[ OO SUBCLASSES ]]]
/* UNUSED?
typedef std::unique_ptr<bson_document> bson_document_ptr;
typedef std::vector<bson_document_ptr> bson_document_arrayref;
typedef std::unordered_map<string, bson_document_ptr> bson_document_hashref;
typedef std::unordered_map<string, bson_document_ptr>::iterator bson_document_hashref_iterator;
*/

# endif

// [[[ INCLUDES ]]]
#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__MongoDBBSON__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
int RPerl__DataStructure__MongoDBBSON__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

#endif

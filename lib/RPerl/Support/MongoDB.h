// NEED UPDATE, CORRELATION #rp130: all changes to this file must also be made in lib/RPerl/Support/MongoDBStandAlone.h !!!

using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__Support__MongoDB_h
#define __CPP__INCLUDED__RPerl__Support__MongoDB_h 0.001_000

// [[[ INCLUDES ]]]

/* DISABLED: the following #undef & #include directives are set in $RPerl::Inline::ARGS{auto_include} in Compiler.pm
// fix conflict between RPerl's use of "exp" exponent function from math.h (in rperloperations.h) & MongoDB BSON "exp" expected value (in bsoncxx/v_noabi/bsoncxx/third_party/mnmlstc/core/optional.hpp);
// error: expected ‘,’ or ‘...’    AND    note: in expansion of macro ‘exp’
#undef exp
#include <mongocxx/client.hpp>
#include <mongocxx/stdx.hpp>
#include <mongocxx/uri.hpp>
#include <mongocxx/instance.hpp>
*/

#include <RPerl/DataStructure/MongoDBBSON.h> // -> NULL

# ifndef __CPP__INCLUDED__RPerl__Support__MongoDB_h__typedefs
#define __CPP__INCLUDED__RPerl__Support__MongoDB_h__typedefs 1

// [[[ TYPEDEFS ]]]
#define MongoDB__MongoClient mongocxx::client
#define MongoDB__Database mongocxx::database
#define MongoDB__Collection mongocxx::collection
#define MongoDB__InsertOneResult bsoncxx::stdx::optional<mongocxx::result::insert_one>  // all InsertOneResult data types are optional, no need for '__optional' suffix
#define mongodb_host mongocxx::uri

// [[[ LOAD MONGODB DRIVER ]]]
// this should be done only once; this line does not exist in Perl
mongocxx::instance my_instance{};

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
SV* RPerl__Support__MongoDB__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
int RPerl__Support__MongoDB__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

#endif

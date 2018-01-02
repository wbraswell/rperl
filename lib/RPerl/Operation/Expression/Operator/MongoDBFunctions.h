#ifndef __CPP__INCLUDED__RPerl_Operation_Expression_Operator_MongoDBFunctions_h
#define __CPP__INCLUDED__RPerl_Operation_Expression_Operator_MongoDBFunctions_h 0.001_000

# ifdef __PERL__TYPES
// insert CPPOPS_PERLTYPES code here
# elif defined __CPP__TYPES
#define mongodb_get_database(my_client, my_database_name) my_client[my_database_name]
#define mongodb_get_collection(my_database, my_collection_name) my_database[my_collection_name]
#define mongodb_insert_one(my_collection, my_document) my_collection.insert_one(my_document.view())
#define mongodb_find_one(my_collection, my_document) my_collection.find_one(my_document)
# endif

#endif

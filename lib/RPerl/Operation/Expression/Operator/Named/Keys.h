////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__Operation__Expression__Operator__Named__Keys_h
#define __CPP__INCLUDED__RPerl__Operation__Expression__Operator__Named__Keys_h 0.001_000

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ DATA TYPES ]]]
#include <RPerl/DataType/Integer.cpp>
#include <RPerl/DataType/Number.cpp>
#include <RPerl/DataType/String.cpp>
#include <RPerl/DataStructure/Array.cpp>  // -> ???    for integer_arrayref_to_string_format() used in integer_arrayref_hashref_to_string_format() ???
#include <RPerl/DataStructure/Hash.cpp>  // -> ???    for ???

// [[[ SUBROUTINES ]]]

# ifdef __PERL__TYPES

SV*                          keys(SV* input_hvref);        // short-hand, type-independent

SV* integer_arrayref_hashref_keys(SV* input_avref_hvref);  //  long-hand, type-dependent

# elif defined __CPP__TYPES



// NEED TEST: use of 'HASH' below
// NEED TEST: use of 'HASH' below
// NEED TEST: use of 'HASH' below

//#  define HASH std::unordered_map



// template, type-independent
template<string, typename HASH_VALUE_TYPE>
string_arrayref keys(std::unordered_map<string, HASH_VALUE_TYPE> const &input_unordered_map);

/* NEED DELETE, TYPE-SPECIFIC CODE REPLACED BY TYPE-INDEPENDENT TEMPLATE CODE

string_arrayref integer_arrayref_hashref_keys(integer_arrayref_hashref input_vector_unordered_map);  //  long-hand, type-dependent
                                         keys(integer_arrayref_hashref input_vector_unordered_map);  // short-hand, type-dependent
*/






# endif

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__Operation__Expression__Operator__Named__Keys__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__Operation__Expression__Operator__Named__Keys__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

#endif

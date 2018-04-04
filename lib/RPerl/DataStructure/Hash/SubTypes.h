////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes_h
#define __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes_h 0.002_000

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ DATA TYPES ]]]
#include <RPerl/DataType/Integer.cpp>
#include <RPerl/DataType/Number.cpp>
#include <RPerl/DataType/String.cpp>

// [[[ TYPEDEFS, REPEATED ]]]
typedef std::unordered_map<string, integer> integer_hashref;
typedef std::unordered_map<string, integer>::iterator integer_hashref_iterator;
typedef std::unordered_map<string, integer>::const_iterator integer_hashref_const_iterator;
typedef std::unordered_map<string, number> number_hashref;
typedef std::unordered_map<string, number>::iterator number_hashref_iterator;
typedef std::unordered_map<string, number>::const_iterator number_hashref_const_iterator;
typedef std::unordered_map<string, string> string_hashref;
typedef std::unordered_map<string, string>::iterator string_hashref_iterator;
typedef std::unordered_map<string, string>::const_iterator string_hashref_const_iterator;

// [[[ TYPEDEFS ]]]
typedef std::unordered_map<string, std::vector<integer>> integer_arrayref_hashref;
typedef std::unordered_map<string, std::vector<integer>>::iterator integer_arrayref_hashref_iterator;
typedef std::unordered_map<string, std::vector<integer>>::const_iterator integer_arrayref_hashref_const_iterator;
typedef std::unordered_map<string, std::vector<number>> number_arrayref_hashref;
typedef std::unordered_map<string, std::vector<number>>::iterator number_arrayref_hashref_iterator;
typedef std::unordered_map<string, std::vector<number>>::const_iterator number_arrayref_hashref_const_iterator;
typedef std::unordered_map<string, std::vector<string>> string_arrayref_hashref;
typedef std::unordered_map<string, std::vector<string>>::iterator string_arrayref_hashref_iterator;
typedef std::unordered_map<string, std::vector<string>>::const_iterator string_arrayref_hashref_const_iterator;

// [[[ TYPE-CHECKING SUBROUTINES ]]]
// NEED ENABLE, implement remaining function definitions in SubTypes.h
void integer_arrayref_hashref_CHECK(SV* possible_integer_arrayref_hashref);
void integer_arrayref_hashref_CHECKTRACE(SV* possible_integer_arrayref_hashref, const char* variable_name, const char* subroutine_name);
//void number_arrayref_hashref_CHECK(SV* possible_number_arrayref_hashref);
//void number_arrayref_hashref_CHECKTRACE(SV* possible_number_arrayref_hashref, const char* variable_name, const char* subroutine_name);
//void string_arrayref_hashref_CHECK(SV* possible_string_arrayref_hashref);
//void string_arrayref_hashref_CHECKTRACE(SV* possible_string_arrayref_hashref, const char* variable_name, const char* subroutine_name);

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__Hash__SubTypes__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Hash__SubTypes__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
integer_arrayref_hashref XS_unpack_integer_arrayref_hashref(SV* input_avref_hvref);
void XS_pack_integer_arrayref_hashref(SV* output_avref_hvref, integer_arrayref_hashref input_vector_unordered_map);
number_arrayref_hashref XS_unpack_number_arrayref_hashref(SV* input_avref_hvref);
void XS_pack_number_arrayref_hashref(SV* output_avref_hvref, number_arrayref_hashref input_vector_unordered_map);
string_arrayref_hashref XS_unpack_string_arrayref_hashref(SV* input_avref_hvref);
void XS_pack_string_arrayref_hashref(SV* output_avref_hvref, string_arrayref_hashref input_vector_unordered_map);
# endif

// [[[ STRINGIFY ]]]
// NEED ENABLE, implement function definitions in SubTypes.h
# ifdef __PERL__TYPES
//SV* integer_arrayref_hashref_to_string(SV* input_avref_hvref);
//SV* number_arrayref_hashref_to_string(SV* input_avref_hvref);
//SV* string_arrayref_hashref_to_string(SV* input_avref_hvref);
# elif defined __CPP__TYPES
//string integer_arrayref_hashref_to_string(integer_arrayref_hashref input_vector_unordered_map);
//string number_arrayref_hashref_to_string(number_arrayref_hashref input_vector_unordered_map);
//string string_arrayref_hashref_to_string(string_arrayref_hashref input_vector_unordered_map);
# endif

// [[[ TYPE TESTING ]]]
// NEED ENABLE, implement function definitions in SubTypes.h
# ifdef __PERL__TYPES
//SV* integer_arrayref_hashref_typetest0(SV* lucky_integers);
//SV* integer_arrayref_hashref_typetest1(SV* my_size);
//SV* number_arrayref_hashref_typetest0(SV* lucky_numbers);
//SV* number_arrayref_hashref_typetest1(SV* my_size);
//SV* string_arrayref_hashref_typetest0(SV* people);
//SV* string_arrayref_hashref_typetest1(SV* my_size);
# elif defined __CPP__TYPES
//string integer_arrayref_hashref_typetest0(integer_arrayref_hashref lucky_integers);
//integer_arrayref_hashref integer_arrayref_hashref_typetest1(integer my_size);
//string number_arrayref_hashref_typetest0(number_arrayref_hashref lucky_numbers);
//number_arrayref_hashref number_arrayref_hashref_typetest1(integer my_size);
//string string_arrayref_hashref_typetest0(string_arrayref_hashref people);
//string_arrayref_hashref string_arrayref_hashref_typetest1(integer my_size);
# endif

#endif

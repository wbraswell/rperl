////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes_h
#define __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes_h 0.002_000

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ DATA TYPES ]]]
#include <RPerl/DataType/Integer.cpp>
#include <RPerl/DataType/Number.cpp>
#include <RPerl/DataType/String.cpp>

// [[[ TYPEDEFS, REPEATED ]]]
typedef std::vector<integer> integer_arrayref;
typedef std::vector<integer>::iterator integer_arrayref_iterator;
typedef std::vector<integer>::const_iterator integer_arrayref_const_iterator;
typedef std::vector<number> number_arrayref;
typedef std::vector<number>::iterator number_arrayref_iterator;
typedef std::vector<number>::const_iterator number_arrayref_const_iterator;
typedef std::vector<string> string_arrayref;
typedef std::vector<string>::iterator string_arrayref_iterator;
typedef std::vector<string>::const_iterator string_arrayref_const_iterator;

// [[[ TYPEDEFS ]]]
typedef std::vector<std::vector<integer>> integer_arrayref_arrayref;
typedef std::vector<std::vector<integer>>::iterator integer_arrayref_arrayref_iterator;
typedef std::vector<std::vector<integer>>::const_iterator integer_arrayref_arrayref_const_iterator;
typedef std::vector<std::vector<number>> number_arrayref_arrayref;
typedef std::vector<std::vector<number>>::iterator number_arrayref_arrayref_iterator;
typedef std::vector<std::vector<number>>::const_iterator number_arrayref_arrayref_const_iterator;
typedef std::vector<std::vector<string>> string_arrayref_arrayref;
typedef std::vector<std::vector<string>>::iterator string_arrayref_arrayref_iterator;
typedef std::vector<std::vector<string>>::const_iterator string_arrayref_arrayref_const_iterator;

// [[[ TYPE-CHECKING SUBROUTINES ]]]
// NEED ENABLE, implement remaining function definitions in SubTypes.h
void integer_arrayref_arrayref_CHECK(SV* possible_integer_arrayref_arrayref);
void integer_arrayref_arrayref_CHECKTRACE(SV* possible_integer_arrayref_arrayref, const char* variable_name, const char* subroutine_name);
//void number_arrayref_arrayref_CHECK(SV* possible_number_arrayref_arrayref);
//void number_arrayref_arrayref_CHECKTRACE(SV* possible_number_arrayref_arrayref, const char* variable_name, const char* subroutine_name);
//void string_arrayref_arrayref_CHECK(SV* possible_string_arrayref_arrayref);
//void string_arrayref_arrayref_CHECKTRACE(SV* possible_string_arrayref_arrayref, const char* variable_name, const char* subroutine_name);

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__Array__SubTypes__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Array__SubTypes__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
integer_arrayref_arrayref XS_unpack_integer_arrayref_arrayref(SV* input_avref_avref);
void XS_pack_integer_arrayref_arrayref(SV* output_avref_avref, integer_arrayref_arrayref input_vector_vector);
number_arrayref_arrayref XS_unpack_number_arrayref_arrayref(SV* input_avref_avref);
void XS_pack_number_arrayref_arrayref(SV* output_avref_avref, number_arrayref_arrayref input_vector_vector);
string_arrayref_arrayref XS_unpack_string_arrayref_arrayref(SV* input_avref_avref);
void XS_pack_string_arrayref_arrayref(SV* output_avref_avref, string_arrayref_arrayref input_vector_vector);
# endif

// [[[ STRINGIFY ]]]
// NEED ENABLE, implement function definitions in SubTypes.h
# ifdef __PERL__TYPES
//SV* integer_arrayref_arrayref_to_string(SV* input_avref_avref);
//SV* number_arrayref_arrayref_to_string(SV* input_avref_avref);
//SV* string_arrayref_arrayref_to_string(SV* input_avref_avref);
# elif defined __CPP__TYPES
//string integer_arrayref_arrayref_to_string(integer_arrayref_arrayref input_vector_vector);
//string number_arrayref_arrayref_to_string(number_arrayref_arrayref input_vector_vector);
//string string_arrayref_arrayref_to_string(string_arrayref_arrayref input_vector_vector);
# endif

// [[[ TYPE TESTING ]]]
// NEED ENABLE, implement function definitions in SubTypes.h
# ifdef __PERL__TYPES
//SV* integer_arrayref_arrayref__typetest0(SV* lucky_integers);
//SV* integer_arrayref_arrayref__typetest1(SV* my_size);
//SV* number_arrayref_arrayref__typetest0(SV* lucky_numbers);
//SV* number_arrayref_arrayref__typetest1(SV* my_size);
//SV* string_arrayref_arrayref__typetest0(SV* people);
//SV* string_arrayref_arrayref__typetest1(SV* my_size);
# elif defined __CPP__TYPES
//string integer_arrayref_arrayref__typetest0(integer_arrayref_arrayref lucky_integers);
//integer_arrayref_arrayref integer_arrayref_arrayref__typetest1(integer my_size);
//string number_arrayref_arrayref__typetest0(number_arrayref_arrayref lucky_numbers);
//number_arrayref_arrayref number_arrayref_arrayref__typetest1(integer my_size);
//string string_arrayref_arrayref__typetest0(string_arrayref_arrayref people);
//string_arrayref_arrayref string_arrayref_arrayref__typetest1(integer my_size);
# endif

#endif

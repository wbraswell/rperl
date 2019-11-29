////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes2D_h
#define __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes2D_h 0.005_000

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ DATA TYPES ]]]
#include <RPerl/DataType/Integer.cpp>
#include <RPerl/DataType/Number.cpp>
#include <RPerl/DataType/String.cpp>

// [[[ TYPEDEFS, 1D REPEATED ]]]
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
// [[[ TYPEDEFS ]]]
// [[[ TYPEDEFS ]]]

// [[[ ARRAY REF ARRAY REF ]]]
typedef std::vector<std::vector<integer>> integer_arrayref_arrayref;
typedef std::vector<std::vector<integer>>::iterator integer_arrayref_arrayref_iterator;
typedef std::vector<std::vector<integer>>::const_iterator integer_arrayref_arrayref_const_iterator;
typedef std::vector<std::vector<number>> number_arrayref_arrayref;
typedef std::vector<std::vector<number>>::iterator number_arrayref_arrayref_iterator;
typedef std::vector<std::vector<number>>::const_iterator number_arrayref_arrayref_const_iterator;
typedef std::vector<std::vector<string>> string_arrayref_arrayref;
typedef std::vector<std::vector<string>>::iterator string_arrayref_arrayref_iterator;
typedef std::vector<std::vector<string>>::const_iterator string_arrayref_arrayref_const_iterator;

// [[[ HASH REF ARRAY REF ]]]
typedef std::vector<std::unordered_map<string, integer>> integer_hashref_arrayref;
typedef std::vector<std::unordered_map<string, integer>>::iterator integer_hashref_arrayref_iterator;
typedef std::vector<std::unordered_map<string, integer>>::const_iterator integer_hashref_arrayref_const_iterator;
typedef std::vector<std::unordered_map<string, number>> number_hashref_arrayref;
typedef std::vector<std::unordered_map<string, number>>::iterator number_hashref_arrayref_iterator;
typedef std::vector<std::unordered_map<string, number>>::const_iterator number_hashref_arrayref_const_iterator;
typedef std::vector<std::unordered_map<string, string>> string_hashref_arrayref;
typedef std::vector<std::unordered_map<string, string>>::iterator string_hashref_arrayref_iterator;
typedef std::vector<std::unordered_map<string, string>>::const_iterator string_hashref_arrayref_const_iterator;

// [[[ TYPE-CHECKING SUBROUTINES ]]]
// [[[ TYPE-CHECKING SUBROUTINES ]]]
// [[[ TYPE-CHECKING SUBROUTINES ]]]

// [[[ ARRAY REF ARRAY REF ]]]
void integer_arrayref_arrayref_CHECK(SV* possible_integer_arrayref_arrayref);
void integer_arrayref_arrayref_CHECKTRACE(SV* possible_integer_arrayref_arrayref, const char* variable_name, const char* subroutine_name);
void number_arrayref_arrayref_CHECK(SV* possible_number_arrayref_arrayref);
void number_arrayref_arrayref_CHECKTRACE(SV* possible_number_arrayref_arrayref, const char* variable_name, const char* subroutine_name);
void string_arrayref_arrayref_CHECK(SV* possible_string_arrayref_arrayref);
void string_arrayref_arrayref_CHECKTRACE(SV* possible_string_arrayref_arrayref, const char* variable_name, const char* subroutine_name);

// [[[ HASH REF ARRAY REF ]]]
/* NEED IMPLEMENT IN SubTypes2D.cpp
void integer_hashref_arrayref_CHECK(SV* possible_integer_hashref_arrayref);
void integer_hashref_arrayref_CHECKTRACE(SV* possible_integer_hashref_arrayref, const char* variable_name, const char* subroutine_name);
void number_hashref_arrayref_CHECK(SV* possible_number_hashref_arrayref);
void number_hashref_arrayref_CHECKTRACE(SV* possible_number_hashref_arrayref, const char* variable_name, const char* subroutine_name);
void string_hashref_arrayref_CHECK(SV* possible_string_hashref_arrayref);
void string_hashref_arrayref_CHECKTRACE(SV* possible_string_hashref_arrayref, const char* variable_name, const char* subroutine_name);
*/

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__Array__SubTypes2D__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Array__SubTypes2D__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES
// [[[ ARRAY REF ARRAY REF ]]]
integer_arrayref_arrayref XS_unpack_integer_arrayref_arrayref(SV* input_avref_avref);
void XS_pack_integer_arrayref_arrayref(SV* output_avref_avref, integer_arrayref_arrayref input_vector_vector);
number_arrayref_arrayref XS_unpack_number_arrayref_arrayref(SV* input_avref_avref);
void XS_pack_number_arrayref_arrayref(SV* output_avref_avref, number_arrayref_arrayref input_vector_vector);
string_arrayref_arrayref XS_unpack_string_arrayref_arrayref(SV* input_avref_avref);
void XS_pack_string_arrayref_arrayref(SV* output_avref_avref, string_arrayref_arrayref input_vector_vector);

// [[[ HASH REF ARRAY REF ]]]
/* NEED IMPLEMENT IN SubTypes2D.cpp
integer_hashref_arrayref XS_unpack_integer_hashref_arrayref(SV* input_avref_avref);
void XS_pack_integer_hashref_arrayref(SV* output_avref_avref, integer_hashref_arrayref input_vector_vector);
number_hashref_arrayref XS_unpack_number_hashref_arrayref(SV* input_avref_avref);
void XS_pack_number_hashref_arrayref(SV* output_avref_avref, number_hashref_arrayref input_vector_vector);
string_hashref_arrayref XS_unpack_string_hashref_arrayref(SV* input_avref_avref);
void XS_pack_string_hashref_arrayref(SV* output_avref_avref, string_hashref_arrayref input_vector_vector);
*/
# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES
/* NEED IMPLEMENT IN SubTypes2D.cpp
// [[[ ARRAY REF ARRAY REF ]]]
SV* integer_arrayref_arrayref_to_string(SV* input_avref_avref);
SV* number_arrayref_arrayref_to_string(SV* input_avref_avref);
SV* string_arrayref_arrayref_to_string(SV* input_avref_avref);

// [[[ HASH REF ARRAY REF ]]]
SV* integer_hashref_arrayref_to_string(SV* input_hvref_avref);
SV* number_hashref_arrayref_to_string(SV* input_hvref_avref);
SV* string_hashref_arrayref_to_string(SV* input_hvref_avref);
*/
# elif defined __CPP__TYPES
/* NEED IMPLEMENT IN SubTypes2D.cpp
// [[[ ARRAY REF ARRAY REF ]]]
string integer_arrayref_arrayref_to_string(integer_arrayref_arrayref input_vector_vector);
string number_arrayref_arrayref_to_string(number_arrayref_arrayref input_vector_vector);
string string_arrayref_arrayref_to_string(string_arrayref_arrayref input_vector_vector);

// [[[ HASH REF ARRAY REF ]]]
string integer_hashref_arrayref_to_string(integer_hashref_arrayref input_unordered_map_vector);
string number_hashref_arrayref_to_string(number_hashref_arrayref input_unordered_map_vector);
string string_hashref_arrayref_to_string(string_hashref_arrayref input_unordered_map_vector);
*/
# endif

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES
/* NEED IMPLEMENT IN SubTypes2D.cpp
// [[[ ARRAY REF ARRAY REF ]]]
SV* integer_arrayref_arrayref_typetest0(SV* lucky_integers);
SV* integer_arrayref_arrayref_typetest1(SV* my_size);
SV* number_arrayref_arrayref_typetest0(SV* lucky_numbers);
SV* number_arrayref_arrayref_typetest1(SV* my_size);
SV* string_arrayref_arrayref_typetest0(SV* people);
SV* string_arrayref_arrayref_typetest1(SV* my_size);

// [[[ HASH REF ARRAY REF ]]]
SV* integer_hashref_arrayref_typetest0(SV* lucky_integers);
SV* integer_hashref_arrayref_typetest1(SV* my_size);
SV* number_hashref_arrayref_typetest0(SV* lucky_numbers);
SV* number_hashref_arrayref_typetest1(SV* my_size);
SV* string_hashref_arrayref_typetest0(SV* people);
SV* string_hashref_arrayref_typetest1(SV* my_size);
*/
# elif defined __CPP__TYPES
/* NEED IMPLEMENT IN SubTypes2D.cpp
// [[[ ARRAY REF ARRAY REF ]]]
string integer_arrayref_arrayref_typetest0(integer_arrayref_arrayref lucky_integers);
integer_arrayref_arrayref integer_arrayref_arrayref_typetest1(integer my_size);
string number_arrayref_arrayref_typetest0(number_arrayref_arrayref lucky_numbers);
number_arrayref_arrayref number_arrayref_arrayref_typetest1(integer my_size);
string string_arrayref_arrayref_typetest0(string_arrayref_arrayref people);
string_arrayref_arrayref string_arrayref_arrayref_typetest1(integer my_size);

// [[[ HASH REF ARRAY REF ]]]
string integer_hashref_arrayref_typetest0(integer_hashref_arrayref lucky_integers);
integer_hashref_arrayref integer_hashref_arrayref_typetest1(integer my_size);
string number_hashref_arrayref_typetest0(number_hashref_arrayref lucky_numbers);
number_hashref_arrayref number_hashref_arrayref_typetest1(integer my_size);
string string_hashref_arrayref_typetest0(string_hashref_arrayref people);
string_hashref_arrayref string_hashref_arrayref_typetest1(integer my_size);
*/
# endif

#endif

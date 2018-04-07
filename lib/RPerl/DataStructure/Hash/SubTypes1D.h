////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes1D_h
#define __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes1D_h 0.004_000

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ DATA TYPES ]]]
#include <RPerl/DataType/Integer.cpp>
#include <RPerl/DataType/Number.cpp>
#include <RPerl/DataType/String.cpp>

// [[[ TYPEDEFS ]]]
typedef std::unordered_map<string, integer> integer_hashref;
typedef std::unordered_map<string, integer>::iterator integer_hashref_iterator;
typedef std::unordered_map<string, integer>::const_iterator integer_hashref_const_iterator;
typedef std::unordered_map<string, number> number_hashref;
typedef std::unordered_map<string, number>::iterator number_hashref_iterator;
typedef std::unordered_map<string, number>::const_iterator number_hashref_const_iterator;
typedef std::unordered_map<string, string> string_hashref;
typedef std::unordered_map<string, string>::iterator string_hashref_iterator;
typedef std::unordered_map<string, string>::const_iterator string_hashref_const_iterator;

// [[[ TYPE-CHECKING SUBROUTINES ]]]
void integer_hashref_CHECK(SV* possible_integer_hashref);
void integer_hashref_CHECKTRACE(SV* possible_integer_hashref, const char* variable_name, const char* subroutine_name);
void number_hashref_CHECK(SV* possible_number_hashref);
void number_hashref_CHECKTRACE(SV* possible_number_hashref, const char* variable_name, const char* subroutine_name);
void string_hashref_CHECK(SV* possible_string_hashref);
void string_hashref_CHECKTRACE(SV* possible_string_hashref, const char* variable_name, const char* subroutine_name);

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__Hash__SubTypes1D__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Hash__SubTypes1D__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
integer_hashref XS_unpack_integer_hashref(SV* input_hvref);
void XS_pack_integer_hashref(SV* output_hvref, integer_hashref input_unordered_map);
number_hashref XS_unpack_number_hashref(SV* input_hvref);
void XS_pack_number_hashref(SV* output_hvref, number_hashref input_unordered_map);
string_hashref XS_unpack_string_hashref(SV* input_hvref);
void XS_pack_string_hashref(SV* output_hvref, string_hashref input_unordered_map);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* integer_hashref_to_string_compact(SV* input_hvref);
SV* integer_hashref_to_string(SV* input_hvref);
SV* integer_hashref_to_string_pretty(SV* input_hvref);
SV* integer_hashref_to_string_expand(SV* input_hvref);
SV* integer_hashref_to_string_format(SV* input_hvref, SV* format_level, SV* indent_level);
SV* number_hashref_to_string_compact(SV* input_hvref);
SV* number_hashref_to_string(SV* input_hvref);
SV* number_hashref_to_string_pretty(SV* input_hvref);
SV* number_hashref_to_string_expand(SV* input_hvref);
SV* number_hashref_to_string_format(SV* input_hvref, SV* format_level, SV* indent_level);
SV* string_hashref_to_string_compact(SV* input_hvref);
SV* string_hashref_to_string(SV* input_hvref);
SV* string_hashref_to_string_pretty(SV* input_hvref);
SV* string_hashref_to_string_expand(SV* input_hvref);
SV* string_hashref_to_string_format(SV* input_hvref, SV* format_level, SV* indent_level);
# elif defined __CPP__TYPES
string integer_hashref_to_string_compact(integer_hashref input_unordered_map);
string integer_hashref_to_string(integer_hashref input_unordered_map);
string integer_hashref_to_string_pretty(integer_hashref input_unordered_map);
string integer_hashref_to_string_expand(integer_hashref input_unordered_map);
string integer_hashref_to_string_format(integer_hashref input_unordered_map, integer format_level, integer indent_level);
string number_hashref_to_string_compact(number_hashref input_unordered_map);
string number_hashref_to_string(number_hashref input_unordered_map);
string number_hashref_to_string_pretty(number_hashref input_unordered_map);
string number_hashref_to_string_expand(number_hashref input_unordered_map);
string number_hashref_to_string_format(number_hashref input_unordered_map, integer format_level, integer indent_level);
string string_hashref_to_string_compact(string_hashref input_unordered_map);
string string_hashref_to_string(string_hashref input_unordered_map);
string string_hashref_to_string_pretty(string_hashref input_unordered_map);
string string_hashref_to_string_expand(string_hashref input_unordered_map);
string string_hashref_to_string_format(string_hashref input_unordered_map, integer format_level, integer indent_level);
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* integer_hashref_typetest0(SV* lucky_integers);
SV* integer_hashref_typetest1(SV* my_size);
SV* number_hashref_typetest0(SV* lucky_numbers);
SV* number_hashref_typetest1(SV* my_size);
SV* string_hashref_typetest0(SV* people);
SV* string_hashref_typetest1(SV* my_size);
# elif defined __CPP__TYPES
string integer_hashref_typetest0(integer_hashref lucky_integers);
integer_hashref integer_hashref_typetest1(integer my_size);
string number_hashref_typetest0(number_hashref lucky_numbers);
number_hashref number_hashref_typetest1(integer my_size);
string string_hashref_typetest0(string_hashref people);
string_hashref string_hashref_typetest1(integer my_size);
# endif

#endif

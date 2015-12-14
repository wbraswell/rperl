////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array_h
#define __CPP__INCLUDED__RPerl__DataStructure__Array_h 0.004_020

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

//// [[[ DATA TYPES ]]]
////use RPerl::DataType::Integer;
#include <RPerl/DataType/Integer.cpp>
////use RPerl::DataType::Number;
#include <RPerl/DataType/Number.cpp>
////use RPerl::DataType::String;
#include <RPerl/DataType/String.cpp>
////use RPerl::DataType::Scalar;
////use RPerl::DataType::Unknown;

// [[[ GENERAL MACROS ]]]
#define VECTOR_RESIZE_NOSHRINK(my_vector, my_size) ((my_vector.size() < my_size) ? my_vector.resize((size_t)(my_size)) : (void)0)  // do grow but don't shrink

// [[[ TYPE-CHECKING MACROS ]]]
#define arrayref_CHECK(possible_arrayref) \
	(not(SvOK(possible_arrayref)) ? \
			croak("\nERROR EAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\narrayref value expected but undefined/null value found,\ncroaking") : \
			(not(SvAROKp(possible_arrayref)) ? \
					croak("\nERROR EAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\narrayref value expected but non-arrayref value found,\ncroaking") : \
					(void)0))
#define arrayref_CHECKTRACE(possible_arrayref, variable_name, subroutine_name) \
	(not(SvOK(possible_arrayref)) ? \
			croak("\nERROR EAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\narrayref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvAROKp(possible_arrayref)) ? \
					croak("\nERROR EAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\narrayref value expected but non-arrayref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ TYPEDEFS ]]]
typedef std::vector<integer> integer_arrayref;
typedef std::vector<integer>::iterator integer_arrayref_iterator;
typedef std::vector<integer>::const_iterator integer_arrayref_const_iterator;
typedef std::vector<number> number_arrayref;
typedef std::vector<number>::iterator number_arrayref_iterator;
typedef std::vector<number>::const_iterator number_arrayref_const_iterator;
typedef std::vector<string> string_arrayref;
typedef std::vector<string>::iterator string_arrayref_iterator;
typedef std::vector<string>::const_iterator string_arrayref_const_iterator;

// [[[ TYPE-CHECKING SUBROUTINES ]]]
void integer_arrayref_CHECK(SV* possible_integer_arrayref);
void integer_arrayref_CHECKTRACE(SV* possible_integer_arrayref, const char* variable_name, const char* subroutine_name);
void number_arrayref_CHECK(SV* possible_number_arrayref);
void number_arrayref_CHECKTRACE(SV* possible_number_arrayref, const char* variable_name, const char* subroutine_name);
void string_arrayref_CHECK(SV* possible_string_arrayref);
void string_arrayref_CHECKTRACE(SV* possible_string_arrayref, const char* variable_name, const char* subroutine_name);

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__Array__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Array__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
integer_arrayref XS_unpack_integer_arrayref(SV* input_av_ref);
void XS_pack_integer_arrayref(SV* output_av_ref, integer_arrayref input_vector);
number_arrayref XS_unpack_number_arrayref(SV* input_av_ref);
void XS_pack_number_arrayref(SV* output_av_ref, number_arrayref input_vector);
string_arrayref XS_unpack_string_arrayref(SV* input_av_ref);
void XS_pack_string_arrayref(SV* output_av_ref, string_arrayref input_vector);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
//void integer_arrayref_to_string(SV* input_av_ref);
SV* integer_arrayref_to_string(SV* input_av_ref);
SV* number_arrayref_to_string(SV* input_av_ref);
SV* string_arrayref_to_string(SV* input_av_ref);
# elif defined __CPP__TYPES
string integer_arrayref_to_string(integer_arrayref input_vector);
string number_arrayref_to_string(number_arrayref input_vector);
string string_arrayref_to_string(string_arrayref input_vector);
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
//void integer_arrayref__typetest0(SV* lucky_integers);
SV* integer_arrayref__typetest0(SV* lucky_integers);
//void integer_arrayref__typetest1(SV* my_size);
SV* integer_arrayref__typetest1(SV* my_size);
SV* number_arrayref__typetest0(SV* lucky_numbers);
SV* number_arrayref__typetest1(SV* my_size);
SV* string_arrayref__typetest0(SV* people);
SV* string_arrayref__typetest1(SV* my_size);
# elif defined __CPP__TYPES
string integer_arrayref__typetest0(integer_arrayref lucky_integers);
integer_arrayref integer_arrayref__typetest1(integer my_size);
string number_arrayref__typetest0(number_arrayref lucky_numbers);
number_arrayref number_arrayref__typetest1(integer my_size);
string string_arrayref__typetest0(string_arrayref people);
string_arrayref string_arrayref__typetest1(integer my_size);
# endif

#endif

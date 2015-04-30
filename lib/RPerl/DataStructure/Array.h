////use strict;  use warnings;
using std::cout;  using std::cerr;

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
#define array_ref__CHECK(possible_array_ref) \
	(not(SvOK(possible_array_ref)) ? \
			croak("\nERROR EAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\narray_ref value expected but undefined/null value found,\ncroaking") : \
			(not(SvAROKp(possible_array_ref)) ? \
					croak("\nERROR EAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\narray_ref value expected but non-array_ref value found,\ncroaking") : \
					(void)0))
#define array_ref__CHECKTRACE(possible_array_ref, variable_name, subroutine_name) \
	(not(SvOK(possible_array_ref)) ? \
			croak("\nERROR EAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\narray_ref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvAROKp(possible_array_ref)) ? \
					croak("\nERROR EAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\narray_ref value expected but non-array_ref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ TYPEDEFS ]]]
typedef std::vector<integer> integer__array_ref;
typedef std::vector<integer>::iterator integer__array_ref__iterator;
typedef std::vector<integer>::const_iterator integer__array_ref__const_iterator;
typedef std::vector<number> number__array_ref;
typedef std::vector<number>::iterator number__array_ref__iterator;
typedef std::vector<number>::const_iterator number__array_ref__const_iterator;
typedef std::vector<string> string__array_ref;
typedef std::vector<string>::iterator string__array_ref__iterator;
typedef std::vector<string>::const_iterator string__array_ref__const_iterator;

// [[[ TYPE-CHECKING SUBROUTINES ]]]
void integer__array_ref__CHECK(SV* possible_integer__array_ref);
void integer__array_ref__CHECKTRACE(SV* possible_integer__array_ref, const char* variable_name, const char* subroutine_name);
void number__array_ref__CHECK(SV* possible_number__array_ref);
void number__array_ref__CHECKTRACE(SV* possible_number__array_ref, const char* variable_name, const char* subroutine_name);
void string__array_ref__CHECK(SV* possible_string__array_ref);
void string__array_ref__CHECKTRACE(SV* possible_string__array_ref, const char* variable_name, const char* subroutine_name);

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__Array__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Array__MODE_ID() { integer retval = 2;  return(retval); }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
integer__array_ref XS_unpack_integer__array_ref(SV* input_av_ref);
void XS_pack_integer__array_ref(SV* output_av_ref, integer__array_ref input_vector);
number__array_ref XS_unpack_number__array_ref(SV* input_av_ref);
void XS_pack_number__array_ref(SV* output_av_ref, number__array_ref input_vector);
string__array_ref XS_unpack_string__array_ref(SV* input_av_ref);
void XS_pack_string__array_ref(SV* output_av_ref, string__array_ref input_vector);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
//void integer__array_ref__to_string(SV* input_av_ref);
SV* integer__array_ref__to_string(SV* input_av_ref);
SV* number__array_ref__to_string(SV* input_av_ref);
SV* string__array_ref__to_string(SV* input_av_ref);
# elif defined __CPP__TYPES
string integer__array_ref__to_string(integer__array_ref input_vector);
string number__array_ref__to_string(number__array_ref input_vector);
string string__array_ref__to_string(string__array_ref input_vector);
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
//void integer__array_ref__typetest0(SV* lucky_integers);
SV* integer__array_ref__typetest0(SV* lucky_integers);
//void integer__array_ref__typetest1(SV* my_size);
SV* integer__array_ref__typetest1(SV* my_size);
SV* number__array_ref__typetest0(SV* lucky_numbers);
SV* number__array_ref__typetest1(SV* my_size);
SV* string__array_ref__typetest0(SV* people);
SV* string__array_ref__typetest1(SV* my_size);
# elif defined __CPP__TYPES
string integer__array_ref__typetest0(integer__array_ref lucky_integers);
integer__array_ref integer__array_ref__typetest1(integer my_size);
string number__array_ref__typetest0(number__array_ref lucky_numbers);
number__array_ref number__array_ref__typetest1(integer my_size);
string string__array_ref__typetest0(string__array_ref people);
string__array_ref string__array_ref__typetest1(integer my_size);
# endif

#endif

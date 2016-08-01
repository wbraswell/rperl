////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash_h
#define __CPP__INCLUDED__RPerl__DataStructure__Hash_h 0.004_100

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ DATA TYPES ]]]
#include <RPerl/DataType/Integer.cpp>
#include <RPerl/DataType/Number.cpp>
#include <RPerl/DataType/String.cpp>

// [[[ TYPE-CHECKING MACROS ]]]
#define hashref_CHECK(possible_hashref) \
	(not(SvOK(possible_hashref)) ? \
			croak("\nERROR EHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashref value expected but undefined/null value found,\ncroaking") : \
			(not(SvHROKp(possible_hashref)) ? \
					croak("\nERROR EHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashref value expected but non-hashref value found,\ncroaking") : \
					(void)0))
#define hashref_CHECKTRACE(possible_hashref, variable_name, subroutine_name) \
	(not(SvOK(possible_hashref)) ? \
			croak("\nERROR EHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvHROKp(possible_hashref)) ? \
					croak("\nERROR EHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashref value expected but non-hashref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))
#define hashentry_CHECK(possible_hashentry) \
	((possible_hashentry == NULL) ? \
			croak("\nERROR EHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashentry value expected but undefined/null value found,\ncroaking") : \
					(void)0)
#define hashentry_CHECKTRACE(possible_hashentry, variable_name, subroutine_name) \
	((possible_hashentry == NULL) ? \
			croak("\nERROR EHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashentry value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0)

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
SV* RPerl__DataStructure__Hash__MODE_ID(pTHX) { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Hash__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
integer_hashref XS_unpack_integer_hashref(pTHX_ SV* input_hv_ref);
void XS_pack_integer_hashref(pTHX_ SV* output_hv_ref, integer_hashref input_unordered_map);
number_hashref XS_unpack_number_hashref(pTHX_ SV* input_hv_ref);
void XS_pack_number_hashref(pTHX_ SV* output_hv_ref, number_hashref input_unordered_map);
string_hashref XS_unpack_string_hashref(pTHX_ SV* input_hv_ref);
void XS_pack_string_hashref(pTHX_ SV* output_hv_ref, string_hashref input_unordered_map);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* integer_hashref_to_string(SV* input_hv_ref);
SV* number_hashref_to_string(SV* input_hv_ref);
SV* string_hashref_to_string(SV* input_hv_ref);
# elif defined __CPP__TYPES
string integer_hashref_to_string(integer_hashref input_unordered_map);
string number_hashref_to_string(number_hashref input_unordered_map);
string string_hashref_to_string(string_hashref input_unordered_map);
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* integer_hashref__typetest0(SV* lucky_integers);
SV* integer_hashref__typetest1(SV* my_size);
SV* number_hashref__typetest0(SV* lucky_numbers);
SV* number_hashref__typetest1(SV* my_size);
SV* string_hashref__typetest0(SV* people);
SV* string_hashref__typetest1(SV* my_size);
# elif defined __CPP__TYPES
string integer_hashref__typetest0(integer_hashref lucky_integers);
integer_hashref integer_hashref__typetest1(integer my_size);
string number_hashref__typetest0(number_hashref lucky_numbers);
number_hashref number_hashref__typetest1(integer my_size);
string string_hashref__typetest0(string_hashref people);
string_hashref string_hashref__typetest1(integer my_size);
# endif

#endif

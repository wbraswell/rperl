////use strict;  use warnings;
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__DataType__Integer_h
#define __CPP__INCLUDED__RPerl__DataType__Integer_h 0.003_050

// [[[ TYPEDEFS ]]]
// DEV NOTE: must use "integer" typedef because "int" is already defined by Inline's default typemap, even if we put our own integer entry into typemap.rperl;
// if we allow Inline default int, then it will accept all kinds of non-integer values which should be filtered by XS_unpack_integer() and CHECK();
// must be above String.cpp include, as String.cpp uses integer type for it's own *MODE_ID() subroutines [OVERRIDDEN BY DEV NOTE BELOW]
typedef int integer;

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES
// DEV NOTE: basic data types must be wholly independent of one another, to avoid weird redefining or undefining of subroutine errors
//#include <RPerl/DataType/String.cpp>  // string types used in stringify_*() subroutines

// [[[ TYPE-CHECKING MACROS ]]]
#define integer_CHECK(possible_integer) \
	(not(SvOK(possible_integer)) ? \
			croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found,\ncroaking") : \
			(not(SvIOKp(possible_integer)) ? \
					croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found,\ncroaking") : \
					(void)0))
#define integer_CHECKTRACE(possible_integer, variable_name, subroutine_name) \
	(not(SvOK(possible_integer)) ? \
			croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvIOKp(possible_integer)) ? \
					croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ TYPE-CHECKING SUBROUTINES ]]]
// DEPRECATED, SEE MACROS ABOVE
//void integer_CHECK(SV* possible_integer);
//void integer_CHECKTRACE(SV* possible_integer, const char* variable_name, const char* subroutine_name);

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataType__Integer__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataType__Integer__MODE_ID() { integer retval = 2;  return(retval); }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
integer XS_unpack_integer(SV* input_sv);
void XS_pack_integer(SV* output_sv, integer input_integer);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* integer_to_string(SV* input_integer);
# elif defined __CPP__TYPES
//string integer_to_string(integer input_integer);
std::string integer_to_string(integer input_integer);
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* integer__typetest0();
SV* integer__typetest1(SV* lucky_integer);
# elif defined __CPP__TYPES
integer integer__typetest0();
integer integer__typetest1(integer lucky_integer);
# endif

#endif

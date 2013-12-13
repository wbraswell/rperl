////use strict;  use warnings;
using std::cout;  using std::endl;

// VERSION 0.2.3

#ifndef __CPP__INCLUDED__RPerl__DataType__Integer_h
#define __CPP__INCLUDED__RPerl__DataType__Integer_h 1

// [[[ TYPE-CHECKING MACROS ]]]
#define CHECK_INTEGER(possible_integer) \
	(not(SvOK(possible_integer)) ? \
			croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found,\ncroaking") : \
			(not(SvIOKp(possible_integer)) ? \
					croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found,\ncroaking") : \
					(void)0))
#define CHECK_TRACE_INTEGER(possible_integer, variable_name, subroutine_name) \
	(not(SvOK(possible_integer)) ? \
			croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name) : \
			(not(SvIOKp(possible_integer)) ? \
					croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ TYPEDEFS ]]]
// DEV NOTE: must use "integer" because "int" is already defined by Inline's default typemap, even if we put our own integer entry into typemap.rperl;
// if we allow Inline default int, then it will accept all kinds of non-integer values which should be filtered by XS_unpack_integer() and check_integer()
typedef int integer;

#include <types.h> // for definitions of __PERL__TYPES or __CPP__TYPES
#include <RPerl/DataType/String.cpp>  // need for string typedef

// [[[ TYPE-CHECKING ]]]
// DEPRECATED, SEE MACROS ABOVE
//void check_integer(SV* possible_integer);
//void check_trace_integer(SV* possible_integer, const char* variable_name, const char* subroutine_name);

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
integer XS_unpack_integer(SV* input_sv);
void XS_pack_integer(SV* output_sv, integer input_integer);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* stringify_integer(SV* input_integer);
# elif defined __CPP__TYPES
string stringify_integer(integer input_integer);
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# ifdef __PERL__TYPES
# define OPS_TYPES_ID 1 // CPPOPS_PERLTYPES is 1
SV* ops_integer() { return(newSVpv("CPP", 3)); }
SV* types_integer() { return(newSVpv("PERL", 4)); }
# elif defined __CPP__TYPES
# define OPS_TYPES_ID 2 // CPPOPS_CPPTYPES is 2
string ops_integer() { string retval = "CPP";  return(retval); }
string types_integer() { string retval = "CPP";  return(retval); }
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* typetest___void__in___integer__out();
SV* typetest___integer__in___integer__out(SV* lucky_integer);
# elif defined __CPP__TYPES
integer typetest___void__in___integer__out();
integer typetest___integer__in___integer__out(integer lucky_integer);
# endif

#endif

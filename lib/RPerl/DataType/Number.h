////use strict;  use warnings;
using std::cout;  using std::endl;

// VERSION 0.2.3

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_h
#define __CPP__INCLUDED__RPerl__DataType__Number_h 1

// [[[ TYPE-CHECKING MACROS ]]]
#define CHECK_NUMBER(possible_number) \
	(not(SvOK(possible_number)) ? \
			croak("\nERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\ncroaking") : \
			(not(SvNOKp(possible_number) || SvIOKp(possible_number)) ? \
					croak("\nERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\ncroaking") : \
					(void)0))
#define CHECK_TRACE_NUMBER(possible_number, variable_name, subroutine_name) \
	(not(SvOK(possible_number)) ? \
			croak("\nERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name) : \
			(not(SvNOKp(possible_number) || SvIOKp(possible_number)) ? \
					croak("\nERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ TYPEDEFS ]]]
typedef long double number;

#include <types.h> // for definitions of __PERL__TYPES or __CPP__TYPES
#include <RPerl/DataType/String.cpp>  // need for string typedef

// [[[ TYPE-CHECKING ]]]
// DEPRECATED, SEE MACROS ABOVE
//void check_number(SV* possible_number);
//void check_trace_number(SV* possible_number, const char* variable_name, const char* subroutine_name);

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
number XS_unpack_number(SV* input_sv);
void XS_pack_number(SV* output_sv, number input_number);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* stringify_number(SV* input_number);
# elif defined __CPP__TYPES
string stringify_number(number input_number);
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# ifdef __PERL__TYPES
# define OPS_TYPES_ID 1 // CPPOPS_PERLTYPES is 1
SV* ops_number() { return(newSVpv("CPP", 3)); }
SV* types_number() { return(newSVpv("PERL", 4)); }
# elif defined __CPP__TYPES
# define OPS_TYPES_ID 2 // CPPOPS_CPPTYPES is 2
string ops_number() { string retval = "CPP";  return(retval); }
string types_number() { string retval = "CPP";  return(retval); }
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* typetest___void__in___number__out();
SV* typetest___number__in___number__out(SV* lucky_number);
# elif defined __CPP__TYPES
number typetest___void__in___number__out();
number typetest___number__in___number__out(number lucky_number);
# endif

#endif

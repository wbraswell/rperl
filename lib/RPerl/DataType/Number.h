////use strict;  use warnings;
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_h
#define __CPP__INCLUDED__RPerl__DataType__Number_h 0.003002

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES
#include <RPerl/DataType/String.cpp>  // string types used in stringify_*() subroutines

// [[[ TYPE-CHECKING MACROS ]]]
#define number__CHECK(possible_number) \
	(not(SvOK(possible_number)) ? \
			croak("\nERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\ncroaking") : \
			(not(SvNOKp(possible_number) || SvIOKp(possible_number)) ? \
					croak("\nERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\ncroaking") : \
					(void)0))
#define number__CHECKTRACE(possible_number, variable_name, subroutine_name) \
	(not(SvOK(possible_number)) ? \
			croak("\nERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvNOKp(possible_number) || SvIOKp(possible_number)) ? \
					croak("\nERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ TYPE-CHECKING ]]]
// DEPRECATED, SEE MACROS ABOVE
//void number__CHECK(SV* possible_number);
//void number__CHECKTRACE(SV* possible_number, const char* variable_name, const char* subroutine_name);

// [[[ TYPEDEFS ]]]
typedef long double number;

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# ifdef __PERL__TYPES
# define number__OPS_TYPES_ID 1 // CPPOPS_PERLTYPES is 1
SV* number__ops() { return(newSVpv("CPP", 3)); }
SV* number__types() { return(newSVpv("PERL", 4)); }
# elif defined __CPP__TYPES
# define number__OPS_TYPES_ID 2 // CPPOPS_CPPTYPES is 2
string number__ops() { string retval = "CPP";  return(retval); }
string number__types() { string retval = "CPP";  return(retval); }
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
number XS_unpack_number(SV* input_sv);
void XS_pack_number(SV* output_sv, number input_number);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* number__stringify(SV* input_number);
# elif defined __CPP__TYPES
string number__stringify(number input_number);
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* number__typetest0();
SV* number__typetest1(SV* lucky_number);
# elif defined __CPP__TYPES
number number__typetest0();
number number__typetest1(number lucky_number);
# endif

#endif

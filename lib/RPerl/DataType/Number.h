////use strict;  use warnings;
using std::cout;  using std::endl;

// VERSION 0.2.1

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_h
#define __CPP__INCLUDED__RPerl__DataType__Number_h 1

// [[[ TYPEDEFS ]]]
typedef long double number;

#include <types.h> // for definitions of __PERL__TYPES or __CPP__TYPES
#include <RPerl/DataType/String.cpp>  // for stringify()

// [[[ TYPE CHECKING ]]]
void check_number(SV* possible_number);

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

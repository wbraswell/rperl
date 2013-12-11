////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Integer_h
#define __CPP__INCLUDED__RPerl__DataType__Integer_h 1

// [[[ TYPEDEFS FOR RPERL-TYPES-IN-C ]]]
// DEV NOTE: must use "integer" because "integer" defined by Inline's default typemap, even if we put our own integer entry integero typemap.rperl;
// if we allow Inline default integer, then it will accept all kinds of non-integer values which should be filtered by XS_unpack_integer()
typedef int integer;

#include <types.h> // for definitions of __PERL__TYPES or __CPP__TYPES
#include <RPerl/DataType/String.cpp>  // for stringify()

// [[[ TYPE CHECKING ]]]
void check_integer(SV* possible_integer);

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

// [[[ DATA TYPES & OPERATIONS ]]]
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

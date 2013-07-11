////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_h
#define __CPP__INCLUDED__RPerl__DataType__Number_h 1

// [[[ TYPEDEFS FOR RPERL-TYPES-IN-C ]]]
typedef long double number;

#include <types.h> // for definitions of __PERL__TYPES or __CPP__TYPES
#include <RPerl/DataType/String.cpp>  // for stringify()

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* stringify_number(SV* input_number);
# elif defined __CPP__TYPES
string stringify_number(number input_number);
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ DATA TYPES & OPERATIONS ]]]
# ifdef __PERL__TYPES
SV* types_number() { return(newSVpv("PERL", 4)); }
SV* ops_number() { return(newSVpv("CPP", 3)); }
# elif defined __CPP__TYPES
string types_number() { string retval = "CPP";  return(retval); }
string ops_number() { string retval = "CPP";  return(retval); }
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

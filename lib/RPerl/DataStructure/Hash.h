////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash_h
#define __CPP__INCLUDED__RPerl__DataStructure__Hash_h 0.009_000

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// [[[ SUB-TYPES BEFORE INCLUDES ]]]
#include <RPerl/DataStructure/Hash/SubTypes.cpp>   // -> SubTypes.h
#include <RPerl/DataStructure/Hash/SubTypes1D.cpp> // -> SubTypes1D.h
#include <RPerl/DataStructure/Hash/SubTypes2D.cpp> // -> SubTypes2D.h
#include <RPerl/DataStructure/Hash/SubTypes3D.cpp> // -> SubTypes3D.h

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__Hash__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Hash__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

#endif

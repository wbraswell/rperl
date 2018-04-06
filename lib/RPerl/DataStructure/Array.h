////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array_h
#define __CPP__INCLUDED__RPerl__DataStructure__Array_h 0.008_000

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// [[[ SUB-TYPES BEFORE INCLUDES ]]]
#include <RPerl/DataStructure/Array/SubTypes.cpp>	// -> SubTypes.h
#include <RPerl/DataStructure/Array/SubTypes1D.cpp>	// -> SubTypes1D.h
#include <RPerl/DataStructure/Array/SubTypes2D.cpp>	// -> SubTypes2D.h
#include <RPerl/DataStructure/Array/SubTypes3D.cpp>	// -> SubTypes3D.h

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ GENERAL MACROS ]]]
#define VECTOR_RESIZE_NOSHRINK(my_vector, my_size) ((my_vector.size() < my_size) ? my_vector.resize((size_t)(my_size)) : (void)0)  // do grow but don't shrink

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__Array__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Array__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

#endif

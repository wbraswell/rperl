// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl_h
#define __CPP__INCLUDED__RPerl_h 0.002_000

// [[[ INCLUDES ]]]
#include <rperltypes_mode.h>  // for default definitions of __PERL__TYPES or __CPP__TYPES
#include <rperloperations.h>  // for operations
#include <rperltypes.h>  // for data types and structures
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

// [[[ SUBROUTINES, EARLY ]]]
int RPerl__diag(SV* message);

// [[[ OO INHERITANCE ]]]
class RPerl {  // no inheritance
public:
// [[[ OO METHODS ]]]
    // DEV NOTE: 'static' keyword with early-declared & separately-defined RPerl__diag() allows calling RPerl::diag() in C++
    static int diag(SV* message) { return RPerl__diag(message); };
};

// [[[ SUBROUTINES ]]]

// <<< OPERATIONS & DATA TYPES REPORTER >>>
SV* RPerl__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ SUBROUTINES, EARLY ]]]
integer RPerl__diag(string message);
integer RPerl__verbose(string message);
integer RPerl__warning(string message);

// [[[ OO INHERITANCE ]]]
class RPerl {  // no inheritance
public:
// [[[ OO METHODS ]]]
    // DEV NOTE: 'static' keyword with early-declared & separately-defined RPerl__*() allows calling RPerl::*() in C++
    static integer diag(string message) { return RPerl__diag(message); };
    static integer verbose(string message) { return RPerl__verbose(message); };
    static integer warning(string message) { return RPerl__warning(message); };
};

// [[[ OO CLASS PROPERTIES SPECIAL ]]]

// DEV NOTE, CORRELATION #rp032: NEED UPGRADE: properly determine whether to use DBL_EPSILON or FLT_EPSILON below
#define RPerl__EPSILON DBL_EPSILON
//#define RPerl__EPSILON FLT_EPSILON

// [[[ SUBROUTINES ]]]

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer RPerl__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

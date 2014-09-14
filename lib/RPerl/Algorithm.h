////# [[[ HEADER ]]]
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm_h
#define __CPP__INCLUDED__RPerl__Algorithm_h 0.004_011

////# [[[ INCLUDES ]]]
#include <rperltypes_mode.h>  // for definitions of __PERL__TYPES or __CPP__TYPES
#include <rperltypes.h>  // for data types and structures

#include <RPerl/HelperFunctions.cpp>        // -> HelperFunctions.h

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

////# [[[ OO INHERITANCE ]]]
////package RPerl::Algorithm;
////use parent qw(RPerl::CompileUnit::Module::Class); # no non-system inheritance, RPerl::CompileUnit::Module::Class is the base class of all RPerl classes
class RPerl__Algorithm  // no inheritance
{
public:
    ////# [[[ OO METHODS ]]]

    // INHERITANCE TESTING
        void inherited__Algorithm(SV* person);
//      void inherited(SV* person);

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    RPerl__Algorithm() {}
    ~RPerl__Algorithm() {}

////# [[[ OO PROPERTIES ]]]

//private:
    // no properties
};

////# [[[ SUBROUTINES ]]]

// INHERITANCE TESTING, CONTINUED
SV* uninherited__Algorithm(SV* person);
//SV* uninherited(SV* person);

// <<< OPERATIONS & DATA TYPES REPORTING >>>
SV* RPerl__Algorithm__OPS_TYPES_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES IS 1
SV* RPerl__Algorithm__ops() { return(newSVpv("CPP", 3)); }
SV* RPerl__Algorithm__types() { return(newSVpv("PERL", 4)); }

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

////# [[[ OO INHERITANCE ]]]
////package RPerl::Algorithm;
////use parent qw(RPerl::CompileUnit::Module::Class); # no non-system inheritance, RPerl::CompileUnit::Module::Class is the base class of all RPerl classes
class RPerl__Algorithm  // no inheritance
{
public:
    ////# [[[ OO METHODS ]]]

    // INHERITANCE TESTING
        void inherited__Algorithm(string person);
//      void inherited(string person);

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    RPerl__Algorithm() {}
    ~RPerl__Algorithm() {}

    ////# [[[ OO PROPERTIES ]]]

//private:
    // no properties
};

////# [[[ SUBROUTINES ]]]

// INHERITANCE TESTING, CONTINUED
string uninherited__Algorithm(string person);
//string uninherited(string person);

// <<< OPERATIONS & DATA TYPES REPORTING >>>
integer RPerl__Algorithm__OPS_TYPES_ID() { integer retval = 1;  return(retval); }  // CPPOPS_PERLTYPES IS 1
string RPerl__Algorithm__ops() { string retval = "CPP";  return(retval); }
string RPerl__Algorithm__types() { string retval = "CPP";  return(retval); }

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

//	void CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW() {}

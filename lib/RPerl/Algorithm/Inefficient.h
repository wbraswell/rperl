using std::cout;
using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Inefficient_h
#define __CPP__INCLUDED__RPerl__Algorithm__Inefficient_h 0.003_040

#include <rperltypes_mode.h>  // for definitions of __PERL__TYPES or __CPP__TYPES
#include <rperltypes.h>  // for data types and structures

#include <RPerl/HelperFunctions.cpp>		// -> HelperFunctions.h

////use RPerl::Algorithm;
#include <RPerl/Algorithm.cpp>		// -> Algorithm.h

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

////# [[[ PROCEDURAL SUBROUTINES ]]]
////# [[[ PROCEDURAL SUBROUTINES ]]]
////# [[[ PROCEDURAL SUBROUTINES ]]]

// [[[ INHERITANCE TESTING ]]]
SV* uninherited__Inefficient(SV* person);

// DEV NOTE, CORRELATION #04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
//SV* uninherited(SV* person);

////package RPerl::Algorithm::Inefficient;
////our @ISA = ('RPerl::Algorithm');
class CPP__RPerl__Algorithm__Inefficient : public CPP__RPerl__Algorithm
{
public:
    ////# [[[ OO METHODS ]]]
    ////# [[[ OO METHODS ]]]
    ////# [[[ OO METHODS ]]]

// [[[ INHERITANCE TESTING ]]]
    void inherited__Inefficient(SV* person);
    void inherited(SV* person);

    // <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
    // NONE
    void CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW() {}
    // <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
    CPP__RPerl__Algorithm__Inefficient() {}
    ~CPP__RPerl__Algorithm__Inefficient() {}

////# [[[ OO PROPERTIES ]]]
////# [[[ OO PROPERTIES ]]]
////# [[[ OO PROPERTIES ]]]

//private:
    // NONE
};

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

////# [[[ PROCEDURAL SUBROUTINES ]]]
////# [[[ PROCEDURAL SUBROUTINES ]]]
////# [[[ PROCEDURAL SUBROUTINES ]]]

// [[[ INHERITANCE TESTING ]]]
string uninherited__Inefficient(string person);

// DEV NOTE, CORRELATION #04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
//string uninherited(string person);

////package RPerl::Algorithm::Inefficient;
////our @ISA = ('RPerl::Algorithm');
class CPP__RPerl__Algorithm__Inefficient: public CPP__RPerl__Algorithm {
public:
    ////# [[[ OO METHODS ]]]
    ////# [[[ OO METHODS ]]]
    ////# [[[ OO METHODS ]]]

// [[[ INHERITANCE TESTING ]]]
    void inherited__Inefficient(string person);
    void inherited(string person);

    // <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
    // NONE
    void CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW() {
    }
    // <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
    CPP__RPerl__Algorithm__Inefficient() {
    }
    ~CPP__RPerl__Algorithm__Inefficient() {
    }

////# [[[ OO PROPERTIES ]]]
////# [[[ OO PROPERTIES ]]]
////# [[[ OO PROPERTIES ]]]

//private:
    // NONE
};

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

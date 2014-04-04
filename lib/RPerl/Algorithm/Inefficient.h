////use strict;  use warnings;
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Inefficient_h
#define __CPP__INCLUDED__RPerl__Algorithm__Inefficient_h 1

#include <RPerl/HelperFunctions.cpp>		// -> HelperFunctions.h

////use RPerl::Algorithm;
#include <RPerl/Algorithm.cpp>		// -> Algorithm.h

// <<< TRANSLATED FUNCTION DECLARATIONS >>>
// [[[ INHERITANCE TESTING ]]]
SV* uninherited__Inefficient(SV* person);
//SV* uninherited(SV* person);  // PERL_TYPES
//char *uninherited(char *person);  // CPP_TYPES
//void uninherited__string_array_in(char **people);  // CPP_TYPES


////package RPerl::Algorithm::Inefficient;
////our @ISA = ('RPerl::Algorithm');
class CPP__RPerl__Algorithm__Inefficient : public CPP__RPerl__Algorithm
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
// [[[ INHERITANCE TESTING ]]]
	void inherited__Inefficient(SV* person);
	void inherited(SV* person);

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
	// NONE
	void CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW() {}
	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	CPP__RPerl__Algorithm__Inefficient() {}
	~CPP__RPerl__Algorithm__Inefficient() {}

//private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
	// NONE
};

#endif

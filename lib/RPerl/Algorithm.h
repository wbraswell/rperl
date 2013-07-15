////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__Algorithm_h
#define __CPP__INCLUDED__RPerl__Algorithm_h 1

#include <RPerl/HelperFunctions.cpp>		// -> HelperFunctions.h

////use RPerl::Class; use RPerl; # the base classes that directly call "use RPerl::Class;" also need to "use RPerl;" to get "use types;", etc.
//#include <RPerl/Class.cpp>
//#include <RPerl.cpp>

// <<< TRANSLATED FUNCTION DECLARATIONS >>>
// [[[ INHERITANCE TESTING ]]]
SV *uninherited__Algorithm(SV *person);
//SV *uninherited(SV *person);  // PERL_TYPES
char *uninherited(char *person);  // CPP_TYPES

////package RPerl::Algorithm;
////our @ISA = ('RPerl::Class');
//class CPP__RPerl__Algorithm : public CPP__RPerl__Class
class CPP__RPerl__Algorithm
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
// [[[ INHERITANCE TESTING ]]]
	void inherited__Algorithm(SV *person);
//	void inherited(SV *person);

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
	// NONE
	void CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW();
	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	CPP__RPerl__Algorithm() {}
	~CPP__RPerl__Algorithm() {}

//private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
	// NONE
};

#endif

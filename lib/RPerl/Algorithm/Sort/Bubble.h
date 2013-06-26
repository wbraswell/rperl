////use strict;  use warnings;
using std::cout;  using std::endl;

#include "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c"		// -> HelperFunctions.h

////use RPerl::Algorithm::Sort;
#include "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort.cpp"			// -> Sort.h
//	#include <RPerl/Algorithm/Sort.cpp>

////use RPerl::Algorithm::Inefficient;
//#include "/tmp/RPerl-latest/lib/RPerl/Algorithm/Inefficient.cpp"			// -> Inefficient.h
//	#include <RPerl/Algorithm/Inefficient.cpp>

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_h

// <<< TRANSLATED FUNCTION DECLARATIONS >>>
SV *bubblesort(SV *data);
// [[[ INHERITANCE TESTING ]]]
SV *uninherited__Bubble(SV *person);
//SV *uninherited(SV *person);  // PERL_TYPES
//char *uninherited(char *person);  // CPP_TYPES

// DEV NOTE, CORRELATION #01: multiple inheritance is enabled by _either_ C++ here or Perl at correlation in Bubble_cpp.pm
//class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort  // SINGLE INHERITANCE
class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort, public CPP__RPerl__Algorithm__Inefficient  // MULTIPLE INHERITANCE
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void sort();  // NEED ANSWER: no named argument required for $self object?
// [[[ INHERITANCE TESTING ]]]
	void inherited__Bubble(SV *person);
//	void inherited(SV *person);

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
	SV *get_data() { return SvREFCNT_inc(this->data); }
	void set_data(SV* data_new) { this->data = data_new; }

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	CPP__RPerl__Algorithm__Sort__Bubble() {}
	~CPP__RPerl__Algorithm__Sort__Bubble() {}

private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
////our %properties =
////(
////	data => my scalar__array_ref $KEY_data,
////);
	SV *data;
};

#endif
#define __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_h 1

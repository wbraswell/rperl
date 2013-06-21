////use strict;  use warnings;
using std::cout;  using std::endl;

//#include "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.h"
//#include <RPerl/HelperFunctions.h>

////use RPerl::Algorithm::Sort;
#include "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort.h"
//#include <RPerl/Algorithm/Sort.h>

// <<< TRANSLATED FUNCTION DECLARATIONS >>>
SV *bubblesort(SV *data);

// DEV NOTE: currently using C++ single inheritance;  is it worth the bother fixing Inline::CPP to get multiple inheritance working?
// DEV NOTE: setting @ISA is handled in Bubble_cpp.pm
////package RPerl::Algorithm::Sort::Bubble;
////our @ISA = ('RPerl::Algorithm::Sort');
//	AV *ISA = newAV();  // DEV NOTE: no programmatic or run-time modification of inheritance, @ISA made private in C++
//	av_push(ISA, SvREFCNT_inc(newSVpv("SOME::RPERL::PACKAGE::INDICATING::TRANSLATED::FROM::PERL::TO::CPP", 2112)));  // NEED ADD: actual package
//	av_push(ISA, SvREFCNT_inc(newSVpv("RPerl::Algorithm::Sort", 22)));  // NEED ANSWER: does this need to go inside the constructor?  if so, how to check class (not object) inheritance?

//class Bubble : public Sort
class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void sort();  // NEED ANSWER: no named argument required for $self object?

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
	SV *get_data() { return SvREFCNT_inc(this->data); }
	void set_data(SV* data_new) { this->data = data_new; }

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
//	Bubble() {} // NEED ANSWER: need init() functionality?  need move @ISA definition here?
//	~Bubble() {}
	CPP__RPerl__Algorithm__Sort__Bubble() {} // NEED ANSWER: need init() functionality?  need move @ISA definition here?
	~CPP__RPerl__Algorithm__Sort__Bubble() {}

private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
////our %properties =
////(
////	data => my scalar_array_ref $KEY_data,
////);
	SV *data;
};

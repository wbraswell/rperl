using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Sort_h
#define __CPP__INCLUDED__RPerl__Algorithm__Sort_h 0.001_000

#include <rperltypes_mode.h>  // for definitions of __PERL__TYPES or __CPP__TYPES
#include <rperltypes.h>  // for data types and structures
#include <RPerl/HelperFunctions.cpp>		// -> HelperFunctions.h

////use RPerl::Algorithm;
#include <RPerl/Algorithm.cpp>		// -> Algorithm.h

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

// [[[ INHERITANCE TESTING ]]]
SV* uninherited__Sort(SV* person);
//SV* uninherited(SV* person);

////package RPerl::Algorithm::Sort;
////our @ISA = ('RPerl::Algorithm');
class RPerl__Algorithm__Sort : public RPerl__Algorithm
{
public:
// [[[ INHERITANCE TESTING ]]]
	void inherited__Sort(SV* person);
//	void inherited(SV* person);

	RPerl__Algorithm__Sort() {}
	~RPerl__Algorithm__Sort() {}
};

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

string uninherited__Sort(string person);
//string uninherited(string person);

class RPerl__Algorithm__Sort : public RPerl__Algorithm
{
public:
// [[[ INHERITANCE TESTING ]]]
    void inherited__Sort(string person);
//  void inherited(string person);

    RPerl__Algorithm__Sort() {}
    ~RPerl__Algorithm__Sort() {}
};

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

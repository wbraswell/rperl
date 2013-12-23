////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_h
#define __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_h 0.003_012

#include <types_mode.h>  // for definitions of __PERL__TYPES or __CPP__TYPES
#include <types.h>  // for data types and structures

#include <RPerl/HelperFunctions.cpp>		// -> HelperFunctions.h

////use RPerl::Algorithm::Sort;
#include <RPerl/Algorithm/Sort.cpp>			// -> Sort.h

////use RPerl::Algorithm::Inefficient;
#include <RPerl/Algorithm/Inefficient.cpp>		// -> Inefficient.h

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

// <<< TRANSLATED FUNCTION DECLARATIONS >>>
SV* integer__bubblesort(SV* data);
//void bubblesort(SV* data);  // TEMPORARY DEBUGGING
// [[[ INHERITANCE TESTING ]]]
SV* uninherited__Bubble(SV* person);
SV* uninherited(SV* person);

// DEV NOTE, CORRELATION #01: multiple inheritance is enabled by _either_ C++ here or Perl at correlation in Bubble_cpp.pm
//class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort  // SINGLE INHERITANCE
class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort, public CPP__RPerl__Algorithm__Inefficient  // MULTIPLE INHERITANCE
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void integer__sort();  // NEED ANSWER: no named argument required for $self object?
// [[[ INHERITANCE TESTING ]]]
	void inherited__Bubble(SV* person);
	void inherited(SV* person);

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
	SV* get_integer__data() { return SvREFCNT_inc(this->integer__data); }
	void set_integer__data(SV* integer__data_new) { this->integer__data = integer__data_new; }

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	CPP__RPerl__Algorithm__Sort__Bubble() {}
	~CPP__RPerl__Algorithm__Sort__Bubble() {}

private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
////our %properties = ( data => my integer__array_ref $KEY_integer__data );
	SV* integer__data;
};

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// <<< TRANSLATED FUNCTION DECLARATIONS >>>
integer__array_ref integer__bubblesort(integer__array_ref integer__data);
// [[[ INHERITANCE TESTING ]]]
string uninherited__Bubble(string person);
string uninherited(string person);

// DEV NOTE, CORRELATION #01: multiple inheritance is enabled by _either_ C++ here or Perl at correlation in Bubble_cpp.pm
//class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort  // SINGLE INHERITANCE
class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort, public CPP__RPerl__Algorithm__Inefficient  // MULTIPLE INHERITANCE
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void integer__sort();  // NEED ANSWER: no named argument required for $self object?
// [[[ INHERITANCE TESTING ]]]
	void inherited__Bubble(string person);
	void inherited(string person);

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
	integer__array_ref get_integer__data() { return(this->integer__data); }
	void set_integer__data(integer__array_ref integer__data_new) { this->integer__data = integer__data_new; }  // NEED ANSWERS: do we need to use some vector copy feature here???

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	CPP__RPerl__Algorithm__Sort__Bubble() {}
	~CPP__RPerl__Algorithm__Sort__Bubble() {}

private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
////our %properties = ( data => my integer__array_ref $KEY_data );
	integer__array_ref integer__data;
};

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# ifdef __PERL__TYPES
SV* bubblesort__ops() { return(newSVpv("CPP", 3)); }
SV* bubblesort__types() { return(newSVpv("PERL", 4)); }
# elif defined __CPP__TYPES
string bubblesort__ops() { string retval = "CPP";  return(retval); }
string bubblesort__types() { string retval = "CPP";  return(retval); }
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* integer__bubblesort__typetest0(SV* lucky_integers);
SV* number__bubblesort__typetest0(SV* lucky_numbers);
SV* string__bubblesort__typetest0(SV* people);
# elif defined __CPP__TYPES
string integer__bubblesort__typetest0(integer__array_ref lucky_integers);
string number__bubblesort__typetest0(number__array_ref lucky_numbers);
string string__bubblesort__typetest0(string__array_ref people);
# endif

#endif

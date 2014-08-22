////use strict;  use warnings;
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_h
#define __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_h 0.003_040

#include <rperltypes_mode.h>  // for definitions of __PERL__TYPES or __CPP__TYPES
#include <rperltypes.h>  // for data types and structures

#include <RPerl/HelperFunctions.cpp>		// -> HelperFunctions.h

////use RPerl::Algorithm::Sort;
#include <RPerl/Algorithm/Sort.cpp>			// -> Sort.h

////use RPerl::Algorithm::Inefficient;
//#include <RPerl/Algorithm/Inefficient.cpp>		// -> Inefficient.h  // MULTIPLE INHERITANCE NOT SUPPORTED BY Inline::CPP

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

////# [[[ PROCEDURAL SUBROUTINES ]]]
////# [[[ PROCEDURAL SUBROUTINES ]]]
////# [[[ PROCEDURAL SUBROUTINES ]]]

SV* integer__bubblesort(SV* integer__data);
SV* number__bubblesort(SV* number__data);
//void integer_bubblesort(SV* data);  // TEMPORARY DEBUGGING

// [[[ INHERITANCE TESTING ]]]
SV* uninherited__Bubble(SV* person);
// DEV NOTE, CORRELATION #04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
SV* uninherited(SV* person);

// DEV NOTE, CORRELATION #01: multiple inheritance is enabled by _either_ C++ here or Perl at correlation in Bubble_cpp.pm
class RPerl__Algorithm__Sort__Bubble : public RPerl__Algorithm__Sort  // SINGLE INHERITANCE
//class RPerl__Algorithm__Sort__Bubble : public RPerl__Algorithm__Sort, public RPerl__Algorithm__Inefficient  // MULTIPLE INHERITANCE NOT SUPPORTED BY Inline::CPP
{
public:
	////# [[[ OO METHODS ]]]
	////# [[[ OO METHODS ]]]
	////# [[[ OO METHODS ]]]

	void integer__sort();  // NEED ANSWER: no named argument required for $self object?
	void number__sort();

// [[[ INHERITANCE TESTING ]]]
	void inherited__Bubble(SV* person);
	void inherited(SV* person);

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
	SV* get_integer__data() { return SvREFCNT_inc(this->integer__data); }
	void set_integer__data(SV* integer__data_new) { this->integer__data = integer__data_new; }
	SV* get_number__data() { return SvREFCNT_inc(this->number__data); }
	void set_number__data(SV* number__data_new) { this->number__data = number__data_new; }

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	RPerl__Algorithm__Sort__Bubble() {}
	~RPerl__Algorithm__Sort__Bubble() {}

////# [[[ OO PROPERTIES ]]]
////# [[[ OO PROPERTIES ]]]
////# [[[ OO PROPERTIES ]]]

private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
////our %properties = ( integer__data => my integer__array_ref $KEY_integer__data, number__data  => my number__array_ref $KEY_number__data );
	SV* integer__data;
	SV* number__data;
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

integer__array_ref integer__bubblesort(integer__array_ref integer__data);
number__array_ref number__bubblesort(number__array_ref number__data);

// [[[ INHERITANCE TESTING ]]]
string uninherited__Bubble(string person);
// DEV NOTE, CORRELATION #04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
string uninherited(string person);

// DEV NOTE, CORRELATION #01: multiple inheritance is enabled by _either_ C++ here or Perl at correlation in Bubble_cpp.pm
class RPerl__Algorithm__Sort__Bubble : public RPerl__Algorithm__Sort  // SINGLE INHERITANCE
//class RPerl__Algorithm__Sort__Bubble : public RPerl__Algorithm__Sort, public RPerl__Algorithm__Inefficient  // MULTIPLE INHERITANCE NOT SUPPORTED BY Inline::CPP
{
public:
	////# [[[ OO METHODS ]]]
	////# [[[ OO METHODS ]]]
	////# [[[ OO METHODS ]]]

	void integer__sort();  // NEED ANSWER: no named argument required for $self object?
	void number__sort();

// [[[ INHERITANCE TESTING ]]]
	void inherited__Bubble(string person);
	void inherited(string person);

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
	integer__array_ref get_integer__data() { return(this->integer__data); }
	void set_integer__data(integer__array_ref integer__data_new) { this->integer__data = integer__data_new; }  // NEED ANSWERS: do we need to use some vector copy feature here???
	number__array_ref get_number__data() { return(this->number__data); }
	void set_number__data(number__array_ref number__data_new) { this->number__data = number__data_new; }

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	RPerl__Algorithm__Sort__Bubble() {}
	~RPerl__Algorithm__Sort__Bubble() {}

	////# [[[ OO PROPERTIES ]]]
	////# [[[ OO PROPERTIES ]]]
	////# [[[ OO PROPERTIES ]]]

private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
////our %properties = ( integer__data => my integer__array_ref $KEY_integer__data, number__data  => my number__array_ref $KEY_number__data );
	integer__array_ref integer__data;
	number__array_ref number__data;
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
//SV* string__bubblesort__typetest0(SV* people);
# elif defined __CPP__TYPES
string integer__bubblesort__typetest0(integer__array_ref lucky_integers);
string number__bubblesort__typetest0(number__array_ref lucky_numbers);
//string string__bubblesort__typetest0(string__array_ref people);
# endif

#endif

////# [[[ HEADER ]]]
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_h
#define __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_h 0.004_010

////# [[[ INCLUDES ]]]
#include <rperltypes_mode.h>  // for definitions of __PERL__TYPES or __CPP__TYPES
#include <rperltypes.h>  // for data types and structures

#include <RPerl/HelperFunctions.cpp>		// -> HelperFunctions.h

////use RPerl::Algorithm::Sort;
#include <RPerl/Algorithm/Sort.cpp>			// -> Sort.h

////use RPerl::Algorithm::Inefficient;
//#include <RPerl/Algorithm/Inefficient.cpp>		// -> Inefficient.h  // NEED UPGRADE: multiple inheritance not currently supported by Inline::CPP

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

////# [[[ OO INHERITANCE ]]]
class RPerl__Algorithm__Sort__Bubble : public RPerl__Algorithm__Sort  // SINGLE OO INHERITANCE
//class RPerl__Algorithm__Sort__Bubble : public RPerl__Algorithm__Sort, public RPerl__Algorithm__Inefficient  // NEED UPGRADE: multiple inheritance not currently supported by Inline::CPP
{
public:
	////# [[[ OO METHODS ]]]

	void integer__sort();  // NEED ANSWER: no named argument required for $self object?
	void number__sort();

	// OO INHERITANCE TESTING
	void inherited__Bubble(SV* person);
	void inherited(SV* person);

	// <<< ACCESSORS & MUTATORS >>>
	SV* get_integer__data() { return SvREFCNT_inc(this->integer__data); }
	void set_integer__data(SV* integer__data_new) { this->integer__data = integer__data_new; }
	SV* get_number__data() { return SvREFCNT_inc(this->number__data); }
	void set_number__data(SV* number__data_new) { this->number__data = number__data_new; }

	// <<< CONSTRUCTOR & DESTRUCTOR >>>
	RPerl__Algorithm__Sort__Bubble() {}
	~RPerl__Algorithm__Sort__Bubble() {}

////# [[[ OO PROPERTIES ]]]

private:
////our %properties = ( integer__data => my integer__array_ref $KEY_integer__data, number__data  => my number__array_ref $KEY_number__data );
	SV* integer__data;
	SV* number__data;
};

////# [[[ SUBROUTINES ]]]

SV* integer__bubblesort(SV* integer__data);
SV* number__bubblesort(SV* number__data);
//void integer_bubblesort(SV* data);  // TEMPORARY DEBUGGING

// OO INHERITANCE TESTING, CONTINUED
SV* uninherited__Bubble(SV* person);
// DEV NOTE, CORRELATION #04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
SV* uninherited(SV* person);

// TYPE TESTING
SV* integer__bubblesort__typetest0(SV* lucky_integers);
SV* number__bubblesort__typetest0(SV* lucky_numbers);
//SV* string__bubblesort__typetest0(SV* people);

// <<< OPERATIONS & DATA TYPES REPORTING >>>
SV* RPerl__Algorithm__Sort__Bubble__OPS_TYPES_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES IS 1
SV* RPerl__Algorithm__Sort__Bubble__ops() { return(newSVpv("CPP", 3)); }
SV* RPerl__Algorithm__Sort__Bubble__types() { return(newSVpv("PERL", 4)); }

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

////# [[[ OO INHERITANCE ]]]
class RPerl__Algorithm__Sort__Bubble : public RPerl__Algorithm__Sort  // SINGLE OO INHERITANCE
//class RPerl__Algorithm__Sort__Bubble : public RPerl__Algorithm__Sort, public RPerl__Algorithm__Inefficient  // NEED UPGRADE: multiple inheritance not currently supported by Inline::CPP
{
public:
	////# [[[ OO METHODS ]]]

	void integer__sort();  // NEED ANSWER: no named argument required for $self object?
	void number__sort();

// OO INHERITANCE TESTING
	void inherited__Bubble(string person);
	void inherited(string person);

	// <<< ACCESSORS & MUTATORS >>>
	integer__array_ref get_integer__data() { return(this->integer__data); }
	void set_integer__data(integer__array_ref integer__data_new) { this->integer__data = integer__data_new; }  // NEED ANSWERS: do we need to use some vector copy feature here???
	number__array_ref get_number__data() { return(this->number__data); }
	void set_number__data(number__array_ref number__data_new) { this->number__data = number__data_new; }

	// <<< CONSTRUCTOR & DESTRUCTOR >>>
	RPerl__Algorithm__Sort__Bubble() {}
	~RPerl__Algorithm__Sort__Bubble() {}

	////# [[[ OO PROPERTIES ]]]

private:
////our %properties = ( integer__data => my integer__array_ref $KEY_integer__data, number__data  => my number__array_ref $KEY_number__data );
	integer__array_ref integer__data;
	number__array_ref number__data;
};

////# [[[ SUBROUTINES ]]]

integer__array_ref integer__bubblesort(integer__array_ref integer__data);
number__array_ref number__bubblesort(number__array_ref number__data);

// OO INHERITANCE TESTING, CONTINUED
string uninherited__Bubble(string person);
// DEV NOTE, CORRELATION #04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
string uninherited(string person);

// TYPE TESTING
string integer__bubblesort__typetest0(integer__array_ref lucky_integers);
string number__bubblesort__typetest0(number__array_ref lucky_numbers);
//string string__bubblesort__typetest0(string__array_ref people);

// <<< OPERATIONS & DATA TYPES REPORTING >>>
integer RPerl__Algorithm__Sort__Bubble__OPS_TYPES_ID() { integer retval = 1;  return(retval); }  // CPPOPS_PERLTYPES IS 1
string RPerl__Algorithm__Sort__Bubble__ops() { string retval = "CPP";  return(retval); }
string RPerl__Algorithm__Sort__Bubble__types() { string retval = "CPP";  return(retval); }

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

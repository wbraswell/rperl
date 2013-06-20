////use strict;  use warnings;
using std::cout;  using std::endl;

#include "/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/HelperFunctions.h"
//#include "/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/HelperFunctions.cpp"
//#include <RPerl/HelperFunctions.cpp>

////use RPerl::Algorithm;
//#include "/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm.cpp"
//#include <RPerl/Algorithm.cpp>

/*
void sort();  // DUMMY!
SV *get_data();  // DUMMY!
void set_data(SV *new_data);  // DUMMY!
*/

// <<< TRANSLATED FUNCTION DECLARATIONS >>>
void not_inherited(SV *person);

////package RPerl::Algorithm::Sort;
////our @ISA = ('RPerl::Algorithm');
//class Sort : public Algorithm
//class Sort
class CPP__RPerl__Algorithm__Sort
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void inherited(SV *person);

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS
	// NONE

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
//	Sort() {}
//	~Sort() {}
	CPP__RPerl__Algorithm__Sort() {}
	~CPP__RPerl__Algorithm__Sort() {}

//private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
	// NONE
};

////our void__method $inherited = sub { (my object $self, my string $person) = @_;  print "[[[ HOWDY \$self $self \$person $person FROM INSIDE inherited()!!! ]]]\n"; };
//void Sort::inherited(SV *person) { printf("[[[ C++ HOWDY $self %d $person %s FROM INSIDE inherited()!!! ]]]\n", 2112, SvPV_nolen(person)); }
//void Sort::inherited(SV *person) { cout << "[[[ C++ HOWDY $self " << this << " $person " << SvPV_nolen(person) << " FROM INSIDE inherited()!!! ]]]\n"; }
void CPP__RPerl__Algorithm__Sort::inherited(SV *person) { cout << "[[[ C++ HOWDY $self " << this << " $person " << SvPV_nolen(person) << " FROM INSIDE inherited()!!! ]]]\n"; }

////our void $not_inherited = sub { (my string $person) = @_;  print "[[[ HOW DO YOU DO \$person $person FROM INSIDE not_inherited()... ]]]\n"; };
void not_inherited(SV *person) { printf("[[[ C++ HOW DO YOU DO $person %s FROM INSIDE not_inherited()... ]]]\n", SvPV_nolen(person)); }

////# all of the following happen before the INIT block, and thus rely upon AUTOLOAD
////print "WAZZUP FROM Sort.pm\n";
////inherited('FAKESELF', "Spidey");
////RPerl::Algorithm::Sort::inherited("FAKECLASS", "Peter Parker");
////RPerl::Algorithm::Sort->inherited("Mary Jane");

////not_inherited('Doc Oc');
////RPerl::Algorithm::Sort::not_inherited("Doctor Octavius");
////RPerl::Algorithm::Sort->not_inherited("Mad Scientist");  # ignores "Mad Scientist"
////print "LATERZ FROM Sort.pm\n";

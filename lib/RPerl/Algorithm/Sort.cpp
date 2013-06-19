////use strict;  use warnings;

////use RPerl::Algorithm;
//#include "/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm.cpp"
//#include <RPerl/Algorithm.cpp>


// <<< TRANSLATED FUNCTION DECLARATIONS >>>
void not_inherited(SV *person);

void sort();  // DUMMY!
SV *get_data();  // DUMMY!
void set_data(SV *new_data);  // DUMMY!

////package RPerl::Algorithm::Sort;
////our @ISA = ('RPerl::Algorithm');
//class Sort : public Algorithm
class Sort
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void inherited(SV *person);

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS
	// NONE

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	Sort() {}
	~Sort() {}
//	AV *ISA = newAV();  // DEV NOTE: no programmatic or run-time modification of inheritance, @ISA made private in C++
//	av_push(ISA, SvREFCNT_inc(newSVpv("SOME::RPERL::PACKAGE::INDICATING::TRANSLATED::FROM::PERL::TO::CPP", 2112)));  // NEED ADD: actual package
//	av_push(ISA, SvREFCNT_inc(newSVpv("RPerl::Algorithm", 22)));  // NEED ANSWER: does this have to go inside the constructor?  if so, how to check class (not object) inheritance?

//private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
	// NONE
};

////our void__method $inherited = sub { (my object $self, my string $person) = @_;  print "[[[ HOWDY \$self $self \$person $person FROM INSIDE inherited()!!! ]]]\n"; };
void Sort::inherited(SV *person) { printf("[[[ C++ HOWDY $self %d $person %s FROM INSIDE inherited()!!! ]]]\n", 2112, SvPV_nolen(person)); }

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

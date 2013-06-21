////use strict;  use warnings;
using std::cout;  using std::endl;

//#include "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.h"
//#include <RPerl/HelperFunctions.h>
//#include "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort.h"
//#include <RPerl/Algorithm/Sort.h>

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

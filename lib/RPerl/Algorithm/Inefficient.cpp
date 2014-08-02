// START HERE: create comment labels for this file to match Inefficient.pm, do the same in Inefficient.h; carry on with Algorithm.* and Sort.*, then NAMESPACE
// START HERE: create comment labels for this file to match Inefficient.pm, do the same in Inefficient.h; carry on with Algorithm.* and Sort.*, then NAMESPACE
// START HERE: create comment labels for this file to match Inefficient.pm, do the same in Inefficient.h; carry on with Algorithm.* and Sort.*, then NAMESPACE

using std::cout;
using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Inefficient_cpp
#define __CPP__INCLUDED__RPerl__Algorithm__Inefficient_cpp 0.003_050

#include <RPerl/Algorithm/Inefficient.h>  // -> HelperFunctions.cpp && Algorithm.cpp

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

////our void__method $inherited__Inefficient = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient(), received \$self = '$self' and \$person = '$person', FLUFFY\n"; };
void CPP__RPerl__Algorithm__Inefficient::inherited__Inefficient(SV* person) {cout << "in CPPOPS_PERLTYPES Inefficient->inherited__Inefficient(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', FLUFFY\n";}

////our void__method $inherited = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Inefficient->inherited(), received \$self = '$self' and \$person = '$person', INCOMPATIBLE\n"; };
void CPP__RPerl__Algorithm__Inefficient::inherited(SV* person) {cout << "in CPPOPS_PERLTYPES Inefficient->inherited(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', INCOMPATIBLE\n";}

////our string $uninherited__Inefficient = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Inefficient::uninherited__Inefficient(), received \$person = '$person', MESSY\n"; return 'Inefficient::uninherited__Inefficient() RULES! PERLOPS_PERLTYPES'; };
SV* uninherited__Inefficient(SV* person) {cout << "in CPPOPS_PERLTYPES Inefficient::uninherited__Inefficient(), received person = '" << SvPV_nolen(person) << "', MESSY\n"; return newSVpv("CPPOPS_PERLTYPES Inefficient::uninherited__Inefficient() RULES!", 0);}

// DEV NOTE, CORRELATION #04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
////our string $uninherited = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Inefficient::uninherited(), received \$person = '$person', TRICKS\n"; return 'Inefficient::uninherited() ROCKS! PERLOPS_PERLTYPES'; };
//SV* uninherited(SV* person) { cout << "in CPPOPS_PERLTYPES Inefficient::uninherited(), received person = '" << SvPV_nolen(person) << "', TRICKS\n";  return newSVpv("Inefficient::uninherited() RULES! CPPOPS_PERLTYPES", 0); }

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

void CPP__RPerl__Algorithm__Inefficient::inherited__Inefficient(string person) {
    cout
            << "in CPPOPS_CPPTYPES Inefficient->inherited__Inefficient(), received this = '"
            << this << "' and person = '" << person << "', FRIED\n";
}

void CPP__RPerl__Algorithm__Inefficient::inherited(string person) {
    cout << "in CPPOPS_CPPTYPES Inefficient->inherited(), received this = '"
            << this << "' and person = '" << person << "', ILLOGICAL\n";
}

string uninherited__Inefficient(string person) {
    cout
            << "in CPPOPS_CPPTYPES Inefficient::uninherited__Inefficient(), received person = '"
            << person << "', MITOCHONDRIAL\n";
    return ((string) "Inefficient::uninherited__Inefficient() RULES! CPPOPS_CPPTYPES");
}

// DEV NOTE, CORRELATION #04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
/*
 string uninherited(string person)
 {
 cout << "in CPPOPS_CPPTYPES Inefficient::uninherited(), received person = '" << person << "', TETRAHEDRON\n";
 return((string)"Inefficient::uninherited() RULES! CPPOPS_CPPTYPES");
 }
 */

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

using std::cout;
using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Inefficient_cpp
#define __CPP__INCLUDED__RPerl__Algorithm__Inefficient_cpp 0.003_060

#include <RPerl/Algorithm/Inefficient.h>  // -> HelperFunctions.cpp && Algorithm.cpp

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

////our void__method $inherited__Inefficient = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient(), received \$self = '$self' and \$person = '$person', FLUFFY\n"; };
void RPerl__Algorithm__Inefficient::inherited__Inefficient(SV* person) {cout << "in CPPOPS_PERLTYPES Inefficient->inherited__Inefficient(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', FLUFFY\n";}

////our void__method $inherited = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Inefficient->inherited(), received \$self = '$self' and \$person = '$person', INCOMPATIBLE\n"; };
void RPerl__Algorithm__Inefficient::inherited(SV* person) {cout << "in CPPOPS_PERLTYPES Inefficient->inherited(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', INCOMPATIBLE\n";}

////our string $uninherited__Inefficient = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Inefficient::uninherited__Inefficient(), received \$person = '$person', MESSY\n"; return 'Inefficient::uninherited__Inefficient() RULES! PERLOPS_PERLTYPES'; };
SV* uninherited__Inefficient(SV* person) {cout << "in CPPOPS_PERLTYPES Inefficient::uninherited__Inefficient(), received person = '" << SvPV_nolen(person) << "', MESSY\n"; return newSVpv("Inefficient::uninherited__Inefficient() RULES! CPPOPS_PERLTYPES", 0);}

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

////our void__method $inherited__Inefficient = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient(), received \$self = '$self' and \$person = '$person', FLUFFY\n"; };
void RPerl__Algorithm__Inefficient::inherited__Inefficient(string person) { cout << "in CPPOPS_CPPTYPES Inefficient->inherited__Inefficient(), received this = '" << this << "' and person = '" << person << "', FLUFFY\n"; }

////our void__method $inherited = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Inefficient->inherited(), received \$self = '$self' and \$person = '$person', INCOMPATIBLE\n"; };
void RPerl__Algorithm__Inefficient::inherited(string person) { cout << "in CPPOPS_CPPTYPES Inefficient->inherited(), received this = '" << this << "' and person = '" << person << "', INCOMPATIBLE\n"; }

////our string $uninherited__Inefficient = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Inefficient::uninherited__Inefficient(), received \$person = '$person', MESSY\n"; return 'Inefficient::uninherited__Inefficient() RULES! PERLOPS_PERLTYPES'; };
string uninherited__Inefficient(string person) { cout << "in CPPOPS_CPPTYPES Inefficient::uninherited__Inefficient(), received person = '" << person << "', MESSY\n"; return ((string) "Inefficient::uninherited__Inefficient() RULES! CPPOPS_CPPTYPES"); }

// DEV NOTE, CORRELATION #04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
////our string $uninherited = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Inefficient::uninherited(), received \$person = '$person', TRICKS\n"; return 'Inefficient::uninherited() ROCKS! PERLOPS_PERLTYPES'; };
//string uninherited(string person) { cout << "in CPPOPS_CPPTYPES Inefficient::uninherited(), received person = '" << person << "', TRICKS\n"; return((string)"Inefficient::uninherited() ROCKS! CPPOPS_CPPTYPES"); }

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

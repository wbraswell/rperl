using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Sort_cpp
#define __CPP__INCLUDED__RPerl__Algorithm__Sort_cpp 0.001_010

#include <RPerl/Algorithm/Sort.h>  // -> HelperFunctions.cpp && Algorithm.cpp

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

// [[[ INHERITANCE TESTING ]]]
////our void_method $inherited__Sort = sub { (my object $self, my string $person) = @_;  RPerl::diag "in PERLOPS_PERLTYPES Sort->inherited__Sort(), received \$self = '$self' and \$person = '$person', FISH\n"; };
void RPerl__Algorithm__Sort::inherited__Sort(SV* person) { cout << "in CPPOPS_PERLTYPES Sort->inherited__Sort(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', FISH\n"; }

////our void_method $inherited = sub { (my object $self, my string $person) = @_;  RPerl::diag "in PERLOPS_PERLTYPES Sort->inherited(), received \$self = '$self' and \$person = '$person', IN\n"; };
//void RPerl__Algorithm__Sort::inherited(SV* person) { cout << "in CPPOPS_PERLTYPES Sort->inherited(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', IN\n"; }

////our string $uninherited__Sort = sub { (my string $person) = @_;  RPerl::diag "in PERLOPS_PERLTYPES Sort::uninherited__Sort(), received \$person = '$person', MY\n";  return "Sort::uninherited__Sort() RULES! PERLOPS_PERLTYPES"; };
SV* uninherited__Sort(SV* person) { cout << "in CPPOPS_PERLTYPES Sort::uninherited__Sort(), received person = '" << SvPV_nolen(person) << "', MY\n";  return newSVpv("Sort::uninherited__Sort() RULES! CPPOPS_PERLTYPES", 0); }

////our string $uninherited = sub { (my string $person) = @_;  RPerl::diag "in PERLOPS_PERLTYPES Sort::uninherited(), received \$person = '$person', TROUSERS\n";  return "Sort::uninherited() ROCKS! PERLOPS_PERLTYPES"; };
//SV* uninherited(SV* person) { cout << "in CPPOPS_PERLTYPES Sort::uninherited(), received person = '" << SvPV_nolen(person) << "', TROUSERS\n";  return newSVpv("Sort::uninherited() ROCKS! CPPOPS_PERLTYPES", 0); }

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

////our void_method $inherited__Sort = sub { (my object $self, my string $person) = @_;  RPerl::diag "in PERLOPS_PERLTYPES Sort->inherited__Sort(), received \$self = '$self' and \$person = '$person', FISH\n"; };
void RPerl__Algorithm__Sort::inherited__Sort(string person) { cout << "in CPPOPS_CPPTYPES Sort->inherited__Sort(), received this = '" << this << "' and person = '" << person << "', FISH\n"; }

////our void_method $inherited = sub { (my object $self, my string $person) = @_;  RPerl::diag "in PERLOPS_PERLTYPES Sort->inherited(), received \$self = '$self' and \$person = '$person', IN\n"; };
//void RPerl__Algorithm__Sort::inherited(string person) { cout << "in CPPOPS_CPPTYPES Sort->inherited(), received this = '" << this << "' and person = '" << person << "', IN\n"; }

////our string $uninherited__Sort = sub { (my string $person) = @_;  RPerl::diag "in PERLOPS_PERLTYPES Sort::uninherited__Sort(), received \$person = '$person', MY\n";  return "Sort::uninherited__Sort() RULES! PERLOPS_PERLTYPES"; };
string uninherited__Sort(string person) { cout << "in CPPOPS_CPPTYPES Sort::uninherited__Sort(), received person = '" << person << "', MY\n";  return (string)"Sort::uninherited__Sort() RULES! CPPOPS_CPPTYPES"; }

////our string $uninherited = sub { (my string $person) = @_;  RPerl::diag "in PERLOPS_PERLTYPES Sort::uninherited(), received \$person = '$person', TROUSERS\n";  return "Sort::uninherited() ROCKS! PERLOPS_PERLTYPES"; };
//string uninherited(string person) { cout << "in CPPOPS_CPPTYPES Sort::uninherited(), received person = '" << person << "', TROUSERS\n";  return (string)"Sort::uninherited() ROCKS! CPPOPS_CPPTYPES"; }

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

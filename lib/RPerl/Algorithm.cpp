////# [[[ HEADER ]]]
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm_cpp
#define __CPP__INCLUDED__RPerl__Algorithm_cpp 0.004_011

////# [[[ INCLUDES ]]]
#include <RPerl/Algorithm.h>  // -> HelperFunctions.cpp

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

////# [[[ OO METHODS & SUBROUTINES ]]]

// INHERITANCE TESTING
////our void_method $inherited__Algorithm = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm(), received \$self = '$self' and \$person = '$person', FNORD\n"; };
void RPerl__Algorithm::inherited__Algorithm(SV* person) { cout << "in CPPOPS_PERLTYPES Algorithm->inherited__Algorithm(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', FNORD\n"; }

////our void_method $inherited = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Algorithm->inherited(), received \$self = '$self' and \$person = '$person', IS\n"; };
//void RPerl__Algorithm::inherited(SV* person) { cout << "in CPPOPS_PERLTYPES Algorithm->inherited(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', IS\n"; }

////# [[[ SUBROUTINES ]]]

// INHERITANCE TESTING, CONTINUED
////our string $uninherited__Algorithm = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Algorithm::uninherited__Algorithm(), received \$person = '$person', MYSTIC\n"; return 'Algorithm::uninherited__Algorithm() RULES! PERLOPS_PERLTYPES'; };
SV* uninherited__Algorithm(SV* person) { cout << "in CPPOPS_PERLTYPES Algorithm::uninherited__Algorithm(), received person = '" << SvPV_nolen(person) << "', MYSTIC\n";  return newSVpv("Algorithm::uninherited__Algorithm() RULES! CPPOPS_PERLTYPES", 0); }

////our string $uninherited = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Algorithm::uninherited(), received \$person = '$person', TERRITORY\n"; return "Algorithm::uninherited() ROCKS! PERLOPS_PERLTYPES"; };
//SV* uninherited(SV* person) { cout << "in CPPOPS_PERLTYPES Algorithm::uninherited(), received person = '" << SvPV_nolen(person) << "', TERRITORY\n";  return newSVpv("Algorithm::uninherited() ROCKS! CPPOPS_PERLTYPES", 0); }

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

////# [[[ OO METHODS & SUBROUTINES ]]]

// INHERITANCE TESTING
////our void_method $inherited__Algorithm = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm(), received \$self = '$self' and \$person = '$person', FNORD\n"; };
void RPerl__Algorithm::inherited__Algorithm(string person) { cout << "in CPPOPS_CPPTYPES Algorithm->inherited__Algorithm(), received this = '" << this << "' and person = '" << person << "', FNORD\n"; }

////our void_method $inherited = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Algorithm->inherited(), received \$self = '$self' and \$person = '$person', IS\n"; };
//void RPerl__Algorithm::inherited(SV* person) { cout << "in CPPOPS_CPPTYPES Algorithm->inherited(), received this = '" << this << "' and person = '" << person << "', IS\n"; }

////# [[[ SUBROUTINES ]]]

// INHERITANCE TESTING, CONTINUED
////our string $uninherited__Algorithm = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Algorithm::uninherited__Algorithm(), received \$person = '$person', MYSTIC\n"; return 'Algorithm::uninherited__Algorithm() RULES! PERLOPS_PERLTYPES'; };
string uninherited__Algorithm(string person) { cout << "in CPPOPS_CPPTYPES Algorithm::uninherited__Algorithm(), received person = '" << person << "', MYSTIC\n";  return "Algorithm::uninherited__Algorithm() RULES! CPPOPS_CPPTYPES"; }

////our string $uninherited = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Algorithm::uninherited(), received \$person = '$person', TERRITORY\n"; return "Algorithm::uninherited() ROCKS! PERLOPS_PERLTYPES"; };
//string uninherited(string person) { cout << "in CPPOPS_CPPTYPES Algorithm::uninherited(), received person = '" << person << "', TERRITORY\n";  return (string)"Algorithm::uninherited() ROCKS! CPPOPS_CPPTYPES"; }

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

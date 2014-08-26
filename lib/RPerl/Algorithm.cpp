////# [[[ HEADER ]]]
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm_cpp
#define __CPP__INCLUDED__RPerl__Algorithm_cpp 0.004_010

////# [[[ INCLUDES ]]]
#include <RPerl/Algorithm.h>  // -> HelperFunctions.cpp

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

////# [[[ OO METHODS ]]]

// INHERITANCE TESTING
////our void__method $inherited__Algorithm = sub { (my object $self, my string $person) = @_;  print "in Perl Algorithm->inherited__Algorithm(), have \$self = '$self' and \$person = '$person', FNORD\n"; };
void RPerl__Algorithm::inherited__Algorithm(SV* person) { cout << "in Algorithm->inherited__Algorithm(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', FNORD CPPOPS_PERLTYPES\n"; }

////our void__method $inherited = sub { (my object $self, my string $person) = @_;  print "in Perl Algorithm->inherited(), have \$self = '$self' and \$person = '$person', IS\n"; };
//void RPerl__Algorithm::inherited(SV* person) { cout << "in Algorithm->inherited(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', IS CPPOPS_PERLTYPES\n"; }

////# [[[ SUBROUTINES ]]]

// INHERITANCE TESTING, CONTINUED
////our string $uninherited__Algorithm = sub { (my string $person) = @_;  print "in Perl Algorithm::uninherited__Algorithm(), \$person = '$person', MYSTIC\n";  return "Perl Algorithm::uninherited__Algorithm() RULES!"; };
SV* uninherited__Algorithm(SV* person) { cout << "in Algorithm::uninherited__Algorithm(), have $person = '" << SvPV_nolen(person) << "', MYSTIC CPPOPS_PERLTYPES\n";  return newSVpv("Algorithm::uninherited__Algorithm() RULES! CPPOPS_PERLTYPES", 0); }

////our string $uninherited = sub { (my string $person) = @_;  print "in Perl Algorithm::uninherited(), \$person = '$person', TERRITORY\n";  return "Perl Algorithm::uninherited() ROCKS!"; };
//SV* uninherited(SV* person) { cout << "in Algorithm::uninherited(), have $person = '" << SvPV_nolen(person) << "', TERRITORY CPPOPS_PERLTYPES\n";  return newSVpv("Algorithm::uninherited() RULES! CPPOPS_PERLTYPES", 0); }

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

////# [[[ OO METHODS ]]]

// INHERITANCE TESTING
////our void__method $inherited__Algorithm = sub { (my object $self, my string $person) = @_;  print "in Perl Algorithm->inherited__Algorithm(), have \$self = '$self' and \$person = '$person', FNORD\n"; };
void RPerl__Algorithm::inherited__Algorithm(string person) { cout << "in Algorithm->inherited__Algorithm(), have $self = '" << this << "' and $person = '" << person << "', FNORD CPPOPS_CPPTYPES\n"; }

////our void__method $inherited = sub { (my object $self, my string $person) = @_;  print "in Perl Algorithm->inherited(), have \$self = '$self' and \$person = '$person', IS\n"; };
//void RPerl__Algorithm::inherited(SV* person) { cout << "in Algorithm->inherited(), have $self = '" << this << "' and $person = '" << person << "', IS CPPOPS_CPPTYPES\n"; }

////# [[[ SUBROUTINES ]]]

// INHERITANCE TESTING, CONTINUED
////our string $uninherited__Algorithm = sub { (my string $person) = @_;  print "in Perl Algorithm::uninherited__Algorithm(), \$person = '$person', MYSTIC\n";  return "Perl Algorithm::uninherited__Algorithm() RULES!"; };
string uninherited__Algorithm(string person) { cout << "in Algorithm::uninherited__Algorithm(), have $person = '" << person << "', MYSTIC CPPOPS_CPPTYPES\n";  return "Algorithm::uninherited__Algorithm() RULES! CPPOPS_CPPTYPES"; }

////our string $uninherited = sub { (my string $person) = @_;  print "in Perl Algorithm::uninherited(), \$person = '$person', TERRITORY\n";  return "Perl Algorithm::uninherited() ROCKS!"; };
//string uninherited(string person) { cout << "in Algorithm::uninherited(), have $person = '" << person << "', TETRAHEDRON CPPOPS_CPPTYPES\n";  return (string)"Algorithm::uninherited() RULES! CPPOPS_CPPTYPES"; }

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

////use strict;  use warnings;
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm_cpp
#define __CPP__INCLUDED__RPerl__Algorithm_cpp 1

#include <RPerl/Algorithm.h>  // -> HelperFunctions.cpp && Class.cpp???  RPerl.cpp???

// [[[ INHERITANCE TESTING ]]]
////our void__method $inherited__Algorithm = sub { (my object $self, my string $person) = @_;  print "in Perl Algorithm->inherited__Algorithm(), have \$self = '$self' and \$person = '$person', FNORD\n"; };
void CPP__RPerl__Algorithm::inherited__Algorithm(SV* person) { cout << "in CPPOPS_PERLTYPES Algorithm->inherited__Algorithm(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', FNORD\n"; }

////our void__method $inherited = sub { (my object $self, my string $person) = @_;  print "in Perl Algorithm->inherited(), have \$self = '$self' and \$person = '$person', IS\n"; };
//void CPP__RPerl__Algorithm::inherited(SV* person) { cout << "in CPPOPS_PERLTYPES Algorithm->inherited(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', IS\n"; }

////our string $uninherited__Algorithm = sub { (my string $person) = @_;  print "in Perl Algorithm::uninherited__Algorithm(), \$person = '$person', MYSTIC\n";  return "Perl Algorithm::uninherited__Algorithm() RULES!"; };
SV* uninherited__Algorithm(SV* person) { cout << "in CPPOPS_PERLTYPES Algorithm::uninherited__Algorithm(), have $person = '" << SvPV_nolen(person) << "', MYSTIC\n";  return newSVpv("CPPOPS_PERLTYPES Algorithm::uninherited__Algorithm() RULES!", 0); }

////our string $uninherited = sub { (my string $person) = @_;  print "in Perl Algorithm::uninherited(), \$person = '$person', TERRITORY\n";  return "Perl Algorithm::uninherited() ROCKS!"; };
//SV* uninherited(SV* person) { cout << "in CPPOPS_PERLTYPES Algorithm::uninherited(), have $person = '" << SvPV_nolen(person) << "', TERRITORY\n";  return newSVpv("CPPOPS_PERLTYPES Algorithm::uninherited() RULES!", 0); }  // PERL_TYPES
char *uninherited(char *person) { cout << "in CPPOPS_CPPTYPES Algorithm::uninherited(), have $person = '" << person << "', TETRAHEDRON\n";  return (char *)"CPPOPS_CPPTYPES Algorithm::uninherited() RULES!"; }  // CPP_TYPES

#endif

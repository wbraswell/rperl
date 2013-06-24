////use strict;  use warnings;
using std::cout;  using std::endl;

#include "/tmp/RPerl-latest/lib/RPerl/Algorithm/Inefficient.h"  // -> HelperFunctions.c && Algorithm.cpp
//	#include <RPerl/Algorithm/Inefficient.h>

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Inefficient_cpp

// [[[ INHERITANCE TESTING ]]]
////our void__method $inherited__Inefficient = sub { (my object $self, my string $person) = @_;  print "in Perl Inefficient->inherited__Inefficient(), have \$self = '$self' and \$person = '$person', FLUFFY\n"; };
void CPP__RPerl__Algorithm__Inefficient::inherited__Inefficient(SV *person) { cout << "in C++ PERL_TYPES Inefficient->inherited__Inefficient(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', FLUFFY\n"; }

////our void__method $inherited = sub { (my object $self, my string $person) = @_;  print "in Perl Inefficient->inherited(), have \$self = '$self' and \$person = '$person', INCOMPATIBLE\n"; };
void CPP__RPerl__Algorithm__Inefficient::inherited(SV *person) { cout << "in C++ PERL_TYPES Inefficient->inherited(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', INCOMPATIBLE\n"; }

////our string $uninherited__Inefficient = sub { (my string $person) = @_;  print "in Perl Inefficient::uninherited__Inefficient(), \$person = '$person', MESSY\n";  return "Perl Inefficient::uninherited__Inefficient() RULES!"; };
SV *uninherited__Inefficient(SV *person) { cout << "in C++ PERL_TYPES Inefficient::uninherited__Inefficient(), have $person = '" << SvPV_nolen(person) << "', MESSY\n";  return newSVpv("C++ PERL_TYPES Inefficient::uninherited__Inefficient() RULES!", 0); }

////our string $uninherited = sub { (my string $person) = @_;  print "in Perl Inefficient::uninherited(), \$person = '$person', TRICKS\n";  return "Perl Inefficient::uninherited() ROCKS!"; };
//SV *uninherited(SV *person) { cout << "in C++ PERL_TYPES Inefficient::uninherited(), have $person = '" << SvPV_nolen(person) << "', TRICKS\n";  return newSVpv("C++ PERL_TYPES Inefficient::uninherited() RULES!", 0); }  // PERL_TYPES
//char *uninherited(char *person) { cout << "in C++ CPP_TYPES Inefficient::uninherited(), have $person = '" << person << "', TETRAHEDRON\n";  return (char *)"C++ CPP_TYPES Inefficient::uninherited() RULES!"; }  // CPP_TYPES

//# [[[ TYPE TESTING ]]]
//our void $uninherited__string_array_in = sub { (my string__array_ref $people) = @_;  for (my int $i = 0;  $i < @{$people};  $i++) { print "in Perl Inefficient::uninherited__string_array_in(), have person $i = '" . $people->[$i] . ", FOOBAZ'\n"; } };
//void uninherited__string_array_in(char **people) { char **person;  int i = 0;  for (person = people;  *person;  person++ ) { cout << "in C++ CPP_TYPES Inefficient::uninherited__string_array_in(), have person " << i << " = '" << *person << "', FOOBAZ\n";  i++; } }  // CPP_TYPES
//void uninherited__string_array_in(char **people) { cout << "in C++ CPP_TYPES Inefficient::uninherited__string_array_in(), have person '', FOOBAZ\n"; }  // CPP_TYPES
void uninherited__string_array_in() { cout << "in C++ CPP_TYPES Inefficient::uninherited__string_array_in(), have person '', FOOBAZ\n"; }  // CPP_TYPES



// START HERE: re-enable char** argument above, add debugging print() statements to Array.c



#endif
#define __CPP__INCLUDED__RPerl__Algorithm__Inefficient_cpp 1

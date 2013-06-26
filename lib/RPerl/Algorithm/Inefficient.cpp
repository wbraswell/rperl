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
void typetest___int__in___void__out(int fuzznum) { printf("in C CPP_TYPES Array::typetest___int__in___void__out(), have fuzznum '%d', BOOFAZ\n", fuzznum); }  // CPP_TYPES
void typetest___string__in___void__out(char* fuzzword) { printf("in C CPP_TYPES Array::typetest___string__in___void__out(), have fuzzword '%s', BAZBOT\n", fuzzword); }  // CPP_TYPES
void typetest___int__array_ref__in___void__out(int__array_ref lucky_numbers) { int how_lucky = lucky_numbers.size();  int i;  for (i = 0;  i < how_lucky;  i++) { printf("in C CPP_TYPES Array::typetest___int__array_ref__in___void__out(), have lucky number %d/%d = '%d', BARBAT\n", i, (how_lucky - 1), lucky_numbers[i]); } }  // CPP_TYPES
//our void $typetest___string__array_ref__in___void__out = sub { (my string__array_ref $people) = @_;  for (my int $i = 0;  $i < @{$people};  $i++) { print "in Perl Inefficient::typetest___string__array_ref__in___void__out(), have person $i = '" . $people->[$i] . "', FOOBAZ\n"; } };  // PERL_TYPES
void typetest___string__array_ref__in___void__out(string__array_ref people) { char **person;  int i = 0;  for (person = people;  *person;  person++ ) { printf("in C CPP_TYPES Array::typetest___string__array_ref__in___void__out(), have person %d = '%s', FOOBAZ\n", i, *person);  i++; } }  // CPP_TYPES

string__array_ref typetest___void__in___string__array_ref__out()
{
	char **people;
	int i;
	const int num_people = 5;
	const int num_person = 10;

	people = (char **)safemalloc( sizeof(char*) * (num_people + 1) );

	if (people == NULL) { croak("in C Inefficient::typetest___void__in___string__array_ref__out(), unable to malloc char**"); }

	for (i = 0;  i < num_people;  i++)
	{
		people[i] = (char *)safemalloc( num_person + 1 );
		if( people[i] == NULL ) { croak("in C Inefficient::typetest___void__in___string__array_ref__out(), unable to malloc char*"); }

		// NEED ANSWER: why must we do a strcpy() here instead of just setting the element directly?
//		people[i] = (char *)"Jeffy Ten!";
		strcpy( people[i], (char *)"Jeffy " );
		people[i][6] = (char)(i + 48);
		people[i][7] = '/';
		people[i][8] = (char)((num_people - 1) + 48);
		people[i][9] = (char)NULL;

		printf("in C Inefficient::typetest___void__in___string__array_ref__out(), bottom of for() loop, have i = %d, just set another Jeffy!\n", i);
	}

	// DEV NOTE: all arrays must end in NULL sentinel as currently implemented by the pack and unpack subroutines
	people[i] = (char *)NULL;

	printf("in C Inefficient::typetest___void__in___string__array_ref__out(), bottom of subroutine\n");

	return(people);

} // CPP_TYPES

#endif
#define __CPP__INCLUDED__RPerl__Algorithm__Inefficient_cpp 1

////use strict;  use warnings;
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Inefficient_cpp
#define __CPP__INCLUDED__RPerl__Algorithm__Inefficient_cpp 1

#include <RPerl/Algorithm/Inefficient.h>  // -> HelperFunctions.cpp && Algorithm.cpp

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

// [[[ INHERITANCE TESTING ]]]
////our void__method $inherited__Inefficient = sub { (my object $self, my string $person) = @_;  print "in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient(), have \$self = '$self' and \$person = '$person', FLUFFY\n"; };
void CPP__RPerl__Algorithm__Inefficient::inherited__Inefficient(SV* person) { cout << "in CPPOPS_PERLTYPES Inefficient->inherited__Inefficient(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', FLUFFY\n"; }

////our void__method $inherited = sub { (my object $self, my string $person) = @_;  print "in PERLOPS_PERLTYPES Inefficient->inherited(), have \$self = '$self' and \$person = '$person', INCOMPATIBLE\n"; };
void CPP__RPerl__Algorithm__Inefficient::inherited(SV* person) { cout << "in CPPOPS_PERLTYPES Inefficient->inherited(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', INCOMPATIBLE\n"; }

////our string $uninherited__Inefficient = sub { (my string $person) = @_;  print "in PERLOPS_PERLTYPES Inefficient::uninherited__Inefficient(), \$person = '$person', MESSY\n";  return "Perl Inefficient::uninherited__Inefficient() RULES!"; };
SV* uninherited__Inefficient(SV* person) { cout << "in CPPOPS_PERLTYPES Inefficient::uninherited__Inefficient(), have $person = '" << SvPV_nolen(person) << "', MESSY\n";  return newSVpv("CPPOPS_PERLTYPES Inefficient::uninherited__Inefficient() RULES!", 0); }

////our string $uninherited = sub { (my string $person) = @_;  print "in PERLOPS_PERLTYPES Inefficient::uninherited(), \$person = '$person', TRICKS\n";  return "Perl Inefficient::uninherited() ROCKS!"; };
//SV* uninherited(SV* person) { cout << "in CPPOPS_PERLTYPES Inefficient::uninherited(), have $person = '" << SvPV_nolen(person) << "', TRICKS\n";  return newSVpv("CPPOPS_PERLTYPES Inefficient::uninherited() RULES!", 0); }  // PERL_TYPES

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ INHERITANCE TESTING ]]]

//char *uninherited(char *person) { cout << "in CPPOPS_CPPTYPES Inefficient::uninherited(), have $person = '" << person << "', TETRAHEDRON\n";  return (char *)"CPPOPS_CPPTYPES Inefficient::uninherited() RULES!"; }  // CPP_TYPES

void CPP__RPerl__Algorithm__Sort__Bubble::inherited__Bubble(string person)
{
    cout << "in CPPOPS_CPPTYPES Bubble->inherited__Bubble(), received this = '" << this << "' and person = '" << person << "', FRIED\n";
}

void CPP__RPerl__Algorithm__Sort__Bubble::inherited(string person)
{
    cout << "in CPPOPS_CPPTYPES Bubble->inherited(), received this = '" << this << "' and person = '" << person << "', ILLOGICAL\n";
}

string uninherited__Bubble(string person) {
    cout << "in CPPOPS_CPPTYPES Bubble::uninherited__Bubble(), received person = '" << person << "', MITOCHONDRIAL\n";
    return((string)"Bubble::uninherited__Bubble() RULES! CPPOPS_CPPTYPES");
}

string uninherited(string person)
{
    cout << "in CPPOPS_CPPTYPES Bubble::uninherited(), received person = '" << person << "', TETRAHEDRON\n";
    return((string)"Bubble::uninherited() RULES! CPPOPS_CPPTYPES");
}





// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

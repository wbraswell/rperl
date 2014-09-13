using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Sort_cpp
#define __CPP__INCLUDED__RPerl__Algorithm__Sort_cpp 0.001_000

#include <RPerl/Algorithm/Sort.h>  // -> HelperFunctions.cpp && Algorithm.cpp

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

// [[[ INHERITANCE TESTING ]]]
////our void__method $inherited__Sort = sub { (my object $self, my string $person) = @_;  print "in Perl Sort->inherited__Sort(), have \$self = '$self' and \$person = '$person', FISH\n"; };
void RPerl__Algorithm__Sort::inherited__Sort(SV* person) { cout << "in CPPOPS_PERLTYPES Sort->inherited__Sort(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', FISH\n"; }

////our void__method $inherited = sub { (my object $self, my string $person) = @_;  print "in Perl Sort->inherited(), have \$self = '$self' and \$person = '$person', IN\n"; };
//void RPerl__Algorithm__Sort::inherited(SV* person) { cout << "in CPPOPS_PERLTYPES Sort->inherited(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', IN\n"; }

////our string $uninherited__Sort = sub { (my string $person) = @_;  print "in Perl Sort::uninherited__Sort(), \$person = '$person', MY\n";  return "Perl Sort::uninherited__Sort() RULES!"; };
SV* uninherited__Sort(SV* person) { cout << "in CPPOPS_PERLTYPES Sort::uninherited__Sort(), have $person = '" << SvPV_nolen(person) << "', MY\n";  return newSVpv("CPPOPS_PERLTYPES Sort::uninherited__Sort() RULES!", 0); }

////our string $uninherited = sub { (my string $person) = @_;  print "in Perl Sort::uninherited(), \$person = '$person', TROUSERS\n";  return "Perl Sort::uninherited() ROCKS!"; };
//SV* uninherited(SV* person) { cout << "in CPPOPS_PERLTYPES Sort::uninherited(), have $person = '" << SvPV_nolen(person) << "', TROUSERS\n";  return newSVpv("CPPOPS_PERLTYPES Sort::uninherited() RULES!", 0); }

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

void RPerl__Algorithm__Sort::inherited__Sort(string person) { cout << "in CPPOPS_CPPTYPES Sort->inherited__Sort(), have $self = '" << this << "' and $person = '" << person << "', FISH\n"; }
//void RPerl__Algorithm__Sort::inherited(string person) { cout << "in CPPOPS_CPPTYPES Sort->inherited(), have $self = '" << this << "' and $person = '" << person << "', IN\n"; }
string uninherited__Sort(string person) { cout << "in CPPOPS_CPPTYPES Sort::uninherited__Sort(), have $person = '" << person << "', MY\n";  return (string)"CPPOPS_CPPTYPES Sort::uninherited__Sort() RULES!"; }
//string uninherited(string person) { cout << "in CPPOPS_CPPTYPES Sort::uninherited(), have $person = '" << person << "', TETRAHEDRON\n";  return (string)"CPPOPS_CPPTYPES Sort::uninherited() RULES!"; }

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

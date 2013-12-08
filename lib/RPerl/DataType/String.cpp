////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__String_cpp
#define __CPP__INCLUDED__RPerl__DataType__String_cpp 1

#include <RPerl/DataType/String.h>		// -> NULL (relies on <string> being included via Inline::CPP's AUTO_INCLUDE config option)

// convert from (Perl SV containing string) to (C++ std::string)
string XS_unpack_string(SV* input_sv)
{
//	printf("in XS_unpack_string(), top of subroutine\n");

	string output_string;

	if (SvPOKp(input_sv)) { output_string = SvPV_nolen(input_sv); }
		else { croak("in XS_unpack_string(), input_sv was not a string"); }

//	printf("in XS_unpack_string(), bottom of subroutine\n");

	return(output_string);
}


// convert from (C++ std::string) to (Perl SV containing string)
void XS_pack_string(SV* output_sv, string input_string)
{
//	printf("in XS_pack_string(), top of subroutine\n");
//	cout << "in XS_pack_string(), have input_string = '" << input_string << "'" << endl;

	sv_setsv(output_sv, sv_2mortal(newSVpv(input_string.data(), input_string.size())));

//	printf("in XS_pack_string(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
//	printf("in XS_pack_string(), bottom of subroutine\n");
}


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* typetest___void__in___string__out() { return(newSVpv("Spice", 0)); }
SV* typetest___string__in___string__out(SV* fuzzword) { cout << "in C++ __PERL__TYPES cout<< String::typetest___string__in___string__out(), have fuzzword '" << SvPV_nolen(fuzzword) << "', BAZBOT" << endl;  return(newSVpvf("%s%s", SvPV_nolen(fuzzword), "FUZZ")); }
# elif defined __CPP__TYPES
string typetest___void__in___string__out() { string retval = "Spice";  return(retval); }
//string typetest___string__in___string__out(string fuzzword) { printf("in C++ printf() String::typetest___string__in___string__out(), have fuzzword '%s', BAZBOT\n", fuzzword.data());  return(fuzzword + "FUZZ"); }
string typetest___string__in___string__out(string fuzzword) { cout << "in C++ __CPP__TYPES cout<< String::typetest___string__in___string__out(), have fuzzword '" << fuzzword << "', BAZBOT" << endl;  return(fuzzword + "FUZZ"); }
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

#endif

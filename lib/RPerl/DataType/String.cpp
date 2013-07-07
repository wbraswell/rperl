////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__String_cpp
#define __CPP__INCLUDED__RPerl__DataType__String_cpp 1

#include <RPerl/DataType/String.h>		// -> NULL (relies on <string> being included via Inline::CPP's AUTO_INCLUDE config option)

// convert from (Perl SV containing string) to (C++ std::string)
string XS_unpack_string(SV *input_sv)
{
//	printf("in XS_unpack_string(), top of subroutine\n");

	string output_string;

	if (SvPOKp(input_sv)) { output_string = SvPV_nolen(input_sv); }
		else { croak("in XS_unpack_string(), input_sv was not a string"); }

//	printf("in XS_unpack_string(), bottom of subroutine\n");

	return(output_string);
}


// convert from (C++ std::string) to (Perl SV containing string)
void XS_pack_string(SV *output_sv, string input_string)
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
string typetest___void__in___string__out() { string retval = "Spice";  return(retval); }
//string typetest___string__in___string__out(string fuzzword) { printf("in C++ printf() String::typetest___string__in___string__out(), have fuzzword '%s', BAZBOT\n", fuzzword.data());  return(fuzzword + "FUZZ"); }
string typetest___string__in___string__out(string fuzzword) { cout << "in C++ cout<< String::typetest___string__in___string__out(), have fuzzword '" << fuzzword << "', BAZBOT" << endl;  return(fuzzword + "FUZZ"); }

#endif

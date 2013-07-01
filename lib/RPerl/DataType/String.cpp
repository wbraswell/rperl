////use strict;  use warnings;
using std::cout;  using std::endl;

#include <RPerl/DataType/String.h>		// -> NULL (relies on <string> being included via Inline::CPP's AUTO_INCLUDE config option)

#ifndef __CPP__INCLUDED__RPerl__DataType__String_cpp

// convert from FOOBAZ		Perl -> C++
string XS_unpack_string(SV *input_sv)
{
	printf("in XS_unpack_string(), top of subroutine\n");

	string output_string;

	if (SvPOKp(input_sv)) { output_string = SvPV_nolen(input_sv); }
		else { croak("in XS_unpack_string(), input_sv was not a string"); }

	printf("in XS_unpack_string(), bottom of subroutine\n");

	return(output_string);
}


// convert from BAZFOO		C++ -> Perl
void XS_pack_string(SV *output_sv, string input_string)
{
	printf("in XS_pack_string(), top of subroutine\n");

	output_sv = sv_2mortal(newSVpv(input_string.data(), input_string.size()));

    dSP;



    // START HERE:  test strings more and clean up this file, then do string arrays, then hashes


// NEED ANSWER: is this correct???
//	ENTER;
//	SAVETMPS;
//	PUSHMARK(SP);
    XPUSHs(output_sv);
//	PUTBACK;
//	SPAGAIN;
//	FREETMPS;
//	LEAVE;

	printf("in XS_pack_string(), bottom of subroutine\n");
}


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//void typetest___string__in___void__out(string fuzzword) { printf("in C++ CPP_TYPES printf() String::typetest___string__in___void__out(), have fuzzword '%s', BAZBOT\n", fuzzword.data()); }
void typetest___string__in___void__out(string fuzzword) { cout << "in C++ CPP_TYPES cout<< String::typetest___string__in___void__out(), have fuzzword '" << fuzzword << "', BAZBOT" << endl; }
string typetest___void__in___string__out() { string retval = "Spice";  return(retval); }


#endif
#define __CPP__INCLUDED__RPerl__DataType__String_cpp 1

////use strict;  use warnings;
using std::cout;  using std::endl;

// VERSION 0.2.4

#ifndef __CPP__INCLUDED__RPerl__DataType__String_cpp
#define __CPP__INCLUDED__RPerl__DataType__String_cpp 1

#include <RPerl/DataType/String.h>		// -> NULL (relies on native C type)

// [[[ TYPE CHECKING ]]]
// [[[ TYPE CHECKING ]]]
// [[[ TYPE CHECKING ]]]

// TYPE-CHECKING SUBROUTINES DEPRECATED IN FAVOR OF EQUIVALENT MACROS
/*
void CHECK_STRING(SV* possible_string) {
    if (not(SvOK(possible_string))) {
    	croak("\nERROR EPV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found,\ncroaking");
    }
	if (not(SvPOKp(possible_string))) {
    	croak("\nERROR EPV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found,\ncroaking");
    }
};
void CHECKTRACE_STRING(SV* possible_string, const char* variable_name, const char* subroutine_name) {
    if (not(SvOK(possible_string))) {
    	croak("\nERROR EPV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking",
    			variable_name, subroutine_name);
    }
	if (not(SvPOKp(possible_string))) {
    	croak("\nERROR EPV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found,\nin variable '%s' from subroutine '%s',\ncroaking",
    			variable_name, subroutine_name);
    }
};
*/

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES

// convert from (Perl SV containing string) to (C++ std::string)
string XS_unpack_string(SV* input_sv)
{
//printf("in CPPOPS_CPPTYPES XS_unpack_string(), top of subroutine\n");
//	CHECK_STRING(input_sv);
	CHECKTRACE_STRING(input_sv, "input_sv", "XS_unpack_string()");
//	string output_string;
//	output_string = SvPV_nolen(input_sv);
//printf("in CPPOPS_CPPTYPES XS_unpack_string(), bottom of subroutine\n");
	return((string)SvPV_nolen(input_sv));
//	return(output_string);
}

// convert from (C++ std::string) to (Perl SV containing string)
void XS_pack_string(SV* output_sv, string input_string) {
//printf("in CPPOPS_CPPTYPES XS_pack_string(), top of subroutine\n");
//printf("in CPPOPS_CPPTYPES XS_pack_string(), received input_string = '%s'\n", input_string.c_str());

	sv_setsv(output_sv, sv_2mortal(newSVpv(input_string.data(), input_string.size())));

//printf("in CPPOPS_CPPTYPES XS_pack_string(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
//printf("in CPPOPS_CPPTYPES XS_pack_string(), bottom of subroutine\n");
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* stringify_string(SV* input_sv)
{
    string input_sv_string;
    size_t input_sv_string_pos;

//	CHECK_STRING(input_sv);
	CHECKTRACE_STRING(input_sv, "input_sv", "stringify_string()");

	input_sv_string = SvPV_nolen(input_sv);

printf("in CPPOPS_PERLTYPES stringify_string(), received input_sv_string =\n%s\n\n", input_sv_string.c_str());

	// escape all back-slash \ and single-quote ' characters with a back-slash \ character
	input_sv_string = string(SvPV_nolen(input_sv));
	input_sv_string_pos = 0;
	while((input_sv_string_pos = input_sv_string.find("\\", input_sv_string_pos)) != string::npos)
	{
		input_sv_string.replace(input_sv_string_pos, 1, "\\\\");
		input_sv_string_pos += 2;
	}
	input_sv_string_pos = 0;
	while((input_sv_string_pos = input_sv_string.find("'", input_sv_string_pos)) != string::npos)
	{
		input_sv_string.replace(input_sv_string_pos, 1, "\\'");
		input_sv_string_pos += 2;
	}

	input_sv_string = "'" + input_sv_string + "'";

printf("in CPPOPS_PERLTYPES stringify_string(), bottom of subroutine, returning possibly-modified input_sv_string =\n%s\n\n", input_sv_string.c_str());

	return(newSVpvf("%s", input_sv_string.c_str()));
}

# elif defined __CPP__TYPES

string stringify_string(string input_string)
{
printf("in CPPOPS_CPPTYPES stringify_string(), top of subroutine, received input_string =\n%s\n\n", input_string.c_str());

    size_t input_string_pos;

	// escape all back-slash \ and single-quote ' characters with a back-slash \ character
	input_string_pos = 0;
	while((input_string_pos = input_string.find("\\", input_string_pos)) != string::npos)
	{
		input_string.replace(input_string_pos, 1, "\\\\");
		input_string_pos += 2;
	}
	input_string_pos = 0;
	while((input_string_pos = input_string.find("'", input_string_pos)) != string::npos)
	{
		input_string.replace(input_string_pos, 1, "\\'");
		input_string_pos += 2;
	}

	input_string = "'" + input_string + "'";

printf("in CPPOPS_CPPTYPES stringify_string(), bottom of subroutine, returning possibly-modified input_string =\n%s\n\n", input_string.c_str());

	return(input_string);
}

# endif

//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* typetest___void__in___string__out() {
printf("in CPPOPS_PERLTYPES typetest___void__in___string__out()\n");
	return(newSVpv("Spice CPPOPS_PERLTYPES", 0));
}

SV* typetest___string__in___string__out(SV* lucky_string) {
//	CHECK_STRING(lucky_string);
	CHECKTRACE_STRING(lucky_string, "lucky_string", "typetest___string__in___string__out()");
//cout << "in CPPOPS_PERLTYPES typetest___string__in___string__out(), received lucky_string '" << SvPV_nolen(lucky_string) << "'" << endl;
printf("in CPPOPS_PERLTYPES typetest___string__in___string__out(), received lucky_string = '%s'\n", SvPV_nolen(lucky_string));
	return(newSVpvf("%s%s", SvPV_nolen(stringify_string(lucky_string)), " CPPOPS_PERLTYPES"));
}

# elif defined __CPP__TYPES

string typetest___void__in___string__out() {
	string retval = "Spice CPPOPS_CPPTYPES";
printf("in CPPOPS_CPPTYPES typetest___void__in___string__out(), have retval = '%s'\n", retval.c_str());
	return(retval);
}

string typetest___string__in___string__out(string lucky_string) {
printf("in CPPOPS_CPPTYPES typetest___string__in___string__out(), received lucky_string = '%s'\n", lucky_string.c_str());
	return(stringify_string(lucky_string) + " CPPOPS_CPPTYPES");
}

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

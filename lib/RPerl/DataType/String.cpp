////use strict;  use warnings;
using std::cout;  using std::endl;

// VERSION 0.3.0

#ifndef __CPP__INCLUDED__RPerl__DataType__String_cpp
#define __CPP__INCLUDED__RPerl__DataType__String_cpp 1

#include <RPerl/DataType/String.h>		// -> NULL (relies on native C type)

// [[[ TYPE CHECKING ]]]
// [[[ TYPE CHECKING ]]]
// [[[ TYPE CHECKING ]]]

// TYPE-CHECKING SUBROUTINES DEPRECATED IN FAVOR OF EQUIVALENT MACROS
/*
void string__CHECK(SV* possible_string) {
    if (not(SvOK(possible_string))) {
    	croak("\nERROR EPV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found,\ncroaking");
    }
	if (not(SvPOKp(possible_string))) {
    	croak("\nERROR EPV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found,\ncroaking");
    }
};
void string__CHECKTRACE(SV* possible_string, const char* variable_name, const char* subroutine_name) {
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
//	string__CHECK(input_sv);
	string__CHECKTRACE(input_sv, "input_sv", "XS_unpack_string()");
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

SV* string__stringify(SV* input_sv)
{
    string input_sv_string;
    size_t input_sv_string_pos;

//	string__CHECK(input_sv);
	string__CHECKTRACE(input_sv, "input_sv", "string__stringify()");

	input_sv_string = SvPV_nolen(input_sv);

printf("in CPPOPS_PERLTYPES string__stringify(), received input_sv_string =\n%s\n\n", input_sv_string.c_str());

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

printf("in CPPOPS_PERLTYPES string__stringify(), bottom of subroutine, returning possibly-modified input_sv_string =\n%s\n\n", input_sv_string.c_str());

	return(newSVpvf("%s", input_sv_string.c_str()));
}

# elif defined __CPP__TYPES

string string__stringify(string input_string)
{
printf("in CPPOPS_CPPTYPES string__stringify(), top of subroutine, received input_string =\n%s\n\n", input_string.c_str());

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

printf("in CPPOPS_CPPTYPES string__stringify(), bottom of subroutine, returning possibly-modified input_string =\n%s\n\n", input_string.c_str());

	return(input_string);
}

# endif

//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* string__typetest0() {
printf("in CPPOPS_PERLTYPES string__typetest0()\n");
	return(newSVpv("Spice CPPOPS_PERLTYPES", 0));
}

SV* string__typetest1(SV* lucky_string) {
//	string__CHECK(lucky_string);
	string__CHECKTRACE(lucky_string, "lucky_string", "string__typetest1()");
//cout << "in CPPOPS_PERLTYPES string__typetest1(), received lucky_string '" << SvPV_nolen(lucky_string) << "'" << endl;
printf("in CPPOPS_PERLTYPES string__typetest1(), received lucky_string = '%s'\n", SvPV_nolen(lucky_string));
	return(newSVpvf("%s%s", SvPV_nolen(string__stringify(lucky_string)), " CPPOPS_PERLTYPES"));
}

# elif defined __CPP__TYPES

string string__typetest0() {
	string retval = "Spice CPPOPS_CPPTYPES";
printf("in CPPOPS_CPPTYPES string__typetest0(), have retval = '%s'\n", retval.c_str());
	return(retval);
}

string string__typetest1(string lucky_string) {
printf("in CPPOPS_CPPTYPES string__typetest1(), received lucky_string = '%s'\n", lucky_string.c_str());
	return(string__stringify(lucky_string) + " CPPOPS_CPPTYPES");
}

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

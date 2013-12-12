////use strict;  use warnings;
using std::cout;  using std::endl;

// VERSION 0.2.1

#ifndef __CPP__INCLUDED__RPerl__DataType__String_cpp
#define __CPP__INCLUDED__RPerl__DataType__String_cpp 1

#include <RPerl/DataType/String.h>		// -> NULL (relies on native C type)

// [[[ TYPE CHECKING ]]]
// [[[ TYPE CHECKING ]]]
// [[[ TYPE CHECKING ]]]

void check_string(SV* possible_string) {
    if (not(SvOK(possible_string))) { croak("in CPPOPS_BOTHTYPES check_string(), possible_string was undef and/or NULL, croaking"); }
	if (not(SvPOKp(possible_string))) { croak("in CPPOPS_BOTHTYPES check_string(), possible_string was not a string, croaking"); }
};

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES

// convert from (Perl SV containing string) to (C++ std::string)
string XS_unpack_string(SV* input_sv)
{
//printf("in CPPOPS_CPPTYPES XS_unpack_string(), top of subroutine\n");
	check_string(input_sv);
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

//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* typetest___void__in___string__out() {
printf("in CPPOPS_PERLTYPES typetest___void__in___string__out()\n");
	return(newSVpv("Spice CPPOPS_PERLTYPES", 0));
}

SV* typetest___string__in___string__out(SV* lucky_string) {
	check_string(lucky_string);
//cout << "in CPPOPS_PERLTYPES typetest___string__in___string__out(), received lucky_string '" << SvPV_nolen(lucky_string) << "'" << endl;
printf("in CPPOPS_PERLTYPES typetest___string__in___string__out(), received lucky_string = '%s'\n", SvPV_nolen(lucky_string));
	return(newSVpvf("%s%s", SvPV_nolen(lucky_string), " CPPOPS_PERLTYPES"));
}

# elif defined __CPP__TYPES

string typetest___void__in___string__out() {
	string retval = "Spice CPPOPS_CPPTYPES";
printf("in CPPOPS_CPPTYPES typetest___void__in___string__out(), have retval = '%s'\n", retval.c_str());
	return(retval);
}

string typetest___string__in___string__out(string lucky_string) {
printf("in CPPOPS_CPPTYPES typetest___string__in___string__out(), received lucky_string = '%s'\n", lucky_string.c_str());
	return(lucky_string + " CPPOPS_CPPTYPES");
}

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

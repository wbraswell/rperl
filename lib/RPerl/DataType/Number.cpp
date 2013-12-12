////use strict;  use warnings;
using std::cout;  using std::endl;

// VERSION 0.2.1

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_cpp
#define __CPP__INCLUDED__RPerl__DataType__Number_cpp 1

#include <RPerl/DataType/Number.h>		// -> NULL (relies on native C type)

// [[[ TYPE CHECKING ]]]
// [[[ TYPE CHECKING ]]]
// [[[ TYPE CHECKING ]]]

void check_number(SV* possible_number) {
    if (not(SvOK(possible_number))) { croak("in CPPOPS_BOTHTYPES check_number(), possible_number was undef and/or NULL, croaking"); }
	if (not(SvNOKp(possible_number) || SvIOKp(possible_number))) { croak("in CPPOPS_BOTHTYPES check_number(), possible_number was not a number, croaking"); }
};

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES

// convert from (Perl SV containing number) to (C number)
number XS_unpack_number(SV* input_sv) {
printf("in CPPOPS_CPPTYPES XS_unpack_number(), top of subroutine\n");
	check_number(input_sv);

//	number output_number;

//	if (SvNOKp(input_sv)) { output_number = SvNV(input_sv); } else { croak("in CPPOPS_CPPTYPES XS_unpack_number(), input_sv was not a number"); }
//	output_number = SvNV(input_sv);

printf("in CPPOPS_CPPTYPES XS_unpack_number(), bottom of subroutine\n");

	return((number)SvNV(input_sv));
//	return(output_number);
}

// convert from (C number) to (Perl SV containing number)
void XS_pack_number(SV* output_sv, number input_number) {
printf("in CPPOPS_CPPTYPES XS_pack_number(), top of subroutine\n");
printf("in CPPOPS_CPPTYPES XS_pack_number(), received unformatted input_number = %Lf\n", input_number);

	sv_setsv(output_sv, sv_2mortal(newSVnv(input_number)));

printf("in CPPOPS_CPPTYPES XS_pack_number(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
printf("in CPPOPS_CPPTYPES XS_pack_number(), bottom of subroutine\n");
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* stringify_number(SV* input_number)
{
	check_number(input_number);
printf("in CPPOPS_PERLTYPES stringify_number(), top of subroutine, received unformatted input_number = %Lf\n", (number)SvNV(input_number));

	ostringstream output_stream;
	output_stream.precision(std::numeric_limits<double>::digits10);
	output_stream << SvNV(input_number);
	return(newSVpv((const char *)((output_stream.str()).c_str()), 0));

	// DEV NOTE: none of these printf()-type solutions count significant digits both before and after the decimal point,
	// so we fall back to utilizing C++ ostringstream which stringifies floating point numbers exactly the same as Perl (AFAICTSF)
//	return(newSVpvf("%16.32Lf", (long double)SvNV(input_number)));
//	return(newSVpvf("%"NVff"", SvNV(input_number)));
//	return(newSVpvf("%"NVff"", 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679));
}

# elif defined __CPP__TYPES

string stringify_number(number input_number)
{
printf("in CPPOPS_CPPTYPES stringify_number(), top of subroutine, received unformatted input_number = %Lf\n", input_number);
	ostringstream output_stream;
	output_stream.precision(std::numeric_limits<double>::digits10);
	output_stream << input_number;
	return(output_stream.str());
}

# endif

//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* typetest___void__in___number__out() {
	SV* retval = newSVnv((22.0 / 7.0) + OPS_TYPES_ID);
printf("in CPPOPS_PERLTYPES typetest___void__in___number__out(), have unformatted retval = %Lf\n", (number)SvNV(retval));
	return(retval);
}

SV* typetest___number__in___number__out(SV* lucky_number) {
	check_number(lucky_number);
printf("in CPPOPS_PERLTYPES typetest___number__in___number__out(), have received lucky_number = %Lf\n", (number)SvNV(lucky_number));
	return(newSVnv((SvNV(lucky_number) * 2.0) + OPS_TYPES_ID));
}

# elif defined __CPP__TYPES

number typetest___void__in___number__out() {
	number retval = (22.0 / 7.0) + OPS_TYPES_ID;
printf("in CPPOPS_CPPTYPES typetest___void__in___number__out(), have unformatted retval = %Lf\n", retval);
	return(retval);
}

number typetest___number__in___number__out(number lucky_number) {
	printf("in CPPOPS_CPPTYPES typetest___number__in___number__out(), received unformatted lucky_number = %Lf\n", lucky_number);
	return((lucky_number * 2.0) + OPS_TYPES_ID);
}

# endif

#endif

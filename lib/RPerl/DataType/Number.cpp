////use strict;  use warnings;
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_cpp
#define __CPP__INCLUDED__RPerl__DataType__Number_cpp 0.003_003

#include <RPerl/DataType/Number.h>		// -> NULL (relies on native C type)

// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]

// TYPE-CHECKING SUBROUTINES DEPRECATED IN FAVOR OF EQUIVALENT MACROS
/*
void number__CHECK(SV* possible_number) {
    if (not(SvOK(possible_number))) {
    	croak("\nERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\ncroaking");
    }
	if (not(SvNOKp(possible_number) || SvIOKp(possible_number))) {
    	croak("\nERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\ncroaking");
    }
};
void number__CHECKTRACE(SV* possible_number, const char* variable_name, const char* subroutine_name) {
    if (not(SvOK(possible_number))) {
    	croak("\nERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking",
    			variable_name, subroutine_name);
    }
	if (not(SvNOKp(possible_number) || SvIOKp(possible_number))) {
    	croak("\nERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\nin variable %s from subroutine %s,\ncroaking",
    			variable_name, subroutine_name);
    }
};
*/

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES

// convert from (Perl SV containing number) to (C number)
number XS_unpack_number(SV* input_sv) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number(), top of subroutine\n");
//	number__CHECK(input_sv);
	number__CHECKTRACE(input_sv, "input_sv", "XS_unpack_number()");

//	number output_number;

//	if (SvNOKp(input_sv)) { output_number = SvNV(input_sv); } else { croak("in CPPOPS_CPPTYPES XS_unpack_number(), input_sv was not a number"); }
//	output_number = SvNV(input_sv);

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number(), bottom of subroutine\n");

	return((number)SvNV(input_sv));
//	return(output_number);
}

// convert from (C number) to (Perl SV containing number)
void XS_pack_number(SV* output_sv, number input_number) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number(), top of subroutine\n");
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number(), received unformatted input_number = %Lf\n", input_number);

	sv_setsv(output_sv, sv_2mortal(newSVnv(input_number)));

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number(), bottom of subroutine\n");
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* number__stringify(SV* input_number)
{
//	number__CHECK(input_number);
	number__CHECKTRACE(input_number, "input_number", "number__stringify()");
//fprintf(stderr, "in CPPOPS_PERLTYPES number__stringify(), top of subroutine, received unformatted input_number = %Lf\n", (number)SvNV(input_number));

	ostringstream output_stream;
	output_stream.precision(std::numeric_limits<double>::digits10);
	output_stream << (long double)SvNV(input_number);
	return(newSVpv((const char *)((output_stream.str()).c_str()), 0));

	// DEV NOTE: none of these fprintf(stderr, )-type solutions count significant digits both before and after the decimal point,
	// so we fall back to utilizing C++ ostringstream which stringifies floating point numbers exactly the same as Perl (AFAICTSF)
//	return(newSVpvf("%16.32Lf", (long double)SvNV(input_number)));
//	return(newSVpvf("%"NVff"", SvNV(input_number)));
//	return(newSVpvf("%"NVff"", 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679));
}

# elif defined __CPP__TYPES

string number__stringify(number input_number)
{
//fprintf(stderr, "in CPPOPS_CPPTYPES number__stringify(), top of subroutine, received unformatted input_number = %Lf\n", input_number);
	ostringstream output_stream;
	output_stream.precision(std::numeric_limits<double>::digits10);
	output_stream << input_number;
	return(output_stream.str());
}

# endif

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* number__typetest0() {
	SV* retval = newSVnv((22.0 / 7.0) + number__OPS_TYPES_ID);
//fprintf(stderr, "in CPPOPS_PERLTYPES number__typetest0(), have unformatted retval = %Lf\n", (number)SvNV(retval));
	return(retval);
}

SV* number__typetest1(SV* lucky_number) {
//	number__CHECK(lucky_number);
	number__CHECKTRACE(lucky_number, "lucky_number", "number__typetest1()");
//fprintf(stderr, "in CPPOPS_PERLTYPES number__typetest1(), have received lucky_number = %Lf\n", (number)SvNV(lucky_number));
	return(newSVnv((SvNV(lucky_number) * 2.0) + number__OPS_TYPES_ID));
}

# elif defined __CPP__TYPES

number number__typetest0() {
	number retval = (22.0 / 7.0) + number__OPS_TYPES_ID;
//fprintf(stderr, "in CPPOPS_CPPTYPES number__typetest0(), have unformatted retval = %Lf\n", retval);
	return(retval);
}

number number__typetest1(number lucky_number) {
	//fprintf(stderr, "in CPPOPS_CPPTYPES number__typetest1(), received unformatted lucky_number = %Lf\n", lucky_number);
	return((lucky_number * 2.0) + number__OPS_TYPES_ID);
}

# endif

#endif

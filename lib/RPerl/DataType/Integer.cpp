////use strict;  use warnings;
//using std::cout;  using std::endl;  // not needed for integer?

#ifndef __CPP__INCLUDED__RPerl__DataType__Integer_cpp
#define __CPP__INCLUDED__RPerl__DataType__Integer_cpp 0.003002

#include <RPerl/DataType/Integer.h>		// -> NULL (relies on native C type)

// [[[ TYPE-CHECKING SUBROUTINES ]]]
// [[[ TYPE-CHECKING SUBROUTINES ]]]
// [[[ TYPE-CHECKING SUBROUTINES ]]]

// DEPRECATED IN FAVOR OF EQUIVALENT MACROS
/*
void CHECK(SV* possible_integer) {
    if (not(SvOK(possible_integer))) {
    	croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found,\ncroaking");
    }
	if (not(SvIOKp(possible_integer))) {
    	croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found,\ncroaking");
    }
};
void CHECKTRACE(SV* possible_integer, const char* variable_name, const char* subroutine_name) {
    if (not(SvOK(possible_integer))) {
    	croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking",
    			variable_name, subroutine_name);
    }
	if (not(SvIOKp(possible_integer))) {
    	croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found,\nin variable %s from subroutine %s,\ncroaking",
    			variable_name, subroutine_name);
    }
};
*/

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES

// convert from (Perl SV containing integer) to (C integer)
integer XS_unpack_integer(SV* input_sv) {
printf("in CPPOPS_CPPTYPES XS_unpack_integer(), top of subroutine\n");
//	integer__CHECK(input_sv);
	integer__CHECKTRACE(input_sv, "input_sv", "XS_unpack_integer()");

//	integer output_integer;

//	if (SvIOKp(input_sv)) { output_integer = SvIV(input_sv); } else { croak("in CPPOPS_CPPTYPES XS_unpack_integer(), input_sv was not an integer"); }
//	output_integer = SvIV(input_sv);

printf("in CPPOPS_CPPTYPES XS_unpack_integer(), bottom of subroutine\n");

	return((integer)SvIV(input_sv));
//	return(output_integer);
}

// convert from (C integer) to (Perl SV containing integer)
void XS_pack_integer(SV* output_sv, integer input_integer) {
printf("in CPPOPS_CPPTYPES XS_pack_integer(), top of subroutine\n");
printf("in CPPOPS_CPPTYPES XS_pack_integer(), received input_integer = %d\n", input_integer);

	sv_setsv(output_sv, sv_2mortal(newSViv(input_integer)));

printf("in CPPOPS_CPPTYPES XS_pack_integer(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
printf("in CPPOPS_CPPTYPES XS_pack_integer(), bottom of subroutine\n");
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* integer__stringify(SV* input_integer)
{
//	integer__CHECK(input_integer);
	integer__CHECKTRACE(input_integer, "input_integer", "integer__stringify()");
printf("in CPPOPS_PERLTYPES integer__stringify(), bottom of subroutine, received input_integer = %d\n", (integer)SvIV(input_integer));
	return(newSVpvf("%d", (integer)SvIV(input_integer)));
}

# elif defined __CPP__TYPES

string integer__stringify(integer input_integer)
{
printf("in CPPOPS_CPPTYPES integer__stringify(), top of subroutine, received input_integer = %d\n", input_integer);
	string output_string = "";
	sprintf((char*)output_string.c_str(), "%d", input_integer);
	return(output_string);
}

# endif

//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* integer__typetest0() {
	SV* retval = newSViv((21 / 7) + integer__OPS_TYPES_ID);
printf("in CPPOPS_PERLTYPES integer__typetest0(), have retval = %d\n", (integer)SvIV(retval));
	return(retval);
}

SV* integer__typetest1(SV* lucky_integer) {
//	integer__CHECK(lucky_integer);
	integer__CHECKTRACE(lucky_integer, "lucky_integer", "integer__typetest1()");
printf("in CPPOPS_PERLTYPES integer__typetest1(), received lucky_integer = %d\n", (integer)SvIV(lucky_integer));
	return(newSViv((SvIV(lucky_integer) * 2) + integer__OPS_TYPES_ID));
}

# elif defined __CPP__TYPES

integer integer__typetest0() {
	integer retval = (21 / 7) + integer__OPS_TYPES_ID;
printf("in CPPOPS_CPPTYPES integer__typetest0(), have retval = %d\n", retval);
	return(retval);
}

integer integer__typetest1(integer lucky_integer) {
printf("in CPPOPS_CPPTYPES integer__typetest1(), received lucky_integer = %d\n", lucky_integer);
	return((lucky_integer * 2) + integer__OPS_TYPES_ID);
}

# endif

#endif

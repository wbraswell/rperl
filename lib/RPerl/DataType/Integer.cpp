using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Integer_cpp
#define __CPP__INCLUDED__RPerl__DataType__Integer_cpp 0.005_100

// [[[ INCLUDES ]]]
#include <RPerl/DataType/Integer.h>  // -> NULL (relies on native C type)
// DEV NOTE, CORRELATION #rp12: the only actual includes-level dependency between any of the RPerl core data types should be String.cpp to avoid
// error: ‘XS_pack_string’ was not declared in this scope
#include <RPerl/DataType/String.cpp>  // -> String.h

// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]

// TYPE-CHECKING SUBROUTINES DEPRECATED IN FAVOR OF EQUIVALENT MACROS
/*
void integer_CHECK(SV* possible_integer) {
    if (not(SvOK(possible_integer))) {
    	croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found,\ncroaking");
    }
	if (not(SvIOKp(possible_integer))) {
    	croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found,\ncroaking");
    }
};
void integer_CHECKTRACE(SV* possible_integer, const char* variable_name, const char* subroutine_name) {
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

// DEV NOTE, CORRELATION #rp10: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES

// convert from (Perl SV containing integer) to (C integer)
integer XS_unpack_integer(SV* input_sv) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer(), top of subroutine\n");
//	integer_CHECK(input_sv);
	integer_CHECKTRACE(input_sv, "input_sv", "XS_unpack_integer()");

//	integer output_integer;

//	if (SvIOKp(input_sv)) { output_integer = SvIV(input_sv); } else { croak("in CPPOPS_CPPTYPES XS_unpack_integer(), input_sv was not an integer"); }
//	output_integer = SvIV(input_sv);

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer(), bottom of subroutine\n");

	return((integer)SvIV(input_sv));
//	return(output_integer);
}

// convert from (C integer) to (Perl SV containing integer)
void XS_pack_integer(SV* output_sv, integer input_integer) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer(), top of subroutine\n");
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer(), received input_integer = %d\n", input_integer);

	sv_setsv(output_sv, sv_2mortal(newSViv(input_integer)));

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer(), bottom of subroutine\n");
}

//# endif

// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* integer_to_unsigned_integer(SV* input_integer) {
//  integer_CHECK(input_integer);
    integer_CHECKTRACE(input_integer, "input_integer", "integer_to_unsigned_integer()");
    return(input_integer);
}

# elif defined __CPP__TYPES

unsigned int integer_to_unsigned_integer(integer input_integer) {
    return input_integer;
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* integer_to_string(SV* input_integer) {
//	integer_CHECK(input_integer);
	integer_CHECKTRACE(input_integer, "input_integer", "integer_to_string()");
//	fprintf(stderr, "in CPPOPS_PERLTYPES integer_to_string(), top of subroutine, received unformatted input_integer = %d\n", (integer)SvIV(input_integer));
//	fprintf(stderr, "in CPPOPS_PERLTYPES integer_to_string()...\n");

    // DEV NOTE: disable old stringify w/out underscores
//	return(newSVpvf("%d", (integer)SvIV(input_integer)));

    return(newSVpv((const char *)((integer_to_string_CPPTYPES((integer)SvIV(input_integer))).c_str()), 0));
}

# elif defined __CPP__TYPES

// DEV NOTE, CORRELATION #rp10: shim CPPTYPES sub
string integer_to_string(integer input_integer) {
    return(integer_to_string_CPPTYPES(input_integer));
}

# endif

// DEV NOTE, CORRELATION #rp09: must use return type 'string' instead of 'std::string' for proper typemap pack/unpack function name alignment;
// can cause silent failure, falling back to __PERL__TYPES implementation and NOT failure of tests!
// DEV NOTE, CORRELATION #rp10: the real CPPTYPES sub (below) is called by the wrapper PERLTYPES sub and shim CPPTYPES subs (above), moved outside #ifdef blocks
string integer_to_string_CPPTYPES(integer input_integer)
{
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string_CPPTYPES(), top of subroutine, received unformatted input_integer = %d\n", input_integer);
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string_CPPTYPES()...\n");

    std::ostringstream output_stream;
    output_stream.precision(std::numeric_limits<double>::digits10);
    output_stream << input_integer;

    // DEV NOTE: disable old stringify w/out underscores
//  return(output_stream.str());

    string output_string = output_stream.str();
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string_CPPTYPES(), have output_string = %s\n", output_string.c_str());

    boolean is_negative = 0;
    if (input_integer < 0) { is_negative = 1; }

    std::reverse(output_string.begin(), output_string.end());

//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string_CPPTYPES(), have reversed output_string = %s\n", output_string.c_str());
    if (is_negative) { output_string.pop_back(); }  // remove negative sign

    string output_string_underscores = "";
    for(std::string::size_type i = 0; i < output_string.size(); ++i) {
//        fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string_CPPTYPES(), inside output_string underscore loop, have i = %d, output_string[i] = %c\n", (int)i, output_string[i]);
        output_string_underscores += output_string[i];
        if (((i % 3) == 2) && (i > 0) && (i != (output_string.size() - 1))) {
//            fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string_CPPTYPES(), AND UNDERSCORE \n");
            output_string_underscores += '_';
        }
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string_CPPTYPES(), have reversed output_string_underscores = %s\n", output_string_underscores.c_str());

    std::reverse(output_string_underscores.begin(), output_string_underscores.end());

    if (output_string_underscores == "") {
        output_string_underscores = "0";
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string_CPPTYPES(), have unreversed output_string_underscores = %s\n", output_string_underscores.c_str());

    if (is_negative) { output_string_underscores = '-' + output_string_underscores; }

    return(output_string_underscores);
}

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* integer__typetest0() {
	SV* retval = newSViv((21 / 7) + SvIV(RPerl__DataType__Integer__MODE_ID()));
//fprintf(stderr, "in CPPOPS_PERLTYPES integer__typetest0(), have retval = %d\n", (integer)SvIV(retval));
	return(retval);
}

SV* integer__typetest1(SV* lucky_integer) {
//	integer_CHECK(lucky_integer);
	integer_CHECKTRACE(lucky_integer, "lucky_integer", "integer__typetest1()");
//fprintf(stderr, "in CPPOPS_PERLTYPES integer__typetest1(), received lucky_integer = %d\n", (integer)SvIV(lucky_integer));
	return(newSViv((SvIV(lucky_integer) * 2) + SvIV(RPerl__DataType__Integer__MODE_ID())));
}

# elif defined __CPP__TYPES

integer integer__typetest0() {
	integer retval = (21 / 7) + RPerl__DataType__Integer__MODE_ID();
//fprintf(stderr, "in CPPOPS_CPPTYPES integer__typetest0(), have retval = %d\n", retval);
	return(retval);
}

integer integer__typetest1(integer lucky_integer) {
//fprintf(stderr, "in CPPOPS_CPPTYPES integer__typetest1(), received lucky_integer = %d\n", lucky_integer);
	return((lucky_integer * 2) + RPerl__DataType__Integer__MODE_ID());
}

# endif

#endif

using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Integer_cpp
#define __CPP__INCLUDED__RPerl__DataType__Integer_cpp 0.011_000

// [[[ INCLUDES ]]]
#include <RPerl/DataType/Integer.h>  // -> NULL (relies on native C type)
#include <RPerl/DataType/Boolean.cpp>  // -> Boolean.h
#include <RPerl/DataType/UnsignedInteger.cpp>  // -> UnsignedInteger.h
#include <RPerl/DataType/Number.cpp>  // -> Number.h
#include <RPerl/DataType/Character.cpp>  // -> Character.h
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

// DEV NOTE, CORRELATION #rp010: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
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
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer(), received input_integer = %"INTEGER"\n", input_integer);

	sv_setsv(output_sv, sv_2mortal(newSViv(input_integer)));

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer(), bottom of subroutine\n");
}

//# endif

// [[[ BOOLEANIFY ]]]
// [[[ BOOLEANIFY ]]]
// [[[ BOOLEANIFY ]]]

# ifdef __PERL__TYPES

SV* integer_to_boolean(SV* input_integer) {
//  integer_CHECK(input_integer);
    integer_CHECKTRACE(input_integer, "input_integer", "integer_to_boolean()");
    if (SvIV(input_integer) == 0) { return input_integer; }
    else { return newSViv(1); }
}

# elif defined __CPP__TYPES

boolean integer_to_boolean(integer input_integer) {
    if (input_integer == 0) { return (boolean) input_integer; }
    else { return 1; }
}

# endif

// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* integer_to_unsigned_integer(SV* input_integer) {
//  integer_CHECK(input_integer);
    integer_CHECKTRACE(input_integer, "input_integer", "integer_to_unsigned_integer()");
    if (SvIV(input_integer) < 0) { return newSViv(SvIV(input_integer) * -1); }
    else { return input_integer; }
}

# elif defined __CPP__TYPES

unsigned_integer integer_to_unsigned_integer(integer input_integer) {
    if (input_integer < 0) { return (unsigned_integer) (input_integer * -1); }
    else { return (unsigned_integer) input_integer; }
}

# endif

// [[[ NUMBERIFY ]]]
// [[[ NUMBERIFY ]]]
// [[[ NUMBERIFY ]]]

# ifdef __PERL__TYPES

SV* integer_to_number(SV* input_integer) {
//  integer_CHECK(input_integer);
    integer_CHECKTRACE(input_integer, "input_integer", "integer_to_number()");
    return input_integer;
}

# elif defined __CPP__TYPES

// NEED DECIDE: use #define for speed or function for type checking???
//#define integer_to_number(INPUT_INTEGER) (number) INPUT_INTEGER
number integer_to_number(integer input_integer) { return (number) input_integer; }

# endif

// [[[ CHARACTERIFY ]]]
// [[[ CHARACTERIFY ]]]
// [[[ CHARACTERIFY ]]]

# ifdef __PERL__TYPES

/* DISABLE UNTIL COMPLETE, TO AVOID C++ COMPILER WARNINGS
SV* integer_to_character(SV* input_integer) {
//  integer_CHECK(input_integer);
    integer_CHECKTRACE(input_integer, "input_integer", "integer_to_character()");
    // NEED ADD CODE
}
*/

# elif defined __CPP__TYPES

character integer_to_character(integer input_integer) {
    // NEED OPTIMIZE: remove call to integer_to_string_CPPTYPES()
    return (character) integer_to_string_CPPTYPES(input_integer).at(0);
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* integer_to_string(SV* input_integer) {
//	integer_CHECK(input_integer);
	integer_CHECKTRACE(input_integer, "input_integer", "integer_to_string()");
//	fprintf(stderr, "in CPPOPS_PERLTYPES integer_to_string(), top of subroutine, received unformatted input_integer = %"INTEGER"\n", (integer)SvIV(input_integer));
//	fprintf(stderr, "in CPPOPS_PERLTYPES integer_to_string()...\n");

    // DEV NOTE: disable old stringify w/out underscores
//	return(newSVpvf("%"INTEGER"", (integer)SvIV(input_integer)));

    return(newSVpv((const char *)((integer_to_string_CPPTYPES((integer)SvIV(input_integer))).c_str()), 0));
}

# elif defined __CPP__TYPES

string to_string(integer input_integer) {
    fprintf(stderr, "in CPPOPS_CPPTYPES to_string(), about to call integer_to_string & return value...\n");
    return(integer_to_string(input_integer));
}

// DEV NOTE, CORRELATION #rp010: shim CPPTYPES sub
string integer_to_string(integer input_integer) {
    fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string(), about to call integer_to_string_CPPTYPES() & return value...\n");
    return(integer_to_string_CPPTYPES(input_integer));
}

# endif

// DEV NOTE, CORRELATION #rp009: must use return type 'string' instead of 'std::string' for proper typemap pack/unpack function name alignment;
// can cause silent failure, falling back to __PERL__TYPES implementation and NOT failure of tests!
// DEV NOTE, CORRELATION #rp010: the real CPPTYPES sub (below) is called by the wrapper PERLTYPES sub and shim CPPTYPES subs (above), moved outside #ifdef blocks
string integer_to_string_CPPTYPES(integer input_integer)
{
    fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string_CPPTYPES(), top of subroutine, received unformatted input_integer = %"INTEGER"\n", input_integer);
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

// [ INTENTIONALLY LEFT BLANK TO ALIGN WITH Number.cpp ]








// [ INTENTIONALLY LEFT BLANK TO ALIGN WITH Number.cpp ]

    std::reverse(output_string.begin(), output_string.end());

//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string_CPPTYPES(), have reversed output_string = %s\n", output_string.c_str());
    if (is_negative) { output_string.pop_back(); }  // remove negative sign

    string output_string_underscores = "";
    for(std::string::size_type i = 0; i < output_string.size(); ++i) {
//        fprintf(stderr, "in CPPOPS_CPPTYPES integer_to_string_CPPTYPES(), inside output_string underscore loop, have i = %"INTEGER", output_string[i] = %c\n", (int)i, output_string[i]);
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

// [ INTENTIONALLY LEFT BLANK TO ALIGN WITH Number.cpp ]











// [ INTENTIONALLY LEFT BLANK TO ALIGN WITH Number.cpp ]

    if (is_negative) { output_string_underscores = '-' + output_string_underscores; }

    return output_string_underscores;
}

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* integer_typetest0() {
	SV* retval = newSViv((21 / 7) + SvIV(RPerl__DataType__Integer__MODE_ID()));
//fprintf(stderr, "in CPPOPS_PERLTYPES integer_typetest0(), have retval = %"INTEGER"\n", (integer)SvIV(retval));
	return retval;
}

SV* integer_typetest1(SV* lucky_integer) {
//	integer_CHECK(lucky_integer);
	integer_CHECKTRACE(lucky_integer, "lucky_integer", "integer_typetest1()");
//fprintf(stderr, "in CPPOPS_PERLTYPES integer_typetest1(), received lucky_integer = %"INTEGER"\n", (integer)SvIV(lucky_integer));
	return newSViv((SvIV(lucky_integer) * 2) + SvIV(RPerl__DataType__Integer__MODE_ID()));
}

# elif defined __CPP__TYPES

integer integer_typetest0() {
	integer retval = (21 / 7) + RPerl__DataType__Integer__MODE_ID();
//fprintf(stderr, "in CPPOPS_CPPTYPES integer_typetest0(), have retval = %"INTEGER"\n", retval);
	return retval;
}

integer integer_typetest1(integer lucky_integer) {
//fprintf(stderr, "in CPPOPS_CPPTYPES integer_typetest1(), received lucky_integer = %"INTEGER"\n", lucky_integer);
	return (lucky_integer * 2) + RPerl__DataType__Integer__MODE_ID();
}

# endif

#endif

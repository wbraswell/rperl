using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Boolean_cpp
#define __CPP__INCLUDED__RPerl__DataType__Boolean_cpp 0.001_000

// [[[ INCLUDES ]]]
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h
#include <RPerl/DataType/Boolean.h>  // -> NULL (relies on native C type)
#include <RPerl/DataType/UnsignedInteger.cpp>  // -> UnsignedInteger.h
#include <RPerl/DataType/Integer.cpp>  // -> Integer.h
#include <RPerl/DataType/Number.cpp>  // -> Number.h
#include <RPerl/DataType/Character.cpp>  // -> Character.h
#include <RPerl/DataType/String.cpp>  // -> String.h

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

// DEV NOTE, CORRELATION #rp10: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES

// convert from (Perl SV containing boolean) to (C boolean)
boolean XS_unpack_boolean(SV* input_sv) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_boolean(), top of subroutine\n");
//	boolean_CHECK(input_sv);
	boolean_CHECKTRACE(input_sv, "input_sv", "XS_unpack_boolean()");

//	boolean output_boolean;

//	if (SvIOKp(input_sv)) { output_boolean = SvIV(input_sv); } else { croak("in CPPOPS_CPPTYPES XS_unpack_boolean(), input_sv was not an boolean"); }
//	output_boolean = SvIV(input_sv);

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_boolean(), bottom of subroutine\n");

	return((boolean)SvIV(input_sv));
//	return(output_boolean);
}

// convert from (C boolean) to (Perl SV containing boolean)
void XS_pack_boolean(SV* output_sv, boolean input_boolean) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_boolean(), top of subroutine\n");
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_boolean(), received input_boolean = %ld\n", input_boolean);

	sv_setsv(output_sv, sv_2mortal(newSViv(input_boolean)));

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_boolean(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_boolean(), bottom of subroutine\n");
}

//# endif

// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* boolean_to_unsigned_integer(SV* input_boolean) {
//  boolean_CHECK(input_boolean);
    boolean_CHECKTRACE(input_boolean, "input_boolean", "boolean_to_unsigned_integer()");
    return(input_boolean);
}

# elif defined __CPP__TYPES

unsigned_integer boolean_to_unsigned_integer(boolean input_boolean) {
    return (unsigned_integer) input_boolean;
}

# endif

// [[[ INTEGERIFY ]]]
// [[[ INTEGERIFY ]]]
// [[[ INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* boolean_to_integer(SV* input_boolean) {
//  boolean_CHECK(input_boolean);
    boolean_CHECKTRACE(input_boolean, "input_boolean", "boolean_to_integer()");
    return(input_boolean);
}

# elif defined __CPP__TYPES

integer boolean_to_integer(boolean input_boolean) {
    return (integer) input_boolean;
}

# endif

// [[[ NUMBERIFY ]]]
// [[[ NUMBERIFY ]]]
// [[[ NUMBERIFY ]]]

# ifdef __PERL__TYPES

SV* boolean_to_number(SV* input_boolean) {
//  boolean_CHECK(input_boolean);
    boolean_CHECKTRACE(input_boolean, "input_boolean", "boolean_to_number()");
    return(input_boolean);
}

# elif defined __CPP__TYPES

number boolean_to_number(boolean input_boolean) {
    return (number) input_boolean;
}

# endif

// [[[ CHARACTERIFY ]]]
// [[[ CHARACTERIFY ]]]
// [[[ CHARACTERIFY ]]]

# ifdef __PERL__TYPES

SV* boolean_to_character(SV* input_boolean) {
//  boolean_CHECK(input_boolean);
    boolean_CHECKTRACE(input_boolean, "input_boolean", "boolean_to_character()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

character boolean_to_character(boolean input_boolean) {
    return (character) boolean_to_string(input_boolean).at(0);
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* boolean_to_string(SV* input_boolean) {
//	boolean_CHECK(input_boolean);
	boolean_CHECKTRACE(input_boolean, "input_boolean", "boolean_to_string()");
//	fprintf(stderr, "in CPPOPS_PERLTYPES boolean_to_string(), top of subroutine, received unformatted input_boolean = %ld\n", (boolean)SvIV(input_boolean));
//	fprintf(stderr, "in CPPOPS_PERLTYPES boolean_to_string()...\n");

	return(newSVpvf("%ld", (integer) SvIV(input_boolean)));
}

# elif defined __CPP__TYPES

string boolean_to_string(boolean input_boolean) {
    std::ostringstream output_stream;
    output_stream << input_boolean;
    return(output_stream.str());
}

# endif

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* boolean__typetest0() {
    // DEV NOTE: maintain independence from Integer data type, re-implement integer_to_boolean() here & below
    SV* retval = newSViv(1);
    if (SvIV(RPerl__DataType__Boolean__MODE_ID()) == 0) { retval = newSViv(0); }
//	SV* retval = integer_to_boolean(RPerl__DataType__Boolean__MODE_ID());
//fprintf(stderr, "in CPPOPS_PERLTYPES boolean__typetest0(), have retval = %ld\n", SvIV(retval));
	return retval;
}

SV* boolean__typetest1(SV* lucky_boolean) {
//	boolean_CHECK(lucky_boolean);
	boolean_CHECKTRACE(lucky_boolean, "lucky_boolean", "boolean__typetest1()");
//fprintf(stderr, "in CPPOPS_PERLTYPES boolean__typetest1(), received lucky_boolean = %ld\n", SvIV(lucky_boolean));
    SV* retval = newSViv(1);
    if ((SvIV(lucky_boolean) + SvIV(RPerl__DataType__Boolean__MODE_ID())) == 0) { retval = newSViv(0); }
	return retval;
//	return integer_to_boolean(newSViv( SvIV(lucky_boolean) + SvIV(RPerl__DataType__Boolean__MODE_ID()) ) );
}

# elif defined __CPP__TYPES

boolean boolean__typetest0() {
//	boolean retval = integer_to_boolean(RPerl__DataType__Boolean__MODE_ID());
	boolean retval = 1;
	if (RPerl__DataType__Boolean__MODE_ID() == 0) { retval = 0; }
//fprintf(stderr, "in CPPOPS_CPPTYPES boolean__typetest0(), have retval = %ld\n", retval);
	return retval;
}

boolean boolean__typetest1(boolean lucky_boolean) {
//fprintf(stderr, "in CPPOPS_CPPTYPES boolean__typetest1(), received lucky_boolean = %ld\n", lucky_boolean);
    boolean retval = 1;
    if ((lucky_boolean + RPerl__DataType__Boolean__MODE_ID()) == 0) { retval = 0; }
//fprintf(stderr, "in CPPOPS_CPPTYPES boolean__typetest0(), have retval = %ld\n", retval);
	return retval;
//	return(integer_to_boolean(lucky_boolean + RPerl__DataType__Boolean__MODE_ID()));
}

# endif

#endif

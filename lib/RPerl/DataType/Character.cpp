using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Character_cpp
#define __CPP__INCLUDED__RPerl__DataType__Character_cpp 0.002_000

// [[[ INCLUDES ]]]
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h
#include <RPerl/DataType/Character.h>  // -> NULL (relies on native C type)
#include <RPerl/DataType/Boolean.cpp>  // -> Boolean.h
#include <RPerl/DataType/UnsignedInteger.cpp>  // -> UnsignedInteger.h
#include <RPerl/DataType/Integer.cpp>  // -> Integer.h
#include <RPerl/DataType/Number.cpp>  // -> Number.h
#include <RPerl/DataType/String.cpp>  // -> String.h

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

// DEV NOTE, CORRELATION #rp010: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES

// convert from (Perl SV containing character) to (C character)
character XS_unpack_character(pTHX_ SV* input_sv) {
//	character_CHECK(input_sv);
	character_CHECKTRACE(input_sv, "input_sv", "XS_unpack_character()");
	return((character) (SvPV_nolen(input_sv))[1]);
}

// convert from (C character) to (Perl SV containing character)
void XS_pack_character(pTHX_ SV* output_sv, character input_character) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_character(), top of subroutine\n");
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_character(), received input_character = %"INTEGER"\n", input_character);

	sv_setsv(output_sv, sv_2mortal(newSVpvf("%c", input_character)));

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_character(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_character(), bottom of subroutine\n");
}

//# endif

// [[[ BOOLEANIFY ]]]
// [[[ BOOLEANIFY ]]]
// [[[ BOOLEANIFY ]]]

# ifdef __PERL__TYPES

SV* character_to_boolean(pTHX_ SV* input_character) {
//  character_CHECK(input_character);
    character_CHECKTRACE(input_character, "input_character", "character_to_boolean()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

boolean character_to_boolean(character input_character) {
    if ((input_character - '0') == 0) { return 0; }
    else { return 1; }
}

# endif

// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* character_to_unsigned_integer(pTHX_ SV* input_character) {
//  character_CHECK(input_character);
    character_CHECKTRACE(input_character, "input_character", "character_to_unsigned_integer()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

unsigned_integer character_to_unsigned_integer(character input_character) {
    return (unsigned_integer) (input_character - '0');
}

# endif

// [[[ INTEGERIFY ]]]
// [[[ INTEGERIFY ]]]
// [[[ INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* character_to_integer(pTHX_ SV* input_character) {
//  character_CHECK(input_character);
    character_CHECKTRACE(input_character, "input_character", "character_to_integer()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

integer character_to_integer(character input_character) {
    return (integer) (input_character - '0');
}

# endif

// [[[ NUMBERIFY ]]]
// [[[ NUMBERIFY ]]]
// [[[ NUMBERIFY ]]]

# ifdef __PERL__TYPES

SV* character_to_number(pTHX_ SV* input_character) {
//  character_CHECK(input_character);
    character_CHECKTRACE(input_character, "input_character", "character_to_number()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

number character_to_number(character input_character) {
    return (number) (input_character - '0');
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* character_to_string(pTHX_ SV* input_character) {
//	character_CHECK(input_character);
	character_CHECKTRACE(input_character, "input_character", "character_to_string()");
//	fprintf(stderr, "in CPPOPS_PERLTYPES character_to_string(), top of subroutine, received unformatted input_character = %s\n", SvPV_nolen(input_character));
	return input_character;
}

# elif defined __CPP__TYPES

string character_to_string(character input_character) {
    string retval(1, input_character);
    return retval;
}

# endif

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* character__typetest0(pTHX) {
	return newSVpvf("%c", (character) (SvIV(RPerl__DataType__Character__MODE_ID(aTHX)) + '0'));
}

SV* character__typetest1(pTHX_ SV* lucky_character) {
//	character_CHECK(lucky_character);
	character_CHECKTRACE(lucky_character, "lucky_character", "character__typetest1()");
//fprintf(stderr, "in CPPOPS_PERLTYPES character__typetest1(), received lucky_character = %"INTEGER"\n", SvIV(lucky_character));
	return newSVpvf("%c", (character) ((SvPV_nolen(lucky_character))[0] + SvIV(RPerl__DataType__Character__MODE_ID(aTHX))));
}

# elif defined __CPP__TYPES

character character__typetest0() {
	return (RPerl__DataType__Character__MODE_ID() + '0');
}

character character__typetest1(character lucky_character) {
    return (lucky_character + RPerl__DataType__Character__MODE_ID());
}

# endif

#endif

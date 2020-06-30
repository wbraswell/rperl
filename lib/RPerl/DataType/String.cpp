using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__String_cpp
#define __CPP__INCLUDED__RPerl__DataType__String_cpp 0.013_100

// [[[ INCLUDES ]]]
#include <RPerl/DataType/String.h>		// -> NULL (relies on native C type)
#include <RPerl/DataType/Boolean.cpp>  // -> Boolean.h
#include <RPerl/DataType/UnsignedInteger.cpp>  // -> UnsignedInteger.h
#include <RPerl/DataType/Integer.cpp>  // -> Integer.h
#include <RPerl/DataType/Number.cpp>  // -> Number.h
#include <RPerl/DataType/Character.cpp>  // -> Character.h

// [[[ GENERAL FUNCTIONS ]]]

// DEV NOTE, CORRELATION #rp070: "logical and" && operator behaves differently in Perl vs C++, accepts strings so must use double-negation trick to convert to boolean, returns operand on right if operator evaluates to true; use ANDl instead of && in C++
bool operator!(const string& s) {

    // START HERE: should this be returning s.empty() or string_to_boolean()?  need write tests for negation of strings in PERLOPS_PERLTYPES vs CPPOPS_CPPTYPES?
    // START HERE: should this be returning s.empty() or string_to_boolean()?  need write tests for negation of strings in PERLOPS_PERLTYPES vs CPPOPS_CPPTYPES?
    // START HERE: should this be returning s.empty() or string_to_boolean()?  need write tests for negation of strings in PERLOPS_PERLTYPES vs CPPOPS_CPPTYPES?

    return s.empty();
}

// [[[ TYPE CHECKING ]]]
// [[[ TYPE CHECKING ]]]
// [[[ TYPE CHECKING ]]]

// NEED ANSWER: does this change the original string via move semantics, or make a copy?
// escape all back-slash \ and single-quote ' characters with a back-slash \ character
string escape_backslash_singlequote(string unescaped_string) {
    string escaped_string = unescaped_string;
    size_t escaped_string_pos = 0;
    while((escaped_string_pos = escaped_string.find("\\", escaped_string_pos)) != string::npos)
    {
        escaped_string.replace(escaped_string_pos, 1, "\\\\");
        escaped_string_pos += 2;
    }
    escaped_string_pos = 0;
    while((escaped_string_pos = escaped_string.find("'", escaped_string_pos)) != string::npos)
    {
        escaped_string.replace(escaped_string_pos, 1, "\\'");
        escaped_string_pos += 2;
    }
    return escaped_string;
}

// TYPE-CHECKING SUBROUTINES DEPRECATED IN FAVOR OF EQUIVALENT MACROS
/*
void string_CHECK(SV* possible_string) {
    if (not(SvOK(possible_string))) {
    	croak("\nERROR EPV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found,\ncroaking");
    }
	if (not(SvPOKp(possible_string))) {
    	croak("\nERROR EPV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found,\ncroaking");
    }
};
void string_CHECKTRACE(SV* possible_string, const char* variable_name, const char* subroutine_name) {
    if (not(SvOK(possible_string))) {
    	croak("\nERROR EPV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking",
    			variable_name, subroutine_name);
    }
	if (not(SvPOKp(possible_string))) {
    	croak("\nERROR EPV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found,\nin variable %s from subroutine %s,\ncroaking",
    			variable_name, subroutine_name);
    }
};
*/

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

// DEV NOTE, CORRELATION #rp010: the pack/unpack subs (below) are called by number_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES

// convert from (Perl SV containing string) to (C++ std::string)
string XS_unpack_string(SV* input_sv)
{
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string(), top of subroutine\n");
//	string_CHECK(input_sv);
	string_CHECKTRACE(input_sv, "input_sv", "XS_unpack_string()");
//	string output_string;
//	output_string = SvPV_nolen(input_sv);
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string(), bottom of subroutine\n");
	return((string)SvPV_nolen(input_sv));
//	return(output_string);
}

// convert from (C++ std::string) to (Perl SV containing string)
void XS_pack_string(SV* output_sv, string input_string) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string(), top of subroutine\n");
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string(), received input_string = '%s'\n", input_string.c_str());

	sv_setsv(output_sv, sv_2mortal(newSVpv(input_string.data(), input_string.size())));

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string(), bottom of subroutine\n");
}

//# endif

// [[[ SEARCH & REPLACE ]]]
// [[[ SEARCH & REPLACE ]]]
// [[[ SEARCH & REPLACE ]]]

# ifdef __PERL__TYPES

/* DISABLE UNTIL COMPLETE, TO AVOID C++ COMPILER WARNINGS
void string_substitute_global(SV* input_string, const string& find_string, const string& replace_string) {
//  string_CHECK(input_string);
    string_CHECKTRACE(input_string, "input_string", "string_substitute_global()");
    // NEED ADD CODE
}
*/

# elif defined __CPP__TYPES

void string_substitute_global(string& input_string, const string& find_string, const string& replace_string) {
    size_t found_position = 0;
    while ((found_position = input_string.find(find_string, found_position)) != string::npos) {
         input_string.replace(found_position, find_string.length(), replace_string);
         found_position += replace_string.length();
    }
}

# endif

// [[[ BOOLEANIFY ]]]
// [[[ BOOLEANIFY ]]]
// [[[ BOOLEANIFY ]]]

# ifdef __PERL__TYPES

SV* string_to_boolean(SV* input_string) {
//  string_CHECK(input_string);
    string_CHECKTRACE(input_string, "input_string", "string_to_boolean()");
    string_substitute_global(input_string, "_", "");  // remove underscores to allow them in input_string
    if (atoi(SvPV_nolen(input_string)) == 0) { return newSViv(0); }
    else { return newSViv(1); }
}

# elif defined __CPP__TYPES

boolean string_to_boolean(string input_string) {
    string_substitute_global(input_string, "_", "");  // remove underscores to allow them in input_string
    if (atoi(input_string.c_str()) == 0) { return 0; }
    else { return 1; }
}

# endif

// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* string_to_unsigned_integer(SV* input_string) {
//  string_CHECK(input_string);
    string_CHECKTRACE(input_string, "input_string", "string_to_unsigned_integer()");
    string_substitute_global(input_string, "_", "");  // remove underscores to allow them in input_string
    if (atoi(SvPV_nolen(input_string)) < 0) { return newSViv(atoi(SvPV_nolen(input_string)) * -1); }
    else { return newSViv(atoi(SvPV_nolen(input_string))); }
}

# elif defined __CPP__TYPES

unsigned_integer string_to_unsigned_integer(string input_string) {
    string_substitute_global(input_string, "_", "");  // remove underscores to allow them in input_string
    if (atoi(input_string.c_str()) < 0) { return (unsigned_integer) (atoi(input_string.c_str()) * -1); }
    else { return (unsigned_integer) atoi(input_string.c_str()); }
}

# endif

// [[[ INTEGERIFY ]]]
// [[[ INTEGERIFY ]]]
// [[[ INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* string_to_integer(SV* input_string) {
//  string_CHECK(input_string);
    string_CHECKTRACE(input_string, "input_string", "string_to_integer()");
    string_substitute_global(input_string, "_", "");  // remove underscores to allow them in input_string
    return newSViv(atoi(SvPV_nolen(input_string)));
}

# elif defined __CPP__TYPES

integer string_to_integer(string input_string) {
    string_substitute_global(input_string, "_", "");  // remove underscores to allow them in input_string
    return (integer) atoi(input_string.c_str());
}

# endif

// [[[ NUMBERIFY ]]]
// [[[ NUMBERIFY ]]]
// [[[ NUMBERIFY ]]]

# ifdef __PERL__TYPES

SV* string_to_number(SV* input_string) {
//  string_CHECK(input_string);
    string_CHECKTRACE(input_string, "input_string", "string_to_number()");
    string_substitute_global(input_string, "_", "");  // remove underscores to allow them in input_string
    return newSVnv(atof(SvPV_nolen(input_string)));
}

# elif defined __CPP__TYPES

number string_to_number(string input_string) {
    string_substitute_global(input_string, "_", "");  // remove underscores to allow them in input_string
    return (number) atof(input_string.c_str());
}

# endif

// [[[ CHARACTERIFY ]]]
// [[[ CHARACTERIFY ]]]
// [[[ CHARACTERIFY ]]]

# ifdef __PERL__TYPES

/* DISABLE UNTIL COMPLETE, TO AVOID C++ COMPILER WARNINGS
SV* string_to_character(SV* input_string) {
//  string_CHECK(input_string);
    string_CHECKTRACE(input_string, "input_string", "string_to_character()");
    // NEED ADD CODE
}
*/

# elif defined __CPP__TYPES

character string_to_character(string input_string) {
    return (character) input_string.at(0);
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* string_to_string(SV* input_sv)
{
    string input_sv_string;
    size_t input_sv_string_pos;

//	string_CHECK(input_sv);
	string_CHECKTRACE(input_sv, "input_sv", "string_to_string()");

	input_sv_string = SvPV_nolen(input_sv);

fprintf(stderr, "in CPPOPS_PERLTYPES string_to_string(), received input_sv_string =\n%s\n\n", input_sv_string.c_str());
//fprintf(stderr, "in CPPOPS_PERLTYPES string_to_string()...\n");

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

//fprintf(stderr, "in CPPOPS_PERLTYPES string_to_string(), bottom of subroutine, returning possibly-modified input_sv_string =\n%s\n\n", input_sv_string.c_str());

	return(newSVpvf("%s", input_sv_string.c_str()));
}

# elif defined __CPP__TYPES

string to_string(string input_string) {
    fprintf(stderr, "in CPPOPS_CPPTYPES to_string(), about to call string_to_string & return value...\n");
    return(string_to_string(input_string));
}

string string_to_string(string input_string)
{
fprintf(stderr, "in CPPOPS_CPPTYPES string_to_string(), top of subroutine, received input_string =\n%s\n\n", input_string.c_str());
//fprintf(stderr, "in CPPOPS_CPPTYPES string_to_string()...\n");

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

//fprintf(stderr, "in CPPOPS_CPPTYPES string_to_string(), bottom of subroutine, returning possibly-modified input_string =\n%s\n\n", input_string.c_str());

	return(input_string);
}

# endif

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* string_typetest0() {
//fprintf(stderr, "in CPPOPS_PERLTYPES string_typetest0()\n");
	return(newSVpv("Spice CPPOPS_PERLTYPES", 0));
}

SV* string_typetest1(SV* lucky_string) {
//	string_CHECK(lucky_string);
	string_CHECKTRACE(lucky_string, "lucky_string", "string_typetest1()");
//cout << "in CPPOPS_PERLTYPES string_typetest1(), received lucky_string '" << SvPV_nolen(lucky_string) << "'" << '\n';  cout.flush();  // DEV NOTE: must flush buffer to avoid endl over-flushing and out-of-order printing
//cerr << "in CPPOPS_PERLTYPES string_typetest1(), received lucky_string '" << SvPV_nolen(lucky_string) << "'" << '\n';  // DEV NOTE: cerr doesn't have a buffer to flush
//fprintf(stderr, "in CPPOPS_PERLTYPES string_typetest1(), received lucky_string = '%s'\n", SvPV_nolen(lucky_string));
	return(newSVpvf("%s%s", SvPV_nolen(string_to_string(lucky_string)), " CPPOPS_PERLTYPES"));
}

# elif defined __CPP__TYPES

string string_typetest0() {
	string retval = "Spice CPPOPS_CPPTYPES";
//fprintf(stderr, "in CPPOPS_CPPTYPES string_typetest0(), have retval = '%s'\n", retval.c_str());
	return retval;
}

string string_typetest1(string lucky_string) {
//fprintf(stderr, "in CPPOPS_CPPTYPES string_typetest1(), received lucky_string = '%s'\n", lucky_string.c_str());
	return(string_to_string(lucky_string) + " CPPOPS_CPPTYPES");
}

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_cpp
#define __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_cpp 0.004_100

// [[[ INCLUDES ]]]
#include <RPerl/DataType/UnsignedInteger.h>  // -> NULL (relies on native C type)
// DEV NOTE, CORRELATION #rp12: the only actual includes-level dependency between any of the RPerl core data types should be String.cpp to avoid
// error: ‘XS_pack_string’ was not declared in this scope
#include <RPerl/DataType/String.cpp>  // -> String.h

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

// DEV NOTE, CORRELATION #rp10: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES

// convert from (Perl SV containing unsigned_integer) to (C unsigned_integer)
unsigned_integer XS_unpack_unsigned_integer(SV* input_sv) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_unsigned_integer(), top of subroutine\n");
//	unsigned_integer_CHECK(input_sv);
	unsigned_integer_CHECKTRACE(input_sv, "input_sv", "XS_unpack_unsigned_integer()");

//	unsigned_integer output_unsigned_integer;

//	if (SvUIOKp(input_sv)) { output_unsigned_integer = SvIV(input_sv); } else { croak("in CPPOPS_CPPTYPES XS_unpack_unsigned_integer(), input_sv was not an unsigned_integer"); }
//	output_unsigned_integer = SvIV(input_sv);

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_unsigned_integer(), bottom of subroutine\n");

	return((unsigned_integer)SvIV(input_sv));
//	return(output_unsigned_integer);
}

// convert from (C unsigned_integer) to (Perl SV containing unsigned_integer)
void XS_pack_unsigned_integer(SV* output_sv, unsigned_integer input_unsigned_integer) {
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_unsigned_integer(), top of subroutine\n");
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_unsigned_integer(), received input_unsigned_integer = %d\n", input_unsigned_integer);

	sv_setsv(output_sv, sv_2mortal(newSViv(input_unsigned_integer)));

//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_unsigned_integer(), have output_sv = '%s'\n", SvPV_nolen(output_sv));
//fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_unsigned_integer(), bottom of subroutine\n");
}

//# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* unsigned_integer_to_string(SV* input_unsigned_integer)
{
//	unsigned_integer_CHECK(input_unsigned_integer);
	unsigned_integer_CHECKTRACE(input_unsigned_integer, "input_unsigned_integer", "unsigned_integer_to_string()");
//	fprintf(stderr, "in CPPOPS_PERLTYPES unsigned_integer_to_string(), top of subroutine, received unformatted input_unsigned_integer = %d\n", (unsigned_integer)SvIV(input_unsigned_integer));
//	fprintf(stderr, "in CPPOPS_PERLTYPES unsigned_integer_to_string()...\n");

    // DEV NOTE: disable old stringify w/out underscores
//	return(newSVpvf("%d", (unsigned_integer)SvIV(input_unsigned_integer)));

    return(newSVpv((const char *)((unsigned_integer_to_string_CPPTYPES((unsigned_integer)SvIV(input_unsigned_integer))).c_str()), 0));
}

# elif defined __CPP__TYPES

// DEV NOTE, CORRELATION #rp10: shim CPPTYPES sub
string unsigned_integer_to_string(unsigned_integer input_unsigned_integer) {
    return(unsigned_integer_to_string_CPPTYPES(input_unsigned_integer));
}

# endif

// DEV NOTE, CORRELATION #rp09: must use return type 'string' instead of 'std::string' for proper typemap pack/unpack function name alignment;
// can cause silent failure, falling back to __PERL__TYPES implementation and NOT failure of tests!
// DEV NOTE, CORRELATION #rp10: the real CPPTYPES sub (below) is called by the wrapper PERLTYPES sub and shim CPPTYPES subs (above), moved outside #ifdef blocks
string unsigned_integer_to_string_CPPTYPES(unsigned_integer input_unsigned_integer)
{
//    fprintf(stderr, "in CPPOPS_CPPTYPES unsigned_integer_to_string_CPPTYPES(), top of subroutine, received unformatted input_unsigned_integer = %d\n", input_unsigned_integer);
//    fprintf(stderr, "in CPPOPS_CPPTYPES unsigned_integer_to_string_CPPTYPES()...\n");

    std::ostringstream output_stream;
    output_stream.precision(std::numeric_limits<double>::digits10);
    output_stream << input_unsigned_integer;

    // DEV NOTE: disable old stringify w/out underscores
//  return(output_stream.str());

    string output_string = output_stream.str();
//    fprintf(stderr, "in CPPOPS_CPPTYPES unsigned_integer_to_string_CPPTYPES(), have output_string = %s\n", output_string.c_str());

    std::reverse(output_string.begin(), output_string.end());

//    fprintf(stderr, "in CPPOPS_CPPTYPES unsigned_integer_to_string_CPPTYPES(), have reversed output_string = %s\n", output_string.c_str());

    string output_string_underscores = "";
    for(std::string::size_type i = 0; i < output_string.size(); ++i) {
//        fprintf(stderr, "in CPPOPS_CPPTYPES unsigned_integer_to_string_CPPTYPES(), inside output_string underscore loop, have i = %d, output_string[i] = %c\n", (int)i, output_string[i]);
        output_string_underscores += output_string[i];
        if (((i % 3) == 2) && (i > 0) && (i != (output_string.size() - 1))) {
//            fprintf(stderr, "in CPPOPS_CPPTYPES unsigned_integer_to_string_CPPTYPES(), AND UNDERSCORE \n");
            output_string_underscores += '_';
        }
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES unsigned_integer_to_string_CPPTYPES(), have reversed output_string_underscores = %s\n", output_string_underscores.c_str());

    std::reverse(output_string_underscores.begin(), output_string_underscores.end());

    if (output_string_underscores == "") {
        output_string_underscores = "0";
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES unsigned_integer_to_string_CPPTYPES(), have unreversed output_string_underscores = %s\n", output_string_underscores.c_str());

    return(output_string_underscores);
}

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* unsigned_integer__typetest0() {
	SV* retval = newSViv((21 / 7) + SvIV(RPerl__DataType__UnsignedInteger__MODE_ID()));
//fprintf(stderr, "in CPPOPS_PERLTYPES unsigned_integer__typetest0(), have retval = %d\n", (unsigned_integer)SvIV(retval));
	return(retval);
}

SV* unsigned_integer__typetest1(SV* lucky_unsigned_integer) {
//	unsigned_integer_CHECK(lucky_unsigned_integer);
	unsigned_integer_CHECKTRACE(lucky_unsigned_integer, "lucky_unsigned_integer", "unsigned_integer__typetest1()");
//fprintf(stderr, "in CPPOPS_PERLTYPES unsigned_integer__typetest1(), received lucky_unsigned_integer = %d\n", (unsigned_integer)SvIV(lucky_unsigned_integer));
	return(newSViv((SvIV(lucky_unsigned_integer) * 2) + SvIV(RPerl__DataType__UnsignedInteger__MODE_ID())));
}

# elif defined __CPP__TYPES

unsigned_integer unsigned_integer__typetest0() {
	unsigned_integer retval = (21 / 7) + RPerl__DataType__UnsignedInteger__MODE_ID();
//fprintf(stderr, "in CPPOPS_CPPTYPES unsigned_integer__typetest0(), have retval = %d\n", retval);
	return(retval);
}

unsigned_integer unsigned_integer__typetest1(unsigned_integer lucky_unsigned_integer) {
//fprintf(stderr, "in CPPOPS_CPPTYPES unsigned_integer__typetest1(), received lucky_unsigned_integer = %d\n", lucky_unsigned_integer);
	return((lucky_unsigned_integer * 2) + RPerl__DataType__UnsignedInteger__MODE_ID());
}

# endif

#endif

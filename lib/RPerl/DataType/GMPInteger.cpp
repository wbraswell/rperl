using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__DataType__GMPInteger_cpp
#define __CPP__INCLUDED__RPerl__DataType__GMPInteger_cpp 0.001_000

// [[[ INCLUDES ]]]
#include <RPerl/DataType/GMPInteger.h>		// -> NULL (relies on native C type)
#include <RPerl/Operation/Expression/Operator/GMPFunctions.cpp>  // -> GMPFunctions.h

// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]

void gmp_integer_CHECK(SV* possible_gmp_integer)
{
    if ( not( SvOK(possible_gmp_integer) ) ) { croak( "\nERROR EGIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer value expected but undefined/null value found,\ncroaking" ); }
    if ( not( SvHROKp(possible_gmp_integer) ) ) { croak( "\nERROR EGIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer value expected but non-hashref value found,\ncroaking" ); }

    HV* possible_gmp_integer_deref = (HV*)SvRV(possible_gmp_integer);

    if (not hv_exists(possible_gmp_integer_deref, (const char*) "value", (U32) 5)) {
        croak("\nERROR EGIV02, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer object in hash entry expected at key 'value' but no hash entry exists,\ncroaking");
    }

    SV** possible_gmp_integer_value_ptr = hv_fetch(possible_gmp_integer_deref, (const char*) "value", (U32) 5, (I32) 0);

    if (possible_gmp_integer_value_ptr == NULL) {
        croak("\nERROR EGIV03, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash entry expected at key 'value' but no hash entry defined,\ncroaking");
    }

    // DEV NOTE: PERLTYPES gmp_integer is a wrapper around PERLTYPES Math::BigInt::GMP, which is a wrapper around C gmp_integer,
    // so we can directly access the underlying C gmp_integer, nice!
//    gmp_integer possible_gmp_integer_value = *possible_gmp_integer_value_ptr;
//    gmp_get_signed_integer(possible_gmp_integer_value);
//    gmp_get_signed_integer(*possible_gmp_integer_value_ptr);

    // NEED FIX: is this the only way to check if the variable is actually a gmp_integer type?
    // I'm assuming the static types of C/C++ will give a compiler and/or runtime error on one of the two preceding lines of code if our var is not really a gmp_integer...
}

void gmp_integer_CHECKTRACE(SV* possible_gmp_integer, const char* variable_name, const char* subroutine_name)
{
    if ( not( SvOK(possible_gmp_integer) ) ) { croak( "\nERROR EGIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }
    if ( not( SvHROKp(possible_gmp_integer) ) ) { croak( "\nERROR EGIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer value expected but non-hashref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }

    HV* possible_gmp_integer_deref = (HV*)SvRV(possible_gmp_integer);

    if (not hv_exists(possible_gmp_integer_deref, (const char*) "value", (U32) 5)) {
        croak("\nERROR EGIV02, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer object in hash entry expected at key 'value' but no hash entry exists,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name );
    }

    SV** possible_gmp_integer_value_ptr = hv_fetch(possible_gmp_integer_deref, (const char*) "value", (U32) 5, (I32) 0);

    if (possible_gmp_integer_value_ptr == NULL) {
        croak("\nERROR EGIV03, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash entry expected at key 'value' but no hash entry defined,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name );
    }

    // DEV NOTE: PERLTYPES gmp_integer is a wrapper around PERLTYPES Math::BigInt::GMP, which is a wrapper around C gmp_integer,
    // so we can directly access the underlying C gmp_integer, nice!
//    gmp_get_signed_integer(*possible_gmp_integer_value_ptr);

    // NEED FIX: is this the only way to check if the variable is actually a gmp_integer type?
    // I'm assuming the static types of C/C++ will give a compiler and/or runtime error on one of the two preceding lines of code if our var is not really a gmp_integer...
}

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

/* DISABLED
# ifdef __CPP__TYPES

// convert from (Perl SV containing reference to (Perl HV containing reference to C gmp_integer)) to (C gmp_integer)
gmp_integer XS_unpack_gmp_integer(SV* input_hv_ref)
{
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_gmp_integer(), top of subroutine\n");
//  gmp_integer_CHECK(input_hv_ref);
    gmp_integer_CHECKTRACE(input_hv_ref, "input_hv_ref", "XS_unpack_gmp_integer()");

    HV* input_hv;
    SV** hash_entry_value;
    gmp_integer output_gmp_integer;

    input_hv = (HV*)SvRV(input_hv_ref);

//    SV**  hv_fetch(HV*, const char* key, U32 klen, I32 lval);
    hash_entry_value = hv_fetch(input_hv, (const char*) "value", (U32) 5, (I32) 0);

    cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer(), have hash_entry_value = " << hash_entry_value << endl;

    output_gmp_integer = *hash_entry_value;

    cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer(), have gmp_get_signed_integer(output_gmp_integer) = " << gmp_get_signed_integer(output_gmp_integer) << endl;

//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_gmp_integer(), bottom of subroutine\n");

    return output_gmp_integer;
}

// convert from (C gmp_integer) to (Perl SV containing reference to (Perl HV containing reference to C gmp_integer))
void XS_pack_gmp_integer(SV* output_hv_ref, gmp_integer input_gmp_integer)
{
//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_gmp_integer(), top of subroutine\n");

    HV* output_hv = newHV();  // initialize output hash to empty
    SV* temp_sv_pointer;

    hv_store(output_hv, (const char*) "value", (U32) 5, &input_gmp_integer, (U32)0);

    temp_sv_pointer = newSVrv(output_hv_ref, NULL);   // upgrade output stack SV to an RV
    SvREFCNT_dec(temp_sv_pointer);       // discard temporary pointer
    SvRV(output_hv_ref) = (SV*)output_hv;      // make output stack RV pointer at our output HV

//  fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_gmp_integer(), bottom of subroutine\n");
}

# endif
*/

// [[[ BOOLIFY ]]]
// [[[ BOOLIFY ]]]
// [[[ BOOLIFY ]]]

# ifdef __PERL__TYPES

SV* gmp_integer_to_bool(SV* input_gmp_integer) {
//  gmp_integer_CHECK(input_gmp_integer);
    gmp_integer_CHECKTRACE(input_gmp_integer, "input_gmp_integer", "gmp_integer_to_bool()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

bool gmp_integer_to_bool(gmp_integer input_gmp_integer) {
    if (gmp_get_signed_integer(input_gmp_integer) == 0) { return 0; }
    else { return 1; }
}

# endif

// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]
// [[[ UNSIGNED INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* gmp_integer_to_unsigned_integer(SV* input_gmp_integer) {
//  gmp_integer_CHECK(input_gmp_integer);
    gmp_integer_CHECKTRACE(input_gmp_integer, "input_gmp_integer", "gmp_integer_to_unsigned_integer()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

unsigned_integer gmp_integer_to_unsigned_integer(gmp_integer input_gmp_integer) {
    return abs(gmp_get_signed_integer(input_gmp_integer));
}

# endif

// [[[ INTEGERIFY ]]]
// [[[ INTEGERIFY ]]]
// [[[ INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* gmp_integer_to_integer(SV* input_gmp_integer) {
//  gmp_integer_CHECK(input_gmp_integer);
    gmp_integer_CHECKTRACE(input_gmp_integer, "input_gmp_integer", "gmp_integer_to_integer()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

integer gmp_integer_to_integer(gmp_integer input_gmp_integer) {
    return gmp_get_signed_integer(input_gmp_integer);
}

# endif

// [[[ NUMBERIFY ]]]
// [[[ NUMBERIFY ]]]
// [[[ NUMBERIFY ]]]

# ifdef __PERL__TYPES

SV* gmp_integer_to_number(SV* input_gmp_integer) {
//  gmp_integer_CHECK(input_gmp_integer);
    gmp_integer_CHECKTRACE(input_gmp_integer, "input_gmp_integer", "gmp_integer_to_number()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

number gmp_integer_to_number(gmp_integer input_gmp_integer) {
    return (double) gmp_get_signed_integer(input_gmp_integer);
}

# endif

// [[[ CHARIFY ]]]
// [[[ CHARIFY ]]]
// [[[ CHARIFY ]]]

# ifdef __PERL__TYPES

SV* gmp_integer_to_char(SV* input_gmp_integer) {
//  gmp_integer_CHECK(input_gmp_integer);
    gmp_integer_CHECKTRACE(input_gmp_integer, "input_gmp_integer", "gmp_integer_to_char()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

// DEV NOTE, CORRELATION #rp10: shim CPPTYPES sub
char gmp_integer_to_char(gmp_integer input_gmp_integer) {
    return gmp_integer_to_string_CPPTYPES(input_gmp_integer).at(0);
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* gmp_integer_to_string(SV* input_gmp_integer) {
//	gmp_integer_CHECK(input_gmp_integer);
	gmp_integer_CHECKTRACE(input_gmp_integer, "input_gmp_integer", "gmp_integer_to_string()");
	// NEED ADD CODE
}

# elif defined __CPP__TYPES

// DEV NOTE, CORRELATION #rp10: shim CPPTYPES sub
string gmp_integer_to_string(gmp_integer input_gmp_integer) {
    return gmp_integer_to_string_CPPTYPES(input_gmp_integer);
}

# endif

/* DISABLED
// DEV NOTE, CORRELATION #rp09: must use return type 'string' instead of 'std::string' for proper typemap pack/unpack function name alignment;
// can cause silent failure, falling back to __PERL__TYPES implementation and NOT failure of tests!
// DEV NOTE, CORRELATION #rp10: the real CPPTYPES sub (below) is called by the wrapper PERLTYPES sub and shim CPPTYPES subs (above), moved outside #ifdef blocks
string gmp_integer_to_string_CPPTYPES(gmp_integer input_gmp_integer)
{
//    fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer_to_string_CPPTYPES(), top of subroutine, received unformatted input_gmp_integer = %d\n", input_gmp_integer);
//    fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer_to_string_CPPTYPES()...\n");

    std::ostringstream output_stream;
    output_stream.precision(std::numeric_limits<double>::digits10);
    output_stream << gmp_get_signed_integer(input_gmp_integer);

    // DEV NOTE: disable old stringify w/out underscores
//  return(output_stream.str());

    string output_string = output_stream.str();
//    fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer_to_string_CPPTYPES(), have output_string = %s\n", output_string.c_str());

    bool is_negative = 0;
    if (input_gmp_integer < 0) { is_negative = 1; }

    std::reverse(output_string.begin(), output_string.end());

//    fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer_to_string_CPPTYPES(), have reversed output_string = %s\n", output_string.c_str());
    if (is_negative) { output_string.pop_back(); }  // remove negative sign

    string output_string_underscores = "";
    for(std::string::size_type i = 0; i < output_string.size(); ++i) {
//        fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer_to_string_CPPTYPES(), inside output_string underscore loop, have i = %d, output_string[i] = %c\n", (int)i, output_string[i]);
        output_string_underscores += output_string[i];
        if (((i % 3) == 2) && (i > 0) && (i != (output_string.size() - 1))) {
//            fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer_to_string_CPPTYPES(), AND UNDERSCORE \n");
            output_string_underscores += '_';
        }
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer_to_string_CPPTYPES(), have reversed output_string_underscores = %s\n", output_string_underscores.c_str());

    std::reverse(output_string_underscores.begin(), output_string_underscores.end());

    if (output_string_underscores == "") {
        output_string_underscores = "0";
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer_to_string_CPPTYPES(), have unreversed output_string_underscores = %s\n", output_string_underscores.c_str());

    if (is_negative) { output_string_underscores = '-' + output_string_underscores; }

    return output_string_underscores;
}
*/

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* gmp_integer__typetest0() {
    // NEED ADD CODE
}

SV* gmp_integer__typetest1(SV* lucky_gmp_integer) {
//	gmp_integer_CHECK(lucky_gmp_integer);
	gmp_integer_CHECKTRACE(lucky_gmp_integer, "lucky_gmp_integer", "gmp_integer__typetest1()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

//gmp_integer gmp_integer__typetest0() {
string gmp_integer__typetest0() {
	gmp_integer retval;
	gmp_set_signed_integer(retval, (21 / 7) + RPerl__DataType__GMPInteger__MODE_ID());
//fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer__typetest0(), have retval = %d\n", retval);
//	return retval;
	return gmp_get_string(retval);
}

//gmp_integer gmp_integer__typetest1(gmp_integer lucky_gmp_integer) {
string gmp_integer__typetest1(gmp_integer lucky_gmp_integer) {
//fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer__typetest1(), received lucky_gmp_integer = %d\n", lucky_gmp_integer);
	gmp_integer retval;
	gmp_set_signed_integer(retval, (gmp_get_signed_integer(lucky_gmp_integer) * 2) + RPerl__DataType__GMPInteger__MODE_ID());
//	return retval;
	return gmp_get_string(retval);
}

# endif

#endif

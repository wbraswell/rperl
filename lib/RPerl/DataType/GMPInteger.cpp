using std::cout;
using std::cerr;
using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__GMPInteger_cpp
#define __CPP__INCLUDED__RPerl__DataType__GMPInteger_cpp 0.001_000

// [[[ INCLUDES ]]]
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h
#include <RPerl/DataType/GMPInteger.h>		// -> NULL (relies on native C type)
#include <RPerl/Operation/Expression/Operator/GMPFunctions.cpp>  // -> GMPFunctions.h
#include <RPerl/DataType/Boolean.cpp>  // -> Boolean.h
#include <RPerl/DataType/UnsignedInteger.cpp>  // -> UnsignedInteger.h
#include <RPerl/DataType/Integer.cpp>  // -> Integer.h
#include <RPerl/DataType/Number.cpp>  // -> Number.h
#include <RPerl/DataType/Character.cpp>  // -> Character.h
#include <RPerl/DataType/String.cpp>  // -> String.h

// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]

void gmp_integer_CHECK(SV* possible_gmp_integer) {
    if (not (SvOK(possible_gmp_integer))) { croak( "\nERROR EGIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but undefined/null value found,\ncroaking"); }
    if (not (SvHROKp(possible_gmp_integer))) { croak( "\nERROR EGIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-hashref value found,\ncroaking"); }
    if (not (sv_isobject(possible_gmp_integer))) { croak( "\nERROR EGIV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-object (blessed hashref) value found,\ncroaking"); }
    if (not (sv_derived_from(possible_gmp_integer, "Math::BigInt"))) { croak( "\nERROR EGIV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-Math::BigInt-derived object value found,\ncroaking"); }
//    if (not (sv_isa(possible_gmp_integer, "gmp_integer"))) { croak( "\nERROR EGIV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-gmp_integer object value found,\ncroaking"); }

    HV* possible_gmp_integer_deref = (HV*) SvRV(possible_gmp_integer);
    if (not hv_exists(possible_gmp_integer_deref, (const char*) "value", (U32) 5)) { croak( "\nERROR EGIV05, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped object in hash entry expected at key 'value' but no hash entry exists,\ncroaking"); }

    SV** possible_gmp_integer_value_ptr = hv_fetch(possible_gmp_integer_deref, (const char*) "value", (U32) 5, (I32) 0);
    if (possible_gmp_integer_value_ptr == NULL) { croak( "\nERROR EGIV06, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped hash entry expected at key 'value' but no hash entry defined,\ncroaking"); }

    if (not (SvOK(*possible_gmp_integer_value_ptr))) { croak( "\nERROR EGIV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but undefined/null value found,\ncroaking"); }
    if (not (sv_isobject(*possible_gmp_integer_value_ptr))) { croak( "\nERROR EGIV08, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but non-object (blessed hashref) value found,\ncroaking"); }
    if (not (sv_derived_from(*possible_gmp_integer_value_ptr, "Math::BigInt::GMP"))) { croak( "\nERROR EGIV09, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but non-Math::BigInt::GMP object value found,\ncroaking"); }
}

void gmp_integer_CHECKTRACE(SV* possible_gmp_integer, const char* variable_name, const char* subroutine_name) {
//    cerr << "in gmp_integer_CHECKTRACE(), top of subroutine" << endl;
    if (not (SvOK(possible_gmp_integer))) { croak( "\nERROR EGIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
    if (not (SvHROKp(possible_gmp_integer))) { croak( "\nERROR EGIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-hashref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
    if (not (sv_isobject(possible_gmp_integer))) { croak( "\nERROR EGIV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-object (blessed hashref) value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
    if (not (sv_derived_from(possible_gmp_integer, "Math::BigInt"))) { croak( "\nERROR EGIV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-Math::BigInt-derived object value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
//    if (not (sv_isa(possible_gmp_integer, "gmp_integer"))) { croak( "\nERROR EGIV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-gmp_integer object value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }

    HV* possible_gmp_integer_deref = (HV*) SvRV(possible_gmp_integer);
//    cerr << "in gmp_integer_CHECKTRACE(), have possible_gmp_integer_deref = " << possible_gmp_integer_deref << endl;
    if (not hv_exists(possible_gmp_integer_deref, (const char*) "value", (U32) 5)) { croak( "\nERROR EGIV05, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped object in hash entry expected at key 'value' but no hash entry exists,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }

    SV** possible_gmp_integer_value_ptr = hv_fetch(possible_gmp_integer_deref, (const char*) "value", (U32) 5, (I32) 0);
//    cerr << "in gmp_integer_CHECKTRACE(), have *possible_gmp_integer_value_ptr = " << *possible_gmp_integer_value_ptr << endl;
    if (possible_gmp_integer_value_ptr == NULL) { croak( "\nERROR EGIV06, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped hash entry expected at key 'value' but no hash entry defined,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }

    if (not (SvOK(*possible_gmp_integer_value_ptr))) { croak( "\nERROR EGIV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
    if (not (sv_isobject(*possible_gmp_integer_value_ptr))) { croak( "\nERROR EGIV08, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but non-object (blessed hashref) value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
    if (not (sv_derived_from(*possible_gmp_integer_value_ptr, "Math::BigInt::GMP"))) { croak( "\nERROR EGIV09, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but non-Math::BigInt::GMP object value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
//    cerr << "in gmp_integer_CHECKTRACE(), bottom of subroutine" << endl;
}

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES

// convert from (Perl SV containing reference to (Perl HV containing reference to C gmp_integer)) to (C gmp_integer_retval)
gmp_integer_retval XS_unpack_gmp_integer_retval(SV* input_hv_ref) {
//    gmp_integer_CHECK(input_hv_ref);
    gmp_integer_CHECKTRACE(input_hv_ref, "input_hv_ref", "XS_unpack_gmp_integer_retval()");

    // DEV NOTE: PERLTYPES gmp_integer is AKA RPerl::DataType::GMPInteger,
    // which is a wrapper around PERLTYPES Math::BigInt,
    // which is a wrapper around PERLTYPES Math::BigInt::GMP (in our RPerl usage),
    // which is a wrapper around CPPTYPES gmp_integer,
    // so we can directly access the underlying CPPTYPES gmp_integer via SvMAGIC(...)->mg_ptr below, nice!

    /*  // LONG FORM
     cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), top of subroutine" << endl;
     HV* input_hv = (HV*)SvRV(input_hv_ref);
     SV** input_hv_value_ptr = hv_fetch(input_hv, (const char*) "value", (U32) 5, (I32) 0);
     //    gmp_integer_rawptr gmp_integer_tmp = sv_to_gmp_integer_rawptr(*input_hv_value_ptr);

     MAGIC* input_hv_value_ptr_magic = SvMAGIC(SvRV(*input_hv_value_ptr));
     cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), received *input_hv_value_ptr = " << *input_hv_value_ptr << endl;
     cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), have input_hv_value_ptr_magic = " << input_hv_value_ptr_magic << endl;
     cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), have gmp_get_signed_integer(*(gmp_integer_rawptr)input_hv_value_ptr_magic->mg_ptr) = " << gmp_get_signed_integer(*(gmp_integer_rawptr)input_hv_value_ptr_magic->mg_ptr) << endl;
     cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), have (gmp_integer_rawptr)input_hv_value_ptr_magic->mg_ptr = " << (gmp_integer_rawptr)input_hv_value_ptr_magic->mg_ptr << endl;

     gmp_integer_rawptr gmp_integer_tmp = (gmp_integer_rawptr) input_hv_value_ptr_magic->mg_ptr;

     cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), have *gmp_integer_tmp = " << *gmp_integer_tmp << endl;

     gmp_integer_retval output_gmp_integer_retval = (gmp_integer_retval) *(gmp_integer_tmp);

     cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), have output_gmp_integer_retval.gmp_integer_unretval() = " << output_gmp_integer_retval.gmp_integer_unretval() << endl;
     cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), bottom of subroutine" << endl;

     return output_gmp_integer_retval;
     */

    // SHORT FORM
    return (gmp_integer_retval) *((gmp_integer_rawptr) SvMAGIC(SvRV(*(hv_fetch((HV*) SvRV(input_hv_ref), (const char*) "value", (U32) 5, (I32) 0))))->mg_ptr);
}

// convert from (C gmp_integer_retval) to (Perl SV containing reference to (Perl HV containing reference to C gmp_integer))
void XS_pack_gmp_integer_retval(SV* output_hv_ref, gmp_integer_retval input_gmp_integer_retval) {
//    cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), top of subroutine, received output_hv_ref = " << output_hv_ref << endl;

    dSP;
    ENTER;
    SAVETMPS;

    PUSHMARK(SP);
    XPUSHs(sv_2mortal(newSVpv("gmp_integer", 0)));  // callback from C++ to Perl for gmp_integer->new() object constructor, class name is first and only argument
    PUTBACK;

    integer callback_retval_count = call_method("new", G_SCALAR);  // actual callback
//    cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), have callback_retval_count = " << callback_retval_count << endl;

    SPAGAIN;

    if (callback_retval_count != 1) {
        croak("\nERROR EGIV10, CONSTRUCTOR RETURN VALUE MISMATCH, CPPOPS_CPPTYPES:\nexactly 1 return value expected but %d return value(s) found,\ncroaking", callback_retval_count);
    }

    SV* gmp_integer_hv_ref = POPs;
//    cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), have gmp_integer_hv_ref = " << gmp_integer_hv_ref << endl;
//    cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), have class(gmp_integer_hv_ref) = " << class(gmp_integer_hv_ref) << endl;

//    gmp_integer_CHECK(gmp_integer_hv_ref);
    gmp_integer_CHECKTRACE(gmp_integer_hv_ref, "gmp_integer_hv_ref", "XS_pack_gmp_integer_retval()");

    PUTBACK;

    // METHOD A
    SV* temp_sv_pointer;
    temp_sv_pointer = newSVrv(output_hv_ref, NULL);   // upgrade output stack SV to an RV
    SvREFCNT_dec(temp_sv_pointer);       // discard temporary pointer
    SvRV(output_hv_ref) = SvRV(gmp_integer_hv_ref);      // make output stack RV pointer at our output gmp_integer
    SvREFCNT_inc(SvRV(output_hv_ref));  // avoid segfaults and attempts to free unreferenced scalars by increasing retval's ref count, seems to work on either output_hv_ref or gmp_integer_hv_ref

    // METHOD B
/*
    HV* output_hv = newHV();  // initialize output hash to empty
    SV* temp_sv_pointer;

    // SUB-METHOD B1
    hv_store(output_hv, (const char*) "value", (U32) 5, SvREFCNT_inc(*hv_fetch((HV*)SvRV(gmp_integer_hv_ref), (const char*) "value", (U32) 5, (I32) 0)), (U32)0);
    hv_store(output_hv, (const char*) "sign", (U32) 4, SvREFCNT_inc(*hv_fetch((HV*)SvRV(gmp_integer_hv_ref), (const char*) "sign", (U32) 4, (I32) 0)), (U32)0);
    hv_store(output_hv, (const char*) "_a", (U32) 2, SvREFCNT_inc(*hv_fetch((HV*)SvRV(gmp_integer_hv_ref), (const char*) "_a", (U32) 2, (I32) 0)), (U32)0);
    hv_store(output_hv, (const char*) "_p", (U32) 2, SvREFCNT_inc(*hv_fetch((HV*)SvRV(gmp_integer_hv_ref), (const char*) "_p", (U32) 2, (I32) 0)), (U32)0);

//     SV* gmp_integer_hv_ref_value_value = *hv_fetch((HV*)SvRV(gmp_integer_hv_ref), (const char*) "value", (U32) 5, (I32) 0);
//     SV* gmp_integer_hv_ref_value_value = *hv_fetch(gmp_integer_hv, (const char*) "value", (U32) 5, (I32) 0);
//     cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), have gmp_integer_hv_ref_value_value = " << gmp_integer_hv_ref_value_value << endl;

    // SUB-METHOD B2
/ *
     integer gmp_integer_hv_num_keys;
     integer i;
     HE* gmp_integer_hv_entry;
     SV* gmp_integer_hv_entry_key;
     SV* gmp_integer_hv_entry_value;

     HV* gmp_integer_hv = (HV*)SvRV(gmp_integer_hv_ref);
     cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), have gmp_integer_hv = " << gmp_integer_hv << endl;

     gmp_integer_hv_num_keys = hv_iterinit(gmp_integer_hv);
     cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), have gmp_integer_hv_num_keys = " << gmp_integer_hv_num_keys << endl;

     for (i = 0;  i < gmp_integer_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
     {
         cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), top of for() loop, i = " << i << endl;
         gmp_integer_hv_entry = hv_iternext(gmp_integer_hv);
         cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), in for() loop, i = " << i << ", have gmp_integer_hv_entry = " << gmp_integer_hv_entry << endl;
         gmp_integer_hv_entry_key = hv_iterkeysv(gmp_integer_hv_entry);
         cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), in for() loop, i = " << i << ", have gmp_integer_hv_entry_key = " << gmp_integer_hv_entry_key << endl;
         gmp_integer_hv_entry_value = hv_iterval(gmp_integer_hv, gmp_integer_hv_entry);
         SvREFCNT_inc(gmp_integer_hv_entry_value);
         cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), in for() loop, i = " << i << ", have gmp_integer_hv_entry_value = " << gmp_integer_hv_entry_value << endl;
         cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), in for() loop, i = " << i << ", have SvPV_nolen(gmp_integer_hv_entry_key) = " << SvPV_nolen(gmp_integer_hv_entry_key) << endl;
         hv_store(output_hv, SvPV_nolen(gmp_integer_hv_entry_key), (U32) strlen(SvPV_nolen(gmp_integer_hv_entry_key)), gmp_integer_hv_entry_value, (U32)0);
     }
* /

    temp_sv_pointer = newSVrv(output_hv_ref, NULL);   // upgrade output stack SV to an RV
    SvREFCNT_dec(temp_sv_pointer);       // discard temporary pointer
    SvRV(output_hv_ref) = (SV*)output_hv;      // make output stack RV pointer at our output HV
    sv_bless(output_hv_ref, gv_stashpv("gmp_integer", (I32) 0));
*/

    SV* gmp_integer_hv_ref_value_value = *hv_fetch((HV*)SvRV(gmp_integer_hv_ref), (const char*) "value", (U32) 5, (I32) 0);
    MAGIC* gmp_integer_hv_ref_value_value_magic = SvMAGIC(SvRV(gmp_integer_hv_ref_value_value));
//    cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), have gmp_integer_hv_ref_value_value = " << gmp_integer_hv_ref_value_value << endl;
//    cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), have gmp_integer_hv_ref_value_value_magic = " << gmp_integer_hv_ref_value_value_magic << endl;
//    cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), have pre-set (gmp_integer_rawptr)gmp_integer_hv_ref_value_value_magic->mg_ptr = " << (gmp_integer_rawptr)gmp_integer_hv_ref_value_value_magic->mg_ptr << endl;
//    cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), have pre-set gmp_get_signed_integer(*(gmp_integer_rawptr)gmp_integer_hv_ref_value_value_magic->mg_ptr) = " << gmp_get_signed_integer(*(gmp_integer_rawptr)gmp_integer_hv_ref_value_value_magic->mg_ptr) << endl;

    gmp_integer_rawptr gmp_integer_tmp = (gmp_integer_rawptr) gmp_integer_hv_ref_value_value_magic->mg_ptr;
//    cerr << "in CPPOPS_CPPTYPES XS_unpack_gmp_integer_retval(), have post-set gmp_integer_tmp = " << gmp_integer_tmp << endl;
    gmp_set(*gmp_integer_tmp, input_gmp_integer_retval.gmp_integer_unretval());

    FREETMPS;
    LEAVE;

//    cerr << "in CPPOPS_CPPTYPES XS_pack_gmp_integer_retval(), bottom of subroutine" << endl;
}

# endif


// START HERE: test BOOLEANIFY, *IFY, GMP INTEGERIFY, etc.; possibly modify typetests() to return numeric types
// START HERE: test BOOLEANIFY, *IFY, GMP INTEGERIFY, etc.; possibly modify typetests() to return numeric types
// START HERE: test BOOLEANIFY, *IFY, GMP INTEGERIFY, etc.; possibly modify typetests() to return numeric types


// [[[ BOOLEANIFY ]]]
// [[[ BOOLEANIFY ]]]
// [[[ BOOLEANIFY ]]]

# ifdef __PERL__TYPES

SV* gmp_integer_to_boolean(SV* input_gmp_integer) {
//  gmp_integer_CHECK(input_gmp_integer);
    gmp_integer_CHECKTRACE(input_gmp_integer, "input_gmp_integer", "gmp_integer_to_boolean()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

boolean gmp_integer_to_boolean(gmp_integer_retval input_gmp_integer_retval) {
    if (gmp_get_signed_integer(input_gmp_integer_retval.gmp_integer_unretval()) == 0) { return 0; }
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

unsigned_integer gmp_integer_to_unsigned_integer(gmp_integer_retval input_gmp_integer_retval) {
    return abs(gmp_get_signed_integer(input_gmp_integer_retval.gmp_integer_unretval()));
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

integer gmp_integer_to_integer(gmp_integer_retval input_gmp_integer_retval) {
//    cerr << "in CPPOPS_CPPTYPES gmp_integer_to_integer(), received input_gmp_integer_retval = " << input_gmp_integer_retval << endl;
//    cerr << "in CPPOPS_CPPTYPES gmp_integer_to_integer(), have input_gmp_integer_retval.gmp_integer_unretval() = " << input_gmp_integer_retval.gmp_integer_unretval() << endl;
//    cerr << "in CPPOPS_CPPTYPES gmp_integer_to_integer(), returning gmp_get_signed_integer(input_gmp_integer_retval.gmp_integer_unretval()) = " << gmp_get_signed_integer(input_gmp_integer_retval.gmp_integer_unretval()) << endl;
    return gmp_get_signed_integer(input_gmp_integer_retval.gmp_integer_unretval());
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

number gmp_integer_to_number(gmp_integer_retval input_gmp_integer_retval) {
    return (double) gmp_get_signed_integer(input_gmp_integer_retval.gmp_integer_unretval());
}

# endif

// [[[ CHARACTERIFY ]]]
// [[[ CHARACTERIFY ]]]
// [[[ CHARACTERIFY ]]]

# ifdef __PERL__TYPES

SV* gmp_integer_to_character(SV* input_gmp_integer) {
//  gmp_integer_CHECK(input_gmp_integer);
    gmp_integer_CHECKTRACE(input_gmp_integer, "input_gmp_integer", "gmp_integer_to_character()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

character gmp_integer_to_character(gmp_integer_retval input_gmp_integer_retval) {
    // NEED OPTIMIZE: remove call to gmp_integer_to_string_CPPTYPES()
    return (character) gmp_integer_to_string_CPPTYPES(input_gmp_integer_retval.gmp_integer_unretval()).at(0);
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* gmp_integer_to_string(SV* input_gmp_integer) {
//  gmp_integer_CHECK(input_gmp_integer);
    gmp_integer_CHECKTRACE(input_gmp_integer, "input_gmp_integer", "gmp_integer_to_string()");
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

// DEV NOTE, CORRELATION #rp10: shim CPPTYPES sub
string gmp_integer_to_string(gmp_integer_retval input_gmp_integer_retval) {
    return gmp_integer_to_string_CPPTYPES(input_gmp_integer_retval.gmp_integer_unretval());
}

# endif

/* NEED ENABLE OR DELETE
 // DEV NOTE, CORRELATION #rp09: must use return type 'string' instead of 'std::string' for proper typemap pack/unpack function name alignment;
 // can cause silent failure, falling back to __PERL__TYPES implementation and NOT failure of tests!
 // DEV NOTE, CORRELATION #rp10: the real CPPTYPES sub (below) is called by the wrapper PERLTYPES sub and shim CPPTYPES subs (above), moved outside #ifdef blocks
 string gmp_integer_to_string_CPPTYPES(gmp_integer_retval input_gmp_integer_retval)
 {
 //    fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer_to_string_CPPTYPES(), top of subroutine, received unformatted input_gmp_integer_retval = %d\n", input_gmp_integer_retval);
 //    fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer_to_string_CPPTYPES()...\n");

 std::ostringstream output_stream;
 output_stream.precision(std::numeric_limits<double>::digits10);
 output_stream << gmp_get_signed_integer(input_gmp_integer_retval.gmp_integer_unretval());

 // DEV NOTE: disable old stringify w/out underscores
 //  return(output_stream.str());

 string output_string = output_stream.str();
 //    fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer_to_string_CPPTYPES(), have output_string = %s\n", output_string.c_str());

 boolean is_negative = 0;
 if (input_gmp_integer_retval.gmp_integer_unretval() < 0) { is_negative = 1; }

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

// [[[ GMP INTEGERIFY ]]]
// [[[ GMP INTEGERIFY ]]]
// [[[ GMP INTEGERIFY ]]]

# ifdef __PERL__TYPES

SV* integer_to_gmp_integer(SV* input_integer) {
    // NEED ADD CODE
}

# elif defined __CPP__TYPES

gmp_integer_retval integer_to_gmp_integer(integer input_integer) {
//    cerr << "in integer_to_gmp_integer(), top of subroutine, received input_integer = " << input_integer << endl;

    // LONG FORM
//    gmp_integer_retval output_gmp_integer_retval;
//    output_gmp_integer_retval = input_integer;
//    cerr << "in integer_to_gmp_integer(), returning output_gmp_integer_retval = " << output_gmp_integer_retval << endl;
//    return output_gmp_integer_retval;

    // SHORT FORM
    return (gmp_integer_retval) input_integer;
}

# endif

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
    gmp_init(retval);
    gmp_set_signed_integer(retval,
            (21 / 7) + RPerl__DataType__GMPInteger__MODE_ID());
//fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer__typetest0(), have retval = %d\n", retval);
    return gmp_get_string(retval);
}

//gmp_integer gmp_integer__typetest1(gmp_integer lucky_gmp_integer) {
string gmp_integer__typetest1(gmp_integer lucky_gmp_integer) {
//fprintf(stderr, "in CPPOPS_CPPTYPES gmp_integer__typetest1(), received lucky_gmp_integer = %d\n", lucky_gmp_integer);
    gmp_integer retval;
    gmp_set_signed_integer(retval,
            (gmp_get_signed_integer(lucky_gmp_integer) * 2) + RPerl__DataType__GMPInteger__MODE_ID());
//	return retval;
    return gmp_get_string(retval);
}

# endif

#endif

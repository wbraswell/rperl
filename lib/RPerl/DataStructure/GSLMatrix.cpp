using std::cout;
using std::cerr;
using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__GSLMatrix_cpp
#define __CPP__INCLUDED__RPerl__DataStructure__GSLMatrix_cpp 0.002_000

// [[[ INCLUDES ]]]
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h
#include <RPerl/DataStructure/Array.cpp>		// -> Array.h ???
#include <RPerl/DataStructure/GSLMatrix.h>		// -> ???
#include <RPerl/Operation/Expression/Operator/GSLFunctions.cpp>  // -> GSLFunctions.h ???

// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]

void gsl_matrix_CHECK(SV* possible_gsl_matrix) {
//    cerr << "in CPPOPS gsl_matrix_CHECK(), top of subroutine" << endl;
    if (not (SvOK(possible_gsl_matrix))) { croak( "\nERROR EMAV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix external wrapper value expected but undefined/null value found,\ncroaking"); }
    if (not (SvHROKp(possible_gsl_matrix))) { croak( "\nERROR EMAV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix external wrapper value expected but non-hashref value found,\ncroaking"); }
    if (not (sv_isobject(possible_gsl_matrix))) { croak( "\nERROR EMAV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix external wrapper value expected but non-object (blessed hashref) value found,\ncroaking"); }
    if (not (sv_derived_from(possible_gsl_matrix, "Math::GSL::Matrix::gsl_matrix"))) { croak( "\nERROR EMAV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix wrapper value expected but non-Math::GSL::Matrix::gsl_matrix-derived object value found,\ncroaking"); }
    if (not (sv_isa(possible_gsl_matrix, "Math::GSL::Matrix::gsl_matrix"))) { croak( "\nERROR EMAV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix external wrapper value expected but non-Math::GSL::Matrix::gsl_matrix object value found,\ncroaking"); }

    HV* possible_gsl_matrix_deref = (HV*) SvRV(possible_gsl_matrix);
//    if (not hv_exists(possible_gsl_matrix_deref, (const char*) "data", (U32) 4)) { croak( "\nERROR EMAV05, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix internal wrapped object in hash entry expected at key 'data' but no hash entry exists,\ncroaking"); }

    SV** possible_gsl_matrix_data_ptr = hv_fetch(possible_gsl_matrix_deref, (const char*) "data", (U32) 4, (I32) 0);
    if (possible_gsl_matrix_data_ptr == NULL) { croak( "\nERROR EMAV06, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix internal wrapped hash entry expected at key 'data' but no hash entry defined,\ncroaking"); }

//    if (not (SvOK(*possible_gsl_matrix_data_ptr))) { croak( "\nERROR EMAV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix internal wrapped value expected but undefined/null value found,\ncroaking"); }
    if (not (sv_isobject(*possible_gsl_matrix_data_ptr))) { croak( "\nERROR EMAV08, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix internal wrapped value expected but non-object (blessed hashref) value found,\ncroaking"); }
    if (not (sv_derived_from(*possible_gsl_matrix_data_ptr, "_p_double"))) { croak( "\nERROR EMAV09, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix _p_double internal wrapped value expected but non-_p_double object value found,\ncroaking"); }

//    cerr << "in CPPOPS gsl_matrix_CHECK(), bottom of subroutine" << endl;
}

void gsl_matrix_CHECKTRACE(SV* possible_gsl_matrix, const char* variable_name, const char* subroutine_name) {
    cerr << "in CPPOPS gsl_matrix_CHECKTRACE(), top of subroutine" << endl;
    if (not (SvOK(possible_gsl_matrix))) { croak( "\nERROR EMAV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix external wrapper value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
    if (not (SvHROKp(possible_gsl_matrix))) { croak( "\nERROR EMAV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix external wrapper value expected but non-hashref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
    if (not (sv_isobject(possible_gsl_matrix))) { croak( "\nERROR EMAV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix external wrapper value expected but non-object (blessed hashref) value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
    if (not (sv_derived_from(possible_gsl_matrix, "Math::GSL::Matrix::gsl_matrix"))) { croak( "\nERROR EMAV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix external wrapper value expected but non-Math::GSL::Matrix::gsl_matrix-derived object value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
    if (not (sv_isa(possible_gsl_matrix, "Math::GSL::Matrix::gsl_matrix"))) { croak( "\nERROR EMAV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix external wrapper value expected but non-Math::GSL::Matrix::gsl_matrix object value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }

    HV* possible_gsl_matrix_deref = (HV*) SvRV(possible_gsl_matrix);
    cerr << "in gsl_matrix_CHECKTRACE(), have possible_gsl_matrix_deref = " << possible_gsl_matrix_deref << endl;

    // Math::GSL::Matrix::gsl_matrix is a tied object, not a real hash, so $my_gsl_matrix->{data} is not actually a Perl hash value retrieval;
    // Math::GSL::Matrix::gsl_matrix does not currently have an exists() method, so we will get the following error by calling hv_exists():
    // Can't locate object method "EXISTS" via package "Math::GSL::Matrix::gsl_matrix"
//    if (not hv_exists(possible_gsl_matrix_deref, (const char*) "data", (U32) 4)) { croak( "\nERROR EMAV05, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix internal wrapped object in hash entry expected at key 'data' but no hash entry exists,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }

    SV** possible_gsl_matrix_data_ptr = hv_fetch(possible_gsl_matrix_deref, (const char*) "data", (U32) 4, (I32) 0);
    cerr << "in gsl_matrix_CHECKTRACE(), have *possible_gsl_matrix_data_ptr = " << *possible_gsl_matrix_data_ptr << endl;
    if (possible_gsl_matrix_data_ptr == NULL) { croak( "\nERROR EMAV06, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix internal wrapped hash entry expected at key 'data' but no hash entry defined,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }

    // NEED ANSWER: Math::GSL::Matrix::gsl_matrix->{data} does not pass the SvOK() test, why?
//    if (not (SvOK(*possible_gsl_matrix_data_ptr))) { croak( "\nERROR EMAV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix internal wrapped value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }

    if (not (sv_isobject(*possible_gsl_matrix_data_ptr))) { croak( "\nERROR EMAV08, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix internal wrapped value expected but non-object (blessed hashref) value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }
    if (not (sv_derived_from(*possible_gsl_matrix_data_ptr, "_p_double"))) { croak( "\nERROR EMAV09, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nMath::GSL::Matrix::gsl_matrix _p_double internal wrapped value expected but non-_p_double object value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }

    cerr << "in CPPOPS gsl_matrix_CHECKTRACE(), bottom of subroutine" << endl;
}

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES

// convert from (Perl SV containing tied reference to C gsl_matrix) to (C gsl_matrix_rawptr)
gsl_matrix_rawptr XS_unpack_gsl_matrixPtr(SV* input_sv_ref) {
    cerr << "in CPPOPS_CPPTYPES XS_unpack_gsl_matrixPtr(), top of subroutine" << endl;

//    gsl_matrix_CHECK(input_sv_ref);
    gsl_matrix_CHECKTRACE(input_sv_ref, "input_sv_ref", "XS_unpack_gsl_matrixPtr()");

    // DEV NOTE: PERLTYPES gsl_matrix is AKA RPerl::DataStructure::GSLMatrix,
    // which is a wrapper around PERLTYPES Math::GSL::Matrix::gsl_matrix,
    // which is a wrapper around CPPTYPES gsl_matrix,
    // so we can directly access the underlying CPPTYPES gsl_matrix via SvMAGIC(...)->mg_obj below, nice!

    // LONG FORM
    MAGIC* input_sv_ref_magic = SvMAGIC(SvRV(input_sv_ref));

    cerr << "in CPPOPS_CPPTYPES XS_unpack_gsl_matrixPtr(), have input_sv_ref_magic = " << input_sv_ref_magic << endl;

    // return direct pointer to underlying gsl_matrix C struct itself, no memcpy() here
    gsl_matrix_rawptr output_gsl_matrix = (gsl_matrix_rawptr) SvIV(SvRV(input_sv_ref_magic->mg_obj));

/**** DISABLED, UNNECESSARY memcpy()
    gsl_matrix_rawptr input_gsl_matrix = (gsl_matrix_rawptr) SvIV(SvRV(input_sv_ref_magic->mg_obj));

    cerr << "in CPPOPS_CPPTYPES XS_unpack_gsl_matrixPtr(), have input_gsl_matrix->size1 = " << input_gsl_matrix->size1 << endl;
    cerr << "in CPPOPS_CPPTYPES XS_unpack_gsl_matrixPtr(), have input_gsl_matrix->size2 = " << input_gsl_matrix->size2 << endl;

    gsl_matrix_rawptr output_gsl_matrix = gsl_matrix_alloc(input_gsl_matrix->size1, input_gsl_matrix->size2);
//    gsl_matrix_rawptr output_gsl_matrix = gsl_matrix_alloc(15, 51);  // TMP DEBUG CONTROL

    integer memcpy_retval = gsl_matrix_memcpy(output_gsl_matrix, (const gsl_matrix_rawptr) input_gsl_matrix);

//    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have memcpy_retval = " << memcpy_retval << endl;

    if (memcpy_retval != 0) {
        croak("\nERROR EMAV12, GSL MATRIX UNPACK, CPPOPS_CPPTYPES:\nExpected return value 0 (success) from gsl_matrix_memcpy() but %"INTEGER" return value found,\ncroaking", memcpy_retval);
    }
****/

    cerr << "in CPPOPS_CPPTYPES XS_unpack_gsl_matrixPtr(), have output_gsl_matrix = " << output_gsl_matrix << endl;
    cerr << "in CPPOPS_CPPTYPES XS_unpack_gsl_matrixPtr(), bottom of subroutine" << endl;

    return output_gsl_matrix;

    // SHORT FORM
//    return (gsl_matrix_rawptr) FOO;
}

// convert from (C gsl_matrix_rawptr) to (Perl SV containing tied reference to C gsl_matrix)
void XS_pack_gsl_matrixPtr(SV* output_sv_ref, gsl_matrix_rawptr input_gsl_matrix) {
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), top of subroutine, received output_sv_ref = " << output_sv_ref << endl;
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have input_gsl_matrix = " << input_gsl_matrix << endl;
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have input_gsl_matrix->size1 = " << input_gsl_matrix->size1 << endl;
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have input_gsl_matrix->size2 = " << input_gsl_matrix->size2 << endl;
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have gsl_matrix_get(input_gsl_matrix, 0, 0) = " << gsl_matrix_get(input_gsl_matrix, 0, 0) << endl;

    dSP;
    ENTER;
    SAVETMPS;

    // setup callback from C++ to Perl for gsl_matrix_alloc() procedural object constructor
    PUSHMARK(SP);
    XPUSHs(sv_2mortal(newSViv(input_gsl_matrix->size1)));  // 1st arg, number of rows from input gsl_matrix
    XPUSHs(sv_2mortal(newSViv(input_gsl_matrix->size2)));  // 2nd arg, number of cols from input gsl_matrix
//    XPUSHs(sv_2mortal(newSViv(55)));  // 1st arg, number of rows TMP DEBUG
//    XPUSHs(sv_2mortal(newSViv(67)));  // 2nd arg, number of cols TMP DEBUG
    PUTBACK;

    integer callback_retval_count = call_pv("gsl_matrix_alloc", G_SCALAR);  // actual callback
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have callback_retval_count = " << callback_retval_count << endl;

    SPAGAIN;

    if (callback_retval_count != 1) {
        croak("\nERROR EMAV10, CONSTRUCTOR RETURN VALUE MISMATCH, CPPOPS_CPPTYPES:\nexactly 1 return value expected but %"INTEGER" return value(s) found,\ncroaking", callback_retval_count);
    }

    SV* new_gsl_matrix_sv_ref = POPs;
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have new_gsl_matrix_sv_ref = " << new_gsl_matrix_sv_ref << endl;
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have class(new_gsl_matrix_sv_ref) = " << class(new_gsl_matrix_sv_ref) << endl;

//    gsl_matrix_CHECK(new_gsl_matrix_sv_ref);
    gsl_matrix_CHECKTRACE(new_gsl_matrix_sv_ref, "new_gsl_matrix_sv_ref", "XS_pack_gsl_matrixPtr()");

    PUTBACK;

    SV* temp_sv_pointer;
    temp_sv_pointer = newSVrv(output_sv_ref, NULL);   // upgrade output stack SV to an RV
    SvREFCNT_dec(temp_sv_pointer);       // discard temporary pointer
    SvRV(output_sv_ref) = SvRV(new_gsl_matrix_sv_ref);      // make output stack RV pointer at our output gsl_matrix
    SvREFCNT_inc(SvRV(output_sv_ref));  // avoid segfaults and attempts to free unreferenced scalars by increasing retval's ref count, seems to work on either output_sv_ref or new_gsl_matrix_sv_ref

/* THIS IS WRONG, DON'T TRY TO ACCESS MAGIC OF {data} DIRECTLY
    SV* new_gsl_matrix_sv_ref_data_value = *hv_fetch((HV*)SvRV(new_gsl_matrix_sv_ref), (const char*) "data", (U32) 4, (I32) 0);

    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have new_gsl_matrix_sv_ref_data_value = " << new_gsl_matrix_sv_ref_data_value << endl;
//    MAGIC* new_gsl_matrix_sv_ref_data_value_magic = SvMAGIC(SvRV(new_gsl_matrix_sv_ref_data_value));
    MAGIC* new_gsl_matrix_sv_ref_data_value_magic = SvMAGIC(new_gsl_matrix_sv_ref_data_value);

    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have new_gsl_matrix_sv_ref_data_value_magic = " << new_gsl_matrix_sv_ref_data_value_magic << endl;
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have pre-set (gsl_matrix_rawptr)new_gsl_matrix_sv_ref_data_value_magic->mg_ptr = " << (gsl_matrix_rawptr)new_gsl_matrix_sv_ref_data_value_magic->mg_ptr << endl;
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have pre-set gsl_matrix_get((gsl_matrix_rawptr)new_gsl_matrix_sv_ref_data_value_magic->mg_ptr, 0, 0) = " << gsl_matrix_get((gsl_matrix_rawptr)new_gsl_matrix_sv_ref_data_value_magic->mg_ptr, 0, 0) << endl;

    gsl_matrix_rawptr tmp_gsl_matrix = (gsl_matrix_rawptr) new_gsl_matrix_sv_ref_data_value_magic->mg_ptr;
*/

//* THIS IS CORRECT!!! ACCESS MAGIC OF Math::GSL::Matrix::gsl_matrix SV DIRECTLY

//    MAGIC* new_gsl_matrix_sv_ref_magic = SvMAGIC(new_gsl_matrix_sv_ref);      // WRONG: runs but wrong data
    MAGIC* new_gsl_matrix_sv_ref_magic = SvMAGIC(SvRV(new_gsl_matrix_sv_ref));

//    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have new_gsl_matrix_sv_ref_magic = " << new_gsl_matrix_sv_ref_magic << endl;

//    gsl_matrix_rawptr tmp_gsl_matrix = (gsl_matrix_rawptr) new_gsl_matrix_sv_ref_magic->mg_ptr;        // WRONG: runs but wrong data
//    gsl_matrix_rawptr tmp_gsl_matrix = (gsl_matrix_rawptr) SvIV(new_gsl_matrix_sv_ref_magic->mg_ptr);  // WRONG: compile error
//    gsl_matrix_rawptr tmp_gsl_matrix = (gsl_matrix_rawptr) new_gsl_matrix_sv_ref_magic->mg_obj;        // WRONG: runs but wrong data
//    gsl_matrix_rawptr tmp_gsl_matrix = (gsl_matrix_rawptr) SvIV(new_gsl_matrix_sv_ref_magic->mg_obj);  // WRONG: runs but wrong data
//    gsl_matrix_rawptr tmp_gsl_matrix = (gsl_matrix_rawptr) SvRV(new_gsl_matrix_sv_ref_magic->mg_obj);  // WRONG: runs but wrong data
    gsl_matrix_rawptr tmp_gsl_matrix = (gsl_matrix_rawptr) SvIV(SvRV(new_gsl_matrix_sv_ref_magic->mg_obj));
//    gsl_matrix_rawptr tmp_gsl_matrix = gsl_matrix_alloc(15, 51);  // TMP DEBUG CONTROL

//*/

    // WRONG: ‘SV {aka struct sv}’ has no member named ‘mg_ptr’
//    gsl_matrix_rawptr tmp_gsl_matrix = (gsl_matrix_rawptr) new_gsl_matrix_sv_ref->mg_ptr;

    // WRONG: runs but wrong size data, must be casting randomly
//    gsl_matrix_rawptr tmp_gsl_matrix = (gsl_matrix_rawptr) new_gsl_matrix_sv_ref;
//    gsl_matrix_rawptr tmp_gsl_matrix = (gsl_matrix_rawptr) SvRV(new_gsl_matrix_sv_ref);

/*  PARTIALLY WORKS, CAN ONLY READ VIA INDIRECT SWIG ACCESSORS
    SV* new_gsl_matrix_sv_ref_size1 = *hv_fetch((HV*)SvRV(new_gsl_matrix_sv_ref), (const char*) "size1", (U32) 5, (I32) 0);
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have new_gsl_matrix_sv_ref_size1 = " << new_gsl_matrix_sv_ref_size1 << endl;
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have SvIV(new_gsl_matrix_sv_ref_size1) = " << SvIV(new_gsl_matrix_sv_ref_size1) << endl;

    SV* new_gsl_matrix_sv_ref_size2 = *hv_fetch((HV*)SvRV(new_gsl_matrix_sv_ref), (const char*) "size2", (U32) 5, (I32) 0);
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have new_gsl_matrix_sv_ref_size2 = " << new_gsl_matrix_sv_ref_size2 << endl;
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have SvIV(new_gsl_matrix_sv_ref_size2) = " << SvIV(new_gsl_matrix_sv_ref_size2) << endl;

    SV* new_gsl_matrix_sv_ref_data = *hv_fetch((HV*)SvRV(new_gsl_matrix_sv_ref), (const char*) "data", (U32) 4, (I32) 0);
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have new_gsl_matrix_sv_ref_data = " << new_gsl_matrix_sv_ref_data << endl;
    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have  pre-change SvIV(new_gsl_matrix_sv_ref_data) = " << SvIV(new_gsl_matrix_sv_ref_data) << endl;
*/

    // WRONG: cannot convert ‘double*’ to ‘SV* {aka sv*}’
//    SvRV(new_gsl_matrix_sv_ref_data) = input_gsl_matrix->data;

    // WRONG: runs but does not actually copy data
//    SvRV(new_gsl_matrix_sv_ref_data) = newSViv((integer) input_gsl_matrix->data);

    // WRONG: runs but does not actually copy data
//    *new_gsl_matrix_sv_ref_data = *newSViv((integer) input_gsl_matrix->data);

//    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have post-change SvIV(new_gsl_matrix_sv_ref_data) = " << SvIV(new_gsl_matrix_sv_ref_data) << endl;

    // WRONG: runs but does not actually copy data
//    hv_store((HV*)SvRV(new_gsl_matrix_sv_ref), (const char*) "tda", (U32) 3, newSViv((integer) input_gsl_matrix->tda), (U32)0);
//    hv_store((HV*)SvRV(new_gsl_matrix_sv_ref), (const char*) "data", (U32) 4, newSViv((integer) input_gsl_matrix->data), (U32)0);
//    hv_store((HV*)SvRV(new_gsl_matrix_sv_ref), (const char*) "block", (U32) 5, newSViv((integer) input_gsl_matrix->block), (U32)0);
//    hv_store((HV*)SvRV(new_gsl_matrix_sv_ref), (const char*) "owner", (U32) 5, newSViv((integer) input_gsl_matrix->owner), (U32)0);

    // NEVER TRIED: can we call this function from C?   *swig_data_set = *Math::GSL::Matrixc::gsl_matrix_data_set;
    // copied  from https://st.aticpan.org/source/LETO/Math-GSL-0.39/pm/Math/GSL/Matrix.pm.1.15
    // it appears inside ./lib/perl5/x86_64-linux-gnu-thread-multi/auto/Math/GSL/Matrix/Matrix.so

//    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have post-set tmp_gsl_matrix = " << tmp_gsl_matrix << endl;
//    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have post-set tmp_gsl_matrix->size1 = " << (size_t) tmp_gsl_matrix->size1 << endl;
//    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have post-set tmp_gsl_matrix->size2 = " << (size_t) tmp_gsl_matrix->size2 << endl;
//    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have post-set tmp_gsl_matrix->tda = " << (size_t) tmp_gsl_matrix->tda << endl;
//    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have post-set tmp_gsl_matrix->data = " << (double*) tmp_gsl_matrix->data << endl;
//    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have post-set tmp_gsl_matrix->block = " << tmp_gsl_matrix->block << endl;
//    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have post-set tmp_gsl_matrix->owner = " << (int) tmp_gsl_matrix->owner << endl;

    integer memcpy_retval = gsl_matrix_memcpy(tmp_gsl_matrix, (const gsl_matrix_rawptr) input_gsl_matrix);

//    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), have memcpy_retval = " << memcpy_retval << endl;

    if (memcpy_retval != 0) {
        croak("\nERROR EMAV11, GSL MATRIX PACK, CPPOPS_CPPTYPES:\nExpected return value 0 (success) from gsl_matrix_memcpy() but %"INTEGER" return value found,\ncroaking", memcpy_retval);
    }

    // NEVER TRIED: create named Perl variable, set named Perl variable to new_gsl_matrix_sv_ref (how??? there is no set_sv()),
    // use Perl variable in Perl callback to gsl_matrix_set(), create nested for-loop to copy individual data elements
//    SV* new_gsl_matrix_variable = get_sv("package::varname", GV_ADD);

    FREETMPS;
    LEAVE;

    cerr << "in CPPOPS_CPPTYPES XS_pack_gsl_matrixPtr(), bottom of subroutine" << endl;
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* gsl_matrix_to_string(SV* input_gsl_matrix) {
//  gsl_matrix_CHECK(input_gsl_matrix);
    gsl_matrix_CHECKTRACE(input_gsl_matrix, "input_gsl_matrix", "gsl_matrix_to_string()");
    // NEED ADD CODE EVENTUALLY
}

# elif defined __CPP__TYPES

// DEV NOTE, CORRELATION #rp010: shim CPPTYPES sub
string gsl_matrix_to_string(gsl_matrix_rawptr input_gsl_matrix) {
    return gsl_matrix_to_string_CPPTYPES(input_gsl_matrix);
}

# endif

// DEV NOTE, CORRELATION #rp009: must use return type 'string' instead of 'std::string' for proper typemap pack/unpack function name alignment;
// can cause silent failure, falling back to __PERL__TYPES implementation and NOT failure of tests!
// DEV NOTE, CORRELATION #rp010: the real CPPTYPES sub (below) is called by the wrapper PERLTYPES sub and shim CPPTYPES subs (above), moved outside #ifdef blocks
string gsl_matrix_to_string_CPPTYPES(gsl_matrix_rawptr input_gsl_matrix)
{
//    fprintf(stderr, "in CPPOPS_CPPTYPES gsl_matrix_to_string_CPPTYPES(), top of subroutine, received unformatted input_gsl_matrix = %"INTEGER"\n", input_gsl_matrix);
    fprintf(stderr, "in CPPOPS_CPPTYPES gsl_matrix_to_string_CPPTYPES()...\n");

    string retval = "";
    integer rows = gsl_matrix_rows(input_gsl_matrix);
    integer cols = gsl_matrix_cols(input_gsl_matrix);
    cerr << "in CPPOPS_CPPTYPES gsl_matrix_to_string(), have rows = " << rows << ", cols = " << cols << endl;

    for (integer i = 0; i < rows; i++) {
        for (integer j = 0; j < cols; j++) {
            // NEED UPDGRADE TO UNDERSCORE NUMBERS!!!
            retval += (const string) number_to_string(gsl_matrix_get(input_gsl_matrix, i, j)) + (const string) "\t";
        }
        retval += (const string) "\n";
    }
    retval += (const string) "\n";
    return retval;
}

// [[[ GSL MATRIXIFY ]]]
// [[[ GSL MATRIXIFY ]]]
// [[[ GSL MATRIXIFY ]]]

# ifdef __PERL__TYPES

SV* number_arrayref_to_gsl_matrix(SV* input_number_arrayref) {
//    number_arrayref_CHECK(input_number_arrayref);
    number_arrayref_CHECKTRACE(input_number_arrayref, "input_number_arrayref", "number_arrayref_to_gsl_matrix()");
    // NEED ADD CODE EVENTUALLY
}

# elif defined __CPP__TYPES

gsl_matrix_rawptr number_arrayref_to_gsl_matrix(number_arrayref input_number_arrayref) {
    // NEED ADD CODE!!!
}

# endif

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* gsl_matrix__typetest0() {
    // NEED ADD EVENTUALLY
}

SV* gsl_matrix__typetest1(SV* lucky_gsl_matrix) {
//	gsl_matrix_CHECK(lucky_gsl_matrix);
    gsl_matrix_CHECKTRACE(lucky_gsl_matrix, "lucky_gsl_matrix", "gsl_matrix__typetest1()");
    // NEED ADD CODE EVENTUALLY
}

# elif defined __CPP__TYPES

gsl_matrix_rawptr gsl_matrix__typetest0() {
    cerr << "in CPPOPS_CPPTYPES gsl_matrix__typetest0(), top of subroutine" << endl;

    gsl_matrix_rawptr retval = gsl_matrix_alloc(21, 12);
    gsl_matrix_set(retval, 0, 0, (RPerl__DataStructure__GSLMatrix__MODE_ID() + 23));
    return retval;
}

gsl_matrix_rawptr gsl_matrix__typetest1(gsl_matrix_rawptr lucky_gsl_matrix) {
    cerr << "in CPPOPS_CPPTYPES gsl_matrix__typetest1(), top of subroutine" << endl;
    cerr << "in CPPOPS_CPPTYPES gsl_matrix__typetest1(), received lucky_gsl_matrix = " << lucky_gsl_matrix << endl;
    cerr << "in CPPOPS_CPPTYPES gsl_matrix__typetest1(), have lucky_gsl_matrix->size1 = " << lucky_gsl_matrix->size1 << endl;
    cerr << "in CPPOPS_CPPTYPES gsl_matrix__typetest1(), have lucky_gsl_matrix->size2 = " << lucky_gsl_matrix->size2 << endl;
    cerr << "in CPPOPS_CPPTYPES gsl_matrix__typetest1(), have pre-add gsl_matrix_get(lucky_gsl_matrix, 0, 0) = " << gsl_matrix_get(lucky_gsl_matrix, 0, 0) << endl;

    integer add_retval = gsl_matrix_add_constant(lucky_gsl_matrix, RPerl__DataType__Integer__MODE_ID());

    cerr << "in CPPOPS_CPPTYPES gsl_matrix__typetest1(), have add_retval = " << add_retval << endl;

    if (add_retval != 0) {
        croak("\nERROR EMAV20, GSL MATRIX TYPETEST, CPPOPS_CPPTYPES:\nExpected return value 0 (success) from gsl_matrix_add_constant() but %"INTEGER" return value found,\ncroaking", gsl_matrix_add_constant);
    }

    cerr << "in CPPOPS_CPPTYPES gsl_matrix__typetest1(), have post-add gsl_matrix_get(lucky_gsl_matrix, 0, 0) = " << gsl_matrix_get(lucky_gsl_matrix, 0, 0) << endl;
    return lucky_gsl_matrix;

    // SHORT FORM
//    return (gsl_matrix_rawptr) gsl_matrix_add_constant(lucky_gsl_matrix, RPerl__DataType__Integer__MODE_ID());
}

# endif

#endif

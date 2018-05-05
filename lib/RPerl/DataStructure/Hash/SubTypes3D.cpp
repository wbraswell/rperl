using std::cout;  using std::cerr;  using std::endl;  using std::to_string;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes3D_cpp
#define __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes3D_cpp 0.001_000

#include <RPerl/DataStructure/Hash/SubTypes3D.h>  // -> ??? (relies on <unordered_map> being included via Inline::CPP's AUTO_INCLUDE config option in RPerl/Inline.pm)

// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]

// DEV NOTE, STEPS TO CONVERT FROM CHECKTRACE TO CHECK
// 1.  CHECKTRACE -> CHECK
// 2.  remove 2 extra args from function header
// 3.  remove var & sub info from error messages
// 4.  remove var & sub info from opening debug statements

void integer_arrayref_hashref_hashref_CHECK(SV* possible_integer_arrayref_hashref_hashref) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_hashref_CHECK(), top of subroutine\n");

    // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with integer-specific error codes
    if ( not( SvOK(possible_integer_arrayref_hashref_hashref) ) ) { croak( "\nERROR EIVAVRVHVRVHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref_hashref value expected but undefined/null value found,\ncroaking" ); }
    if ( not( SvHROKp(possible_integer_arrayref_hashref_hashref) ) ) { croak( "\nERROR EIVAVRVHVRVHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref_hashref value expected but non-hashref value found,\ncroaking" ); }

    HV* possible_integer_arrayref_hashref_hash;
    integer possible_integer_arrayref_hashref_hash_num_keys;
    integer i;
    HE* possible_integer_arrayref_hashref_hashentry;
    SV* possible_integer_arrayref_hashref_hashentry_value;
    SV* possible_integer_arrayref_hashref_hashentry_key;
    string possible_integer_arrayref_hashref_hashentry_key_string;

    possible_integer_arrayref_hashref_hash = (HV*)SvRV(possible_integer_arrayref_hashref_hashref);
    possible_integer_arrayref_hashref_hash_num_keys = hv_iterinit(possible_integer_arrayref_hashref_hash);

    // incrementing iteration, iterator i not actually used in loop body
    for (i = 0;  i < possible_integer_arrayref_hashref_hash_num_keys;  ++i) {
        possible_integer_arrayref_hashref_hashentry = hv_iternext(possible_integer_arrayref_hashref_hash);

        // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with integer-specific error code
        if (possible_integer_arrayref_hashref_hashentry == NULL) { croak("\nERROR EIVAVRVHVRVHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref_hashentry value expected but undefined/null value found,\ncroaking"); }
        possible_integer_arrayref_hashref_hashentry_value = hv_iterval(possible_integer_arrayref_hashref_hash, possible_integer_arrayref_hashref_hashentry);

        // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
        // 1.  naming bridge
        // 2.  AVRVHVRV -> AVRVHVRVHVRV
        // 3.  AVRVHE -> AVRVHVRVHE
        // 4.  increment error code serial numbers by 2 for HVRV codes, by 1 for HE codes
        // 5.  add key info to first 2 pasted error messages
        // 6.  add sub-key info to remaining pasted error messages
        // 7.  j -> k
        // 8.  i -> j
        // 9.  delete pre-existing 1D ARRAY CODE

        // DEV NOTE: naming bridge between 3D code and pasted 2D code
        SV* possible_integer_arrayref_hashref = possible_integer_arrayref_hashref_hashentry_value;

        // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

        // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

        // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with integer-specific error codes
        if ( not( SvOK(possible_integer_arrayref_hashref) ) ) {
            possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
            possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR EIVAVRVHVRVHVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref value expected but undefined/null value found at key '%s',\ncroaking", possible_integer_arrayref_hashref_hashentry_key_string.c_str());
        }
        if ( not( SvHROKp(possible_integer_arrayref_hashref) ) ) {
            possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
            possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR EIVAVRVHVRVHVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref value expected but non-hashref value found at key '%s',\ncroaking", possible_integer_arrayref_hashref_hashentry_key_string.c_str());
        }

        HV* possible_integer_arrayref_hash;
        integer possible_integer_arrayref_hash_num_keys;
        integer j;
        HE* possible_integer_arrayref_hashentry;
        SV* possible_integer_arrayref_hashentry_value;
        SV* possible_integer_arrayref_hashentry_key;
        string possible_integer_arrayref_hashentry_key_string;

        possible_integer_arrayref_hash = (HV*)SvRV(possible_integer_arrayref_hashref);
        possible_integer_arrayref_hash_num_keys = hv_iterinit(possible_integer_arrayref_hash);

        // incrementing iteration, iterator j not actually used in loop body
        for (j = 0;  j < possible_integer_arrayref_hash_num_keys;  ++j) {
            possible_integer_arrayref_hashentry = hv_iternext(possible_integer_arrayref_hash);

            // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with integer-specific error code
            if (possible_integer_arrayref_hashentry == NULL) { croak("\nERROR EIVAVRVHVRVHE01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashentry value expected but undefined/null value found,\ncroaking"); }
            possible_integer_arrayref_hashentry_value = hv_iterval(possible_integer_arrayref_hash, possible_integer_arrayref_hashentry);

            // DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECK() macro & subroutine, but with hash-specific error codes
            if (not(SvOK(possible_integer_arrayref_hashentry_value))) {
                possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
                possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EIVAVRVHVRVHVRV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but undefined/null value found at sub-key '%s', key '%s',\ncroaking", possible_integer_arrayref_hashentry_key_string.c_str(), possible_integer_arrayref_hashref_hashentry_key_string.c_str());
            }

            if (not(SvAROKp(possible_integer_arrayref_hashentry_value))) {
                possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
                possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EIVAVRVHVRVHVRV05, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but non-arrayref value found at sub-key '%s', key '%s',\ncroaking", possible_integer_arrayref_hashentry_key_string.c_str(), possible_integer_arrayref_hashref_hashentry_key_string.c_str());
            }

            SV* possible_integer_arrayref = possible_integer_arrayref_hashentry_value;

            AV* possible_integer_array;
            integer possible_integer_array_length;
            integer k;
            SV** possible_integer_array_element;

            possible_integer_array = (AV*)SvRV(possible_integer_arrayref);
            possible_integer_array_length = av_len(possible_integer_array) + 1;

            // incrementing iteration
            for (k = 0;  k < possible_integer_array_length;  ++k) {
                possible_integer_array_element = av_fetch(possible_integer_array, k, 0);
                if (not(SvOK(*possible_integer_array_element))) {
                    possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
                    possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                    possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR EIVAVRVHVRVHVRV06, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found at index %"INTEGER", sub-key '%s', key '%s',\ncroaking", k, possible_integer_arrayref_hashentry_key_string.c_str(), possible_integer_arrayref_hashref_hashentry_key_string.c_str());
                }
                if (not(SvIOKp(*possible_integer_array_element))) {
                    possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
                    possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                    possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR EIVAVRVHVRVHVRV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found at index %"INTEGER", sub-key '%s', key '%s',\ncroaking", k, possible_integer_arrayref_hashentry_key_string.c_str(), possible_integer_arrayref_hashref_hashentry_key_string.c_str());
                }
            }
        }

        // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]
    }
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_hashref_CHECK(), bottom of subroutine\n");
}

// DEV NOTE, STEPS TO CONVERT FROM 2D TO 3D CHECK(TRACE)
// 1.  _arrayref_hashref -> _arrayref_hashref_hashref
// 2.  _arrayref_hash_ - _arrayref_hashref_hash_
// 3.  possible_TYPE_arrayref_hash -> possible_TYPE_arrayref_hashref_hash  (manual search, not full auto replace)
// 4.  _arrayref_hashentry -> _arrayref_hashref_hashentry
// 5.  AVRVHVRV -> AVRVHVRVHVRV
// 6.  AVRVHE -> AVRVHVRVHE
// 7.  paste 2D code, follow steps to convert below  (make sure to use corresponding CHECK vs CHECKTRACE)

void integer_arrayref_hashref_hashref_CHECKTRACE(SV* possible_integer_arrayref_hashref_hashref, const char* variable_name, const char* subroutine_name) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_hashref_CHECKTRACE(), top of subroutine, received variable_name = %s\n", variable_name);
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_hashref_CHECKTRACE(), top of subroutine, received subroutine_name = %s\n", subroutine_name);

    // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with integer-specific error codes
    if ( not( SvOK(possible_integer_arrayref_hashref_hashref) ) ) { croak( "\nERROR EIVAVRVHVRVHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref_hashref value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name ); }
    if ( not( SvHROKp(possible_integer_arrayref_hashref_hashref) ) ) { croak( "\nERROR EIVAVRVHVRVHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref_hashref value expected but non-hashref value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name ); }

    HV* possible_integer_arrayref_hashref_hash;
    integer possible_integer_arrayref_hashref_hash_num_keys;
    integer i;
    HE* possible_integer_arrayref_hashref_hashentry;
    SV* possible_integer_arrayref_hashref_hashentry_value;
    SV* possible_integer_arrayref_hashref_hashentry_key;
    string possible_integer_arrayref_hashref_hashentry_key_string;

    possible_integer_arrayref_hashref_hash = (HV*)SvRV(possible_integer_arrayref_hashref_hashref);
    possible_integer_arrayref_hashref_hash_num_keys = hv_iterinit(possible_integer_arrayref_hashref_hash);

    // incrementing iteration, iterator i not actually used in loop body
    for (i = 0;  i < possible_integer_arrayref_hashref_hash_num_keys;  ++i) {
        possible_integer_arrayref_hashref_hashentry = hv_iternext(possible_integer_arrayref_hashref_hash);

        // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with integer-specific error code
        if (possible_integer_arrayref_hashref_hashentry == NULL) { croak("\nERROR EIVAVRVHVRVHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref_hashentry value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name); }
        possible_integer_arrayref_hashref_hashentry_value = hv_iterval(possible_integer_arrayref_hashref_hash, possible_integer_arrayref_hashref_hashentry);

        // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
        // 1.  naming bridge
        // 2.  AVRVHVRV -> AVRVHVRVHVRV
        // 3.  AVRVHE -> AVRVHVRVHE
        // 4.  increment error code serial numbers by 2 for HVRV codes, by 1 for HE codes
        // 5.  add key info to first 2 pasted error messages
        // 6.  add sub-key info to remaining pasted error messages
        // 7.  j -> k
        // 8.  i -> j
        // 9.  delete pre-existing 1D ARRAY CODE

        // DEV NOTE: naming bridge between 3D code and pasted 2D code
        SV* possible_integer_arrayref_hashref = possible_integer_arrayref_hashref_hashentry_value;

        // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

        // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

        // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with integer-specific error codes
        if ( not( SvOK(possible_integer_arrayref_hashref) ) ) {
            possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
            possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR EIVAVRVHVRVHVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref value expected but undefined/null value found at key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_integer_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
        }
        if ( not( SvHROKp(possible_integer_arrayref_hashref) ) ) {
            possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
            possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR EIVAVRVHVRVHVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref value expected but non-hashref value found at key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_integer_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
        }

        HV* possible_integer_arrayref_hash;
        integer possible_integer_arrayref_hash_num_keys;
        integer j;
        HE* possible_integer_arrayref_hashentry;
        SV* possible_integer_arrayref_hashentry_value;
        SV* possible_integer_arrayref_hashentry_key;
        string possible_integer_arrayref_hashentry_key_string;

        possible_integer_arrayref_hash = (HV*)SvRV(possible_integer_arrayref_hashref);
        possible_integer_arrayref_hash_num_keys = hv_iterinit(possible_integer_arrayref_hash);

        // incrementing iteration, iterator j not actually used in loop body
        for (j = 0;  j < possible_integer_arrayref_hash_num_keys;  ++j) {
            possible_integer_arrayref_hashentry = hv_iternext(possible_integer_arrayref_hash);

            // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with integer-specific error code
            if (possible_integer_arrayref_hashentry == NULL) { croak("\nERROR EIVAVRVHVRVHE01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashentry value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name); }
            possible_integer_arrayref_hashentry_value = hv_iterval(possible_integer_arrayref_hash, possible_integer_arrayref_hashentry);

            // DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECK() macro & subroutine, but with hash-specific error codes
            if (not(SvOK(possible_integer_arrayref_hashentry_value))) {
                possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
                possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EIVAVRVHVRVHVRV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but undefined/null value found at sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_integer_arrayref_hashentry_key_string.c_str(), possible_integer_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
            }

            if (not(SvAROKp(possible_integer_arrayref_hashentry_value))) {
                possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
                possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EIVAVRVHVRVHVRV05, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but non-arrayref value found at sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_integer_arrayref_hashentry_key_string.c_str(), possible_integer_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
            }

            SV* possible_integer_arrayref = possible_integer_arrayref_hashentry_value;

            AV* possible_integer_array;
            integer possible_integer_array_length;
            integer k;
            SV** possible_integer_array_element;

            possible_integer_array = (AV*)SvRV(possible_integer_arrayref);
            possible_integer_array_length = av_len(possible_integer_array) + 1;

            // incrementing iteration
            for (k = 0;  k < possible_integer_array_length;  ++k) {
                possible_integer_array_element = av_fetch(possible_integer_array, k, 0);
                if (not(SvOK(*possible_integer_array_element))) {
                    possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
                    possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                    possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR EIVAVRVHVRVHVRV06, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found at index %"INTEGER", sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", k, possible_integer_arrayref_hashentry_key_string.c_str(), possible_integer_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
                }
                if (not(SvIOKp(*possible_integer_array_element))) {
                    possible_integer_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashref_hashentry);
                    possible_integer_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                    possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR EIVAVRVHVRVHVRV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found at index %"INTEGER", sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", k, possible_integer_arrayref_hashentry_key_string.c_str(), possible_integer_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
                }
            }
        }

        // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]
    }
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_hashref_CHECKTRACE(), bottom of subroutine\n");
}

// DEV NOTE, STEPS TO CONVERT FROM integer TO number:
// 1.  IV -> NV
// 2.  add SvNOKp to SvIOKp
// 3.  integer_ -> number_
// 4.  integer value -> number value
// 5.  integer- -> number-

void number_arrayref_hashref_hashref_CHECK(SV* possible_number_arrayref_hashref_hashref) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES number_arrayref_hashref_hashref_CHECK(), top of subroutine\n");

    // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with number-specific error codes
    if ( not( SvOK(possible_number_arrayref_hashref_hashref) ) ) { croak( "\nERROR ENVAVRVHVRVHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashref_hashref value expected but undefined/null value found,\ncroaking" ); }
    if ( not( SvHROKp(possible_number_arrayref_hashref_hashref) ) ) { croak( "\nERROR ENVAVRVHVRVHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashref_hashref value expected but non-hashref value found,\ncroaking" ); }

    HV* possible_number_arrayref_hashref_hash;
    integer possible_number_arrayref_hashref_hash_num_keys;
    integer i;
    HE* possible_number_arrayref_hashref_hashentry;
    SV* possible_number_arrayref_hashref_hashentry_value;
    SV* possible_number_arrayref_hashref_hashentry_key;
    string possible_number_arrayref_hashref_hashentry_key_string;

    possible_number_arrayref_hashref_hash = (HV*)SvRV(possible_number_arrayref_hashref_hashref);
    possible_number_arrayref_hashref_hash_num_keys = hv_iterinit(possible_number_arrayref_hashref_hash);

    // incrementing iteration, iterator i not actually used in loop body
    for (i = 0;  i < possible_number_arrayref_hashref_hash_num_keys;  ++i) {
        possible_number_arrayref_hashref_hashentry = hv_iternext(possible_number_arrayref_hashref_hash);

        // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with number-specific error code
        if (possible_number_arrayref_hashref_hashentry == NULL) { croak("\nERROR ENVAVRVHVRVHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashref_hashentry value expected but undefined/null value found,\ncroaking"); }
        possible_number_arrayref_hashref_hashentry_value = hv_iterval(possible_number_arrayref_hashref_hash, possible_number_arrayref_hashref_hashentry);

        // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
        // 1.  naming bridge
        // 2.  AVRVHVRV -> AVRVHVRVHVRV
        // 3.  AVRVHE -> AVRVHVRVHE
        // 4.  increment error code serial numbers by 2 for HVRV codes, by 1 for HE codes
        // 5.  add key info to first 2 pasted error messages
        // 6.  add sub-key info to remaining pasted error messages
        // 7.  j -> k
        // 8.  i -> j
        // 9.  delete pre-existing 1D ARRAY CODE

        // DEV NOTE: naming bridge between 3D code and pasted 2D code
        SV* possible_number_arrayref_hashref = possible_number_arrayref_hashref_hashentry_value;

        // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

        // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

        // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with number-specific error codes
        if ( not( SvOK(possible_number_arrayref_hashref) ) ) {
            possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
            possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR ENVAVRVHVRVHVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashref value expected but undefined/null value found at key '%s',\ncroaking", possible_number_arrayref_hashref_hashentry_key_string.c_str());
        }
        if ( not( SvHROKp(possible_number_arrayref_hashref) ) ) {
            possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
            possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR ENVAVRVHVRVHVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashref value expected but non-hashref value found at key '%s',\ncroaking", possible_number_arrayref_hashref_hashentry_key_string.c_str());
        }

        HV* possible_number_arrayref_hash;
        integer possible_number_arrayref_hash_num_keys;
        integer j;
        HE* possible_number_arrayref_hashentry;
        SV* possible_number_arrayref_hashentry_value;
        SV* possible_number_arrayref_hashentry_key;
        string possible_number_arrayref_hashentry_key_string;

        possible_number_arrayref_hash = (HV*)SvRV(possible_number_arrayref_hashref);
        possible_number_arrayref_hash_num_keys = hv_iterinit(possible_number_arrayref_hash);

        // incrementing iteration, iterator j not actually used in loop body
        for (j = 0;  j < possible_number_arrayref_hash_num_keys;  ++j) {
            possible_number_arrayref_hashentry = hv_iternext(possible_number_arrayref_hash);

            // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with number-specific error code
            if (possible_number_arrayref_hashentry == NULL) { croak("\nERROR ENVAVRVHVRVHE01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashentry value expected but undefined/null value found,\ncroaking"); }
            possible_number_arrayref_hashentry_value = hv_iterval(possible_number_arrayref_hash, possible_number_arrayref_hashentry);

            // DEV NOTE: the following two if() statements are functionally equivalent to the number_CHECK() macro & subroutine, but with hash-specific error codes
            if (not(SvOK(possible_number_arrayref_hashentry_value))) {
                possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
                possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_number_arrayref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashentry);
                possible_number_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR ENVAVRVHVRVHVRV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref value expected but undefined/null value found at sub-key '%s', key '%s',\ncroaking", possible_number_arrayref_hashentry_key_string.c_str(), possible_number_arrayref_hashref_hashentry_key_string.c_str());
            }

            if (not(SvAROKp(possible_number_arrayref_hashentry_value))) {
                possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
                possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_number_arrayref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashentry);
                possible_number_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR ENVAVRVHVRVHVRV05, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref value expected but non-arrayref value found at sub-key '%s', key '%s',\ncroaking", possible_number_arrayref_hashentry_key_string.c_str(), possible_number_arrayref_hashref_hashentry_key_string.c_str());
            }

            SV* possible_number_arrayref = possible_number_arrayref_hashentry_value;

            AV* possible_number_array;
            integer possible_number_array_length;
            integer k;
            SV** possible_number_array_element;

            possible_number_array = (AV*)SvRV(possible_number_arrayref);
            possible_number_array_length = av_len(possible_number_array) + 1;

            // incrementing iteration
            for (k = 0;  k < possible_number_array_length;  ++k) {
                possible_number_array_element = av_fetch(possible_number_array, k, 0);
                if (not(SvOK(*possible_number_array_element))) {
                    possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
                    possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_number_arrayref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashentry);
                    possible_number_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR ENVAVRVHVRVHVRV06, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found at index %"INTEGER", sub-key '%s', key '%s',\ncroaking", k, possible_number_arrayref_hashentry_key_string.c_str(), possible_number_arrayref_hashref_hashentry_key_string.c_str());
                }
                if (not(SvNOKp(*possible_number_array_element) or
                        SvIOKp(*possible_number_array_element))) {
                    possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
                    possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_number_arrayref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashentry);
                    possible_number_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR ENVAVRVHVRVHVRV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found at index %"INTEGER", sub-key '%s', key '%s',\ncroaking", k, possible_number_arrayref_hashentry_key_string.c_str(), possible_number_arrayref_hashref_hashentry_key_string.c_str());
                }
            }
        }

        // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]
    }
//    fprintf(stderr, "in CPPOPS_CPPTYPES number_arrayref_hashref_hashref_CHECK(), bottom of subroutine\n");
}

void number_arrayref_hashref_hashref_CHECKTRACE(SV* possible_number_arrayref_hashref_hashref, const char* variable_name, const char* subroutine_name) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES number_arrayref_hashref_hashref_CHECKTRACE(), top of subroutine, received variable_name = %s\n", variable_name);
//    fprintf(stderr, "in CPPOPS_CPPTYPES number_arrayref_hashref_hashref_CHECKTRACE(), top of subroutine, received subroutine_name = %s\n", subroutine_name);

    // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with number-specific error codes
    if ( not( SvOK(possible_number_arrayref_hashref_hashref) ) ) { croak( "\nERROR ENVAVRVHVRVHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashref_hashref value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name ); }
    if ( not( SvHROKp(possible_number_arrayref_hashref_hashref) ) ) { croak( "\nERROR ENVAVRVHVRVHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashref_hashref value expected but non-hashref value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name ); }

    HV* possible_number_arrayref_hashref_hash;
    integer possible_number_arrayref_hashref_hash_num_keys;
    integer i;
    HE* possible_number_arrayref_hashref_hashentry;
    SV* possible_number_arrayref_hashref_hashentry_value;
    SV* possible_number_arrayref_hashref_hashentry_key;
    string possible_number_arrayref_hashref_hashentry_key_string;

    possible_number_arrayref_hashref_hash = (HV*)SvRV(possible_number_arrayref_hashref_hashref);
    possible_number_arrayref_hashref_hash_num_keys = hv_iterinit(possible_number_arrayref_hashref_hash);

    // incrementing iteration, iterator i not actually used in loop body
    for (i = 0;  i < possible_number_arrayref_hashref_hash_num_keys;  ++i) {
        possible_number_arrayref_hashref_hashentry = hv_iternext(possible_number_arrayref_hashref_hash);

        // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with number-specific error code
        if (possible_number_arrayref_hashref_hashentry == NULL) { croak("\nERROR ENVAVRVHVRVHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashref_hashentry value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name); }
        possible_number_arrayref_hashref_hashentry_value = hv_iterval(possible_number_arrayref_hashref_hash, possible_number_arrayref_hashref_hashentry);

        // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
        // 1.  naming bridge
        // 2.  AVRVHVRV -> AVRVHVRVHVRV
        // 3.  AVRVHE -> AVRVHVRVHE
        // 4.  increment error code serial numbers by 2 for HVRV codes, by 1 for HE codes
        // 5.  add key info to first 2 pasted error messages
        // 6.  add sub-key info to remaining pasted error messages
        // 7.  j -> k
        // 8.  i -> j
        // 9.  delete pre-existing 1D ARRAY CODE

        // DEV NOTE: naming bridge between 3D code and pasted 2D code
        SV* possible_number_arrayref_hashref = possible_number_arrayref_hashref_hashentry_value;

        // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

        // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

        // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with number-specific error codes
        if ( not( SvOK(possible_number_arrayref_hashref) ) ) {
            possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
            possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR ENVAVRVHVRVHVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashref value expected but undefined/null value found at key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_number_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
        }
        if ( not( SvHROKp(possible_number_arrayref_hashref) ) ) {
            possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
            possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR ENVAVRVHVRVHVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashref value expected but non-hashref value found at key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_number_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
        }

        HV* possible_number_arrayref_hash;
        integer possible_number_arrayref_hash_num_keys;
        integer j;
        HE* possible_number_arrayref_hashentry;
        SV* possible_number_arrayref_hashentry_value;
        SV* possible_number_arrayref_hashentry_key;
        string possible_number_arrayref_hashentry_key_string;

        possible_number_arrayref_hash = (HV*)SvRV(possible_number_arrayref_hashref);
        possible_number_arrayref_hash_num_keys = hv_iterinit(possible_number_arrayref_hash);

        // incrementing iteration, iterator j not actually used in loop body
        for (j = 0;  j < possible_number_arrayref_hash_num_keys;  ++j) {
            possible_number_arrayref_hashentry = hv_iternext(possible_number_arrayref_hash);

            // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with number-specific error code
            if (possible_number_arrayref_hashentry == NULL) { croak("\nERROR ENVAVRVHVRVHE01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref_hashentry value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name); }
            possible_number_arrayref_hashentry_value = hv_iterval(possible_number_arrayref_hash, possible_number_arrayref_hashentry);

            // DEV NOTE: the following two if() statements are functionally equivalent to the number_CHECK() macro & subroutine, but with hash-specific error codes
            if (not(SvOK(possible_number_arrayref_hashentry_value))) {
                possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
                possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_number_arrayref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashentry);
                possible_number_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR ENVAVRVHVRVHVRV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref value expected but undefined/null value found at sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_number_arrayref_hashentry_key_string.c_str(), possible_number_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
            }

            if (not(SvAROKp(possible_number_arrayref_hashentry_value))) {
                possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
                possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_number_arrayref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashentry);
                possible_number_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR ENVAVRVHVRVHVRV05, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber_arrayref value expected but non-arrayref value found at sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_number_arrayref_hashentry_key_string.c_str(), possible_number_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
            }

            SV* possible_number_arrayref = possible_number_arrayref_hashentry_value;

            AV* possible_number_array;
            integer possible_number_array_length;
            integer k;
            SV** possible_number_array_element;

            possible_number_array = (AV*)SvRV(possible_number_arrayref);
            possible_number_array_length = av_len(possible_number_array) + 1;

            // incrementing iteration
            for (k = 0;  k < possible_number_array_length;  ++k) {
                possible_number_array_element = av_fetch(possible_number_array, k, 0);
                if (not(SvOK(*possible_number_array_element))) {
                    possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
                    possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_number_arrayref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashentry);
                    possible_number_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR ENVAVRVHVRVHVRV06, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found at index %"INTEGER", sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", k, possible_number_arrayref_hashentry_key_string.c_str(), possible_number_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
                }
                if (not(SvNOKp(*possible_number_array_element) or
                        SvIOKp(*possible_number_array_element))) {
                    possible_number_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashref_hashentry);
                    possible_number_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_number_arrayref_hashentry_key = hv_iterkeysv(possible_number_arrayref_hashentry);
                    possible_number_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_number_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR ENVAVRVHVRVHVRV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found at index %"INTEGER", sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", k, possible_number_arrayref_hashentry_key_string.c_str(), possible_number_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
                }
            }
        }

        // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]
    }
//    fprintf(stderr, "in CPPOPS_CPPTYPES number_arrayref_hashref_hashref_CHECKTRACE(), bottom of subroutine\n");
}

// DEV NOTE, STEPS TO CONVERT FROM number TO string:
// 1.  ENVAV -> EPVAV
// 2.  remove SvIOKp
// 3.  SvNOKp -> SvPOKp
// 4.  number_ -> string_
// 5.  number value -> string value
// x.  number- -> string-

void string_arrayref_hashref_hashref_CHECK(SV* possible_string_arrayref_hashref_hashref) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES string_arrayref_hashref_hashref_CHECK(), top of subroutine\n");

    // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with string-specific error codes
    if ( not( SvOK(possible_string_arrayref_hashref_hashref) ) ) { croak( "\nERROR EPVAVRVHVRVHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashref_hashref value expected but undefined/null value found,\ncroaking" ); }
    if ( not( SvHROKp(possible_string_arrayref_hashref_hashref) ) ) { croak( "\nERROR EPVAVRVHVRVHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashref_hashref value expected but non-hashref value found,\ncroaking" ); }

    HV* possible_string_arrayref_hashref_hash;
    integer possible_string_arrayref_hashref_hash_num_keys;
    integer i;
    HE* possible_string_arrayref_hashref_hashentry;
    SV* possible_string_arrayref_hashref_hashentry_value;
    SV* possible_string_arrayref_hashref_hashentry_key;
    string possible_string_arrayref_hashref_hashentry_key_string;

    possible_string_arrayref_hashref_hash = (HV*)SvRV(possible_string_arrayref_hashref_hashref);
    possible_string_arrayref_hashref_hash_num_keys = hv_iterinit(possible_string_arrayref_hashref_hash);

    // incrementing iteration, iterator i not actually used in loop body
    for (i = 0;  i < possible_string_arrayref_hashref_hash_num_keys;  ++i) {
        possible_string_arrayref_hashref_hashentry = hv_iternext(possible_string_arrayref_hashref_hash);

        // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with string-specific error code
        if (possible_string_arrayref_hashref_hashentry == NULL) { croak("\nERROR EPVAVRVHVRVHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashref_hashentry value expected but undefined/null value found,\ncroaking"); }
        possible_string_arrayref_hashref_hashentry_value = hv_iterval(possible_string_arrayref_hashref_hash, possible_string_arrayref_hashref_hashentry);

        // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
        // 1.  naming bridge
        // 2.  AVRVHVRV -> AVRVHVRVHVRV
        // 3.  AVRVHE -> AVRVHVRVHE
        // 4.  increment error code serial numbers by 2 for HVRV codes, by 1 for HE codes
        // 5.  add key info to first 2 pasted error messages
        // 6.  add sub-key info to remaining pasted error messages
        // 7.  j -> k
        // 8.  i -> j
        // 9.  delete pre-existing 1D ARRAY CODE

        // DEV NOTE: naming bridge between 3D code and pasted 2D code
        SV* possible_string_arrayref_hashref = possible_string_arrayref_hashref_hashentry_value;

        // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

        // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

        // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with string-specific error codes
        if ( not( SvOK(possible_string_arrayref_hashref) ) ) {
            possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
            possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR EPVAVRVHVRVHVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashref value expected but undefined/null value found at key '%s',\ncroaking", possible_string_arrayref_hashref_hashentry_key_string.c_str());
        }
        if ( not( SvHROKp(possible_string_arrayref_hashref) ) ) {
            possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
            possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR EPVAVRVHVRVHVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashref value expected but non-hashref value found at key '%s',\ncroaking", possible_string_arrayref_hashref_hashentry_key_string.c_str());
        }

        HV* possible_string_arrayref_hash;
        integer possible_string_arrayref_hash_num_keys;
        integer j;
        HE* possible_string_arrayref_hashentry;
        SV* possible_string_arrayref_hashentry_value;
        SV* possible_string_arrayref_hashentry_key;
        string possible_string_arrayref_hashentry_key_string;

        possible_string_arrayref_hash = (HV*)SvRV(possible_string_arrayref_hashref);
        possible_string_arrayref_hash_num_keys = hv_iterinit(possible_string_arrayref_hash);

        // incrementing iteration, iterator j not actually used in loop body
        for (j = 0;  j < possible_string_arrayref_hash_num_keys;  ++j) {
            possible_string_arrayref_hashentry = hv_iternext(possible_string_arrayref_hash);

            // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with string-specific error code
            if (possible_string_arrayref_hashentry == NULL) { croak("\nERROR EPVAVRVHVRVHE01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashentry value expected but undefined/null value found,\ncroaking"); }
            possible_string_arrayref_hashentry_value = hv_iterval(possible_string_arrayref_hash, possible_string_arrayref_hashentry);

            // DEV NOTE: the following two if() statements are functionally equivalent to the string_CHECK() macro & subroutine, but with hash-specific error codes
            if (not(SvOK(possible_string_arrayref_hashentry_value))) {
                possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
                possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_string_arrayref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashentry);
                possible_string_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EPVAVRVHVRVHVRV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref value expected but undefined/null value found at sub-key '%s', key '%s',\ncroaking", possible_string_arrayref_hashentry_key_string.c_str(), possible_string_arrayref_hashref_hashentry_key_string.c_str());
            }

            if (not(SvAROKp(possible_string_arrayref_hashentry_value))) {
                possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
                possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_string_arrayref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashentry);
                possible_string_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EPVAVRVHVRVHVRV05, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref value expected but non-arrayref value found at sub-key '%s', key '%s',\ncroaking", possible_string_arrayref_hashentry_key_string.c_str(), possible_string_arrayref_hashref_hashentry_key_string.c_str());
            }

            SV* possible_string_arrayref = possible_string_arrayref_hashentry_value;

            AV* possible_string_array;
            integer possible_string_array_length;
            integer k;
            SV** possible_string_array_element;

            possible_string_array = (AV*)SvRV(possible_string_arrayref);
            possible_string_array_length = av_len(possible_string_array) + 1;

            // incrementing iteration
            for (k = 0;  k < possible_string_array_length;  ++k) {
                possible_string_array_element = av_fetch(possible_string_array, k, 0);
                if (not(SvOK(*possible_string_array_element))) {
                    possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
                    possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_string_arrayref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashentry);
                    possible_string_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR EPVAVRVHVRVHVRV06, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found at index %"INTEGER", sub-key '%s', key '%s',\ncroaking", k, possible_string_arrayref_hashentry_key_string.c_str(), possible_string_arrayref_hashref_hashentry_key_string.c_str());
                }
                if (not(SvPOKp(*possible_string_array_element))) {
                    possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
                    possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_string_arrayref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashentry);
                    possible_string_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR EPVAVRVHVRVHVRV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found at index %"INTEGER", sub-key '%s', key '%s',\ncroaking", k, possible_string_arrayref_hashentry_key_string.c_str(), possible_string_arrayref_hashref_hashentry_key_string.c_str());
                }
            }
        }

        // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]
    }
//    fprintf(stderr, "in CPPOPS_CPPTYPES string_arrayref_hashref_hashref_CHECK(), bottom of subroutine\n");
}

void string_arrayref_hashref_hashref_CHECKTRACE(SV* possible_string_arrayref_hashref_hashref, const char* variable_name, const char* subroutine_name) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES string_arrayref_hashref_hashref_CHECKTRACE(), top of subroutine, received variable_name = %s\n", variable_name);
//    fprintf(stderr, "in CPPOPS_CPPTYPES string_arrayref_hashref_hashref_CHECKTRACE(), top of subroutine, received subroutine_name = %s\n", subroutine_name);

    // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with string-specific error codes
    if ( not( SvOK(possible_string_arrayref_hashref_hashref) ) ) { croak( "\nERROR EPVAVRVHVRVHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashref_hashref value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name ); }
    if ( not( SvHROKp(possible_string_arrayref_hashref_hashref) ) ) { croak( "\nERROR EPVAVRVHVRVHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashref_hashref value expected but non-hashref value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name ); }

    HV* possible_string_arrayref_hashref_hash;
    integer possible_string_arrayref_hashref_hash_num_keys;
    integer i;
    HE* possible_string_arrayref_hashref_hashentry;
    SV* possible_string_arrayref_hashref_hashentry_value;
    SV* possible_string_arrayref_hashref_hashentry_key;
    string possible_string_arrayref_hashref_hashentry_key_string;

    possible_string_arrayref_hashref_hash = (HV*)SvRV(possible_string_arrayref_hashref_hashref);
    possible_string_arrayref_hashref_hash_num_keys = hv_iterinit(possible_string_arrayref_hashref_hash);

    // incrementing iteration, iterator i not actually used in loop body
    for (i = 0;  i < possible_string_arrayref_hashref_hash_num_keys;  ++i) {
        possible_string_arrayref_hashref_hashentry = hv_iternext(possible_string_arrayref_hashref_hash);

        // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with string-specific error code
        if (possible_string_arrayref_hashref_hashentry == NULL) { croak("\nERROR EPVAVRVHVRVHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashref_hashentry value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name); }
        possible_string_arrayref_hashref_hashentry_value = hv_iterval(possible_string_arrayref_hashref_hash, possible_string_arrayref_hashref_hashentry);

        // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
        // 1.  naming bridge
        // 2.  AVRVHVRV -> AVRVHVRVHVRV
        // 3.  AVRVHE -> AVRVHVRVHE
        // 4.  increment error code serial numbers by 2 for HVRV codes, by 1 for HE codes
        // 5.  add key info to first 2 pasted error messages
        // 6.  add sub-key info to remaining pasted error messages
        // 7.  j -> k
        // 8.  i -> j
        // 9.  delete pre-existing 1D ARRAY CODE

        // DEV NOTE: naming bridge between 3D code and pasted 2D code
        SV* possible_string_arrayref_hashref = possible_string_arrayref_hashref_hashentry_value;

        // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

        // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

        // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with string-specific error codes
        if ( not( SvOK(possible_string_arrayref_hashref) ) ) {
            possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
            possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR EPVAVRVHVRVHVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashref value expected but undefined/null value found at key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_string_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
        }
        if ( not( SvHROKp(possible_string_arrayref_hashref) ) ) {
            possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
            possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
            croak( "\nERROR EPVAVRVHVRVHVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashref value expected but non-hashref value found at key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_string_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
        }

        HV* possible_string_arrayref_hash;
        integer possible_string_arrayref_hash_num_keys;
        integer j;
        HE* possible_string_arrayref_hashentry;
        SV* possible_string_arrayref_hashentry_value;
        SV* possible_string_arrayref_hashentry_key;
        string possible_string_arrayref_hashentry_key_string;

        possible_string_arrayref_hash = (HV*)SvRV(possible_string_arrayref_hashref);
        possible_string_arrayref_hash_num_keys = hv_iterinit(possible_string_arrayref_hash);

        // incrementing iteration, iterator j not actually used in loop body
        for (j = 0;  j < possible_string_arrayref_hash_num_keys;  ++j) {
            possible_string_arrayref_hashentry = hv_iternext(possible_string_arrayref_hash);

            // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with string-specific error code
            if (possible_string_arrayref_hashentry == NULL) { croak("\nERROR EPVAVRVHVRVHE01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref_hashentry value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name); }
            possible_string_arrayref_hashentry_value = hv_iterval(possible_string_arrayref_hash, possible_string_arrayref_hashentry);

            // DEV NOTE: the following two if() statements are functionally equivalent to the string_CHECK() macro & subroutine, but with hash-specific error codes
            if (not(SvOK(possible_string_arrayref_hashentry_value))) {
                possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
                possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_string_arrayref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashentry);
                possible_string_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EPVAVRVHVRVHVRV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref value expected but undefined/null value found at sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_string_arrayref_hashentry_key_string.c_str(), possible_string_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
            }

            if (not(SvAROKp(possible_string_arrayref_hashentry_value))) {
                possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
                possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
                possible_string_arrayref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashentry);
                possible_string_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EPVAVRVHVRVHVRV05, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring_arrayref value expected but non-arrayref value found at sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_string_arrayref_hashentry_key_string.c_str(), possible_string_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
            }

            SV* possible_string_arrayref = possible_string_arrayref_hashentry_value;

            AV* possible_string_array;
            integer possible_string_array_length;
            integer k;
            SV** possible_string_array_element;

            possible_string_array = (AV*)SvRV(possible_string_arrayref);
            possible_string_array_length = av_len(possible_string_array) + 1;

            // incrementing iteration
            for (k = 0;  k < possible_string_array_length;  ++k) {
                possible_string_array_element = av_fetch(possible_string_array, k, 0);
                if (not(SvOK(*possible_string_array_element))) {
                    possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
                    possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_string_arrayref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashentry);
                    possible_string_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR EPVAVRVHVRVHVRV06, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found at index %"INTEGER", sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", k, possible_string_arrayref_hashentry_key_string.c_str(), possible_string_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
                }
                if (not(SvPOKp(*possible_string_array_element))) {
                    possible_string_arrayref_hashref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashref_hashentry);
                    possible_string_arrayref_hashref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashref_hashentry_key)));  // escape key string for error message
                    possible_string_arrayref_hashentry_key = hv_iterkeysv(possible_string_arrayref_hashentry);
                    possible_string_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_string_arrayref_hashentry_key)));  // escape key string for error message
                    croak("\nERROR EPVAVRVHVRVHVRV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found at index %"INTEGER", sub-key '%s', key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", k, possible_string_arrayref_hashentry_key_string.c_str(), possible_string_arrayref_hashref_hashentry_key_string.c_str(), variable_name, subroutine_name);
                }
            }
        }

        // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]
    }
//    fprintf(stderr, "in CPPOPS_CPPTYPES string_arrayref_hashref_hashref_CHECKTRACE(), bottom of subroutine\n");
}

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES

// convert from (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))))))) to (C++ std::unordered_map of (C++ std::unordered_map of (C++ std::vector of integers)))
integer_arrayref_hashref_hashref XS_unpack_integer_arrayref_hashref_hashref(SV* input_avref_hvref_hvref) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref_hashref(), top of subroutine\n");

//    integer_arrayref_hashref_hashref_CHECK(input_avref_hvref_hvref);
    integer_arrayref_hashref_hashref_CHECKTRACE(input_avref_hvref_hvref, "input_avref_hvref_hvref", "XS_unpack_integer_arrayref_hashref_hashref()");

    HV* input_avref_hvref_hv;
    integer input_avref_hvref_hv_num_keys;
    integer i;
    HE* input_avref_hvref_hv_entry;
    SV* input_avref_hvref_hv_entry_key;
    SV* input_avref_hvref_hv_entry_value;
    integer_arrayref_hashref_hashref output_vector_unordered_map_unordered_map;

    input_avref_hvref_hv = (HV*)SvRV(input_avref_hvref_hvref);

    input_avref_hvref_hv_num_keys = hv_iterinit(input_avref_hvref_hv);
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref_hashref(), have input_avref_hvref_hv_num_keys = %"INTEGER"\n", input_avref_hvref_hv_num_keys);

    // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
    // reserve() ahead of time to avoid resizing and rehashing in for() loop
    output_vector_unordered_map_unordered_map.reserve((size_t)input_avref_hvref_hv_num_keys);

    // incrementing iteration, iterator i not actually used in loop body
    for (i = 0;  i < input_avref_hvref_hv_num_keys;  ++i) {
        // does not utilize i in entry retrieval
        input_avref_hvref_hv_entry = hv_iternext(input_avref_hvref_hv);
        // DEV NOTE: hash entry type-checking already done as part of integer_arrayref_hashref_hashref_CHECKTRACE()
//      hashentry_CHECK(input_avref_hvref_hv_entry);
//      hashentry_CHECKTRACE(input_avref_hvref_hv_entry, "input_avref_hvref_hv_entry", "XS_unpack_integer_arrayref_hashref_hashref()");

        input_avref_hvref_hv_entry_key = hv_iterkeysv(input_avref_hvref_hv_entry);
        input_avref_hvref_hv_entry_value = hv_iterval(input_avref_hvref_hv, input_avref_hvref_hv_entry);
        // DEV NOTE: integer type-checking already done as part of integer_arrayref_hashref_hashref_CHECKTRACE()
//      integer_CHECK(input_avref_hvref_hv_entry_value);
//      integer_CHECKTRACE(input_avref_hvref_hv_entry_value, (char*)((string)"input_avref_hvref_hv_entry_value at key '" + (string)SvPV_nolen(input_avref_hvref_hv_entry_key) + "'").c_str(), "XS_unpack_integer_arrayref_hashref_hashref()");

        // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
        // 1.  delete pre-existing 1D ARRAY CODE
        // 2.  naming bridge
        // 3.  XS_unpack_TYPE_arrayref_hashref -> XS_unpack_TYPE_arrayref_hashref_hashref
        // 4.  UNORDERED MAP ENTRY ASSIGNMENT under pasted 2D code, output_vector -> output_vector_unordered_map
        // 5.  j -> k
        // 6.  i -> j

        // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

        // DEV NOTE: naming bridge between 3D code and pasted 2D code
        SV* input_avref_hvref = input_avref_hvref_hv_entry_value;

        // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

        //    integer_arrayref_hashref_CHECK(input_avref_hvref);
            integer_arrayref_hashref_CHECKTRACE(input_avref_hvref, "input_avref_hvref", "XS_unpack_integer_arrayref_hashref_hashref()");

            HV* input_avref_hv;
            integer input_avref_hv_num_keys;
            integer j;
            HE* input_avref_hv_entry;
            SV* input_avref_hv_entry_key;
            SV* input_avref_hv_entry_value;
            integer_arrayref_hashref output_vector_unordered_map;

            input_avref_hv = (HV*)SvRV(input_avref_hvref);

            input_avref_hv_num_keys = hv_iterinit(input_avref_hv);
        //    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref_hashref(), have input_avref_hv_num_keys = %"INTEGER"\n", input_avref_hv_num_keys);

            // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
            // reserve() ahead of time to avoid resizing and rehashing in for() loop
            output_vector_unordered_map.reserve((size_t)input_avref_hv_num_keys);

            // incrementing iteration, iterator i not actually used in loop body
            for (j = 0;  j < input_avref_hv_num_keys;  ++j) {
                // does not utilize j in entry retrieval
                input_avref_hv_entry = hv_iternext(input_avref_hv);
                // DEV NOTE: hash entry type-checking already done as part of integer_arrayref_hashref_CHECKTRACE()
        //      hashentry_CHECK(input_avref_hv_entry);
        //      hashentry_CHECKTRACE(input_avref_hv_entry, "input_avref_hv_entry", "XS_unpack_integer_arrayref_hashref_hashref()");

                input_avref_hv_entry_key = hv_iterkeysv(input_avref_hv_entry);
                input_avref_hv_entry_value = hv_iterval(input_avref_hv, input_avref_hv_entry);
                // DEV NOTE: integer type-checking already done as part of integer_arrayref_hashref_CHECKTRACE()
        //      integer_CHECK(input_avref_hv_entry_value);
        //      integer_CHECKTRACE(input_avref_hv_entry_value, (char*)((string)"input_avref_hv_entry_value at key '" + (string)SvPV_nolen(input_avref_hv_entry_key) + "'").c_str(), "XS_unpack_integer_arrayref_hashref_hashref()");

                // [[[ BEGIN PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

                AV* input_av;
                integer input_av_length;
                integer k;
                SV** input_av_element;
                integer_arrayref output_vector;

        //      input_av = (AV*)SvRV(*input_avref);  // input_avref is an unused shorthand for input_avref_hv_entry_value
        //        input_av = (AV*)SvRV(*input_avref_hv_entry_value);  // error: base operand of ‘->’ has non-pointer type ‘SV {aka sv}’, in expansion of macro ‘SvRV’
                input_av = (AV*)SvRV(input_avref_hv_entry_value);
                input_av_length = av_len(input_av) + 1;
        //        fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref_hashref(), have input_av_length = %"INTEGER"\n", input_av_length);

                // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
                // resize() ahead of time to allow l-value subscript notation
                output_vector.resize((size_t)input_av_length);

                // incrementing iteration
                for (k = 0;  k < input_av_length;  ++k) {
                    // utilizes k in element retrieval
                    input_av_element = av_fetch(input_av, k, 0);

                    // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes k in assignment
                    output_vector[k] = SvIV(*input_av_element);
                }

        //        fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref_hashref(), bottom of inner for() loop k = %"INTEGER", have output_vector.size() = %"INTEGER"\n", k, (integer) output_vector.size());

                // [[[ END PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

                // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize j in assignment
                output_vector_unordered_map[SvPV_nolen(input_avref_hv_entry_key)] = output_vector;
            }

        //    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref_hashref(), after outer for() loop, have output_vector_unordered_map.size() = %"INTEGER"\n", output_vector_unordered_map.size());

        // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]

        // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize i in assignment
        output_vector_unordered_map_unordered_map[SvPV_nolen(input_avref_hvref_hv_entry_key)] = output_vector_unordered_map;
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref_hashref(), after outer for() loop, have output_vector_unordered_map_unordered_map.size() = %"INTEGER"\n", output_vector_unordered_map_unordered_map.size());
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref_hashref(), bottom of subroutine\n");

    return(output_vector_unordered_map_unordered_map);
}

// convert from (C++ std::unordered_map of (C++ std::unordered_map of (C++ std::vector of integers))) to (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs)))))))
void XS_pack_integer_arrayref_hashref_hashref(SV* output_avref_hvref_hvref, integer_arrayref_hashref_hashref input_vector_unordered_map_unordered_map) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), top of subroutine\n");

    HV* output_avref_hvref_hv = newHV();  // initialize output hash-of-hashes-of-arrays to empty
    integer input_vector_unordered_map_unordered_map_num_keys = input_vector_unordered_map_unordered_map.size();
    integer_arrayref_hashref_hashref_const_iterator i;
    SV* temp_sv_pointer;

//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), have input_vector_unordered_map_unordered_map_num_keys = %"INTEGER"\n", input_vector_unordered_map_unordered_map_num_keys);

    if (input_vector_unordered_map_unordered_map_num_keys > 0) {
        for (i = input_vector_unordered_map_unordered_map.begin();  i != input_vector_unordered_map_unordered_map.end();  ++i) {
//            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), top of outer loop, have i->first AKA key = '%s'\n", (i->first).c_str());
            integer_arrayref_hashref input_vector_unordered_map = i->second;

            // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
            // 1.  delete pre-existing 1D ARRAY CODE
            // 2.  no naming bridge required
            // 3.  XS_unpack_TYPE_arrayref_hashref -> XS_unpack_TYPE_arrayref_hashref_hashref
            // 4.  hv_store under pasted 2D code, output_av -> output_avref_hv
            // 5.  j -> k
            // 6.  i -> j

            // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

            // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

            HV* output_avref_hv = newHV();  // initialize output hash-of-arrays to empty
            integer input_vector_unordered_map_num_keys = input_vector_unordered_map.size();
            integer_arrayref_hashref_const_iterator j;
            SV* temp_sv_pointer;

        //    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), have input_vector_unordered_map_num_keys = %"INTEGER"\n", input_vector_unordered_map_num_keys);

            if (input_vector_unordered_map_num_keys > 0) {
                for (j = input_vector_unordered_map.begin();  j != input_vector_unordered_map.end();  ++j) {
        //            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), top of outer loop, have j->first AKA key = '%s'\n", (j->first).c_str());
                    integer_arrayref input_vector = j->second;

                    // [[[ BEGIN PASTED-AND-CONVERTED 1D ARRAY CODE ]]]
                    AV* output_av = newAV();  // initialize output sub-array to empty
                    integer input_vector_length = input_vector.size();
                    integer k;

        //            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), have input_vector_length = %"INTEGER"\n", input_vector_length);

                    if (input_vector_length > 0) {
                        for (k = 0;  k < input_vector_length;  ++k) {
        //                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), top of inner loop, have (j->first, k) = ('%s', %"INTEGER")\n", (j->first).c_str(), k);
        //                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), have input_vector_unordered_map['%s'][%"INTEGER"] = %"INTEGER"\n", (j->first).c_str(), k, input_vector[k]);
                            av_push(output_av, newSViv(input_vector[k]));
        //                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), bottom of inner loop, have (j->first, k) = ('%s', %"INTEGER")\n", (j->first).c_str(), k);
                        }
                    }
                    else warn("in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), sub-array was empty, returning empty sub-array via newAV()");
                    // [[[ END PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

                    // NEED ANSWER: is it really okay to NOT increase the reference count below???
                    hv_store(output_avref_hv, (const char*)((j->first).c_str()), (U32)((j->first).size()), newRV_noinc((SV*)output_av), (U32)0);  // reference, do not increase reference count
        //            hv_store(output_avref_hv, (const char*)((j->first).c_str()), (U32)((j->first).size()), newRV_inc((SV*)output_av), (U32)0);  // reference, do increase reference count

        //            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), bottom of outer loop, have j->first = '%s'\n", (j->first).c_str());
                }
            }
            else warn("in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), hash was empty, returning empty hash via newHV()");

            // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]

            // NEED ANSWER: is it really okay to NOT increase the reference count below???
            hv_store(output_avref_hvref_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newRV_noinc((SV*)output_avref_hv), (U32)0);  // reference, do not increase reference count
//            hv_store(output_avref_hvref_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newRV_inc((SV*)output_avref_hv), (U32)0);  // reference, do increase reference count

//            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), bottom of outer loop, have i->first = '%s'\n", (i->first).c_str());
        }
    }
    else warn("in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), hash was empty, returning empty hash via newHV()");

    temp_sv_pointer = newSVrv(output_avref_hvref_hvref, NULL);    // upgrade output stack SV to an RV
    SvREFCNT_dec(temp_sv_pointer);       // discard temporary pointer
    SvRV(output_avref_hvref_hvref) = (SV*)output_avref_hvref_hv;       // make output stack RV pointer at our output HV

//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref_hashref(), bottom of subroutine\n");
}

// DEV NOTE, STEPS TO CONVERT FROM integer TO number:
// 1.  IV -> NV
// 2.  SViv -> SVnv
// 3.  integers -> numbers
// 4.  integer_ -> number_

// convert from (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs))))))) to (C++ std::unordered_map of (C++ std::unordered_map of (C++ std::vector of numbers)))
number_arrayref_hashref_hashref XS_unpack_number_arrayref_hashref_hashref(SV* input_avref_hvref_hvref) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref_hashref_hashref(), top of subroutine\n");

//    number_arrayref_hashref_hashref_CHECK(input_avref_hvref_hvref);
    number_arrayref_hashref_hashref_CHECKTRACE(input_avref_hvref_hvref, "input_avref_hvref_hvref", "XS_unpack_number_arrayref_hashref_hashref()");

    HV* input_avref_hvref_hv;
    integer input_avref_hvref_hv_num_keys;
    integer i;
    HE* input_avref_hvref_hv_entry;
    SV* input_avref_hvref_hv_entry_key;
    SV* input_avref_hvref_hv_entry_value;
    number_arrayref_hashref_hashref output_vector_unordered_map_unordered_map;

    input_avref_hvref_hv = (HV*)SvRV(input_avref_hvref_hvref);

    input_avref_hvref_hv_num_keys = hv_iterinit(input_avref_hvref_hv);
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref_hashref_hashref(), have input_avref_hvref_hv_num_keys = %"INTEGER"\n", input_avref_hvref_hv_num_keys);

    // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
    // reserve() ahead of time to avoid resizing and rehashing in for() loop
    output_vector_unordered_map_unordered_map.reserve((size_t)input_avref_hvref_hv_num_keys);

    // incrementing iteration, iterator i not actually used in loop body
    for (i = 0;  i < input_avref_hvref_hv_num_keys;  ++i) {
        // does not utilize i in entry retrieval
        input_avref_hvref_hv_entry = hv_iternext(input_avref_hvref_hv);
        // DEV NOTE: hash entry type-checking already done as part of number_arrayref_hashref_hashref_CHECKTRACE()
//      hashentry_CHECK(input_avref_hvref_hv_entry);
//      hashentry_CHECKTRACE(input_avref_hvref_hv_entry, "input_avref_hvref_hv_entry", "XS_unpack_number_arrayref_hashref_hashref()");

        input_avref_hvref_hv_entry_key = hv_iterkeysv(input_avref_hvref_hv_entry);
        input_avref_hvref_hv_entry_value = hv_iterval(input_avref_hvref_hv, input_avref_hvref_hv_entry);
        // DEV NOTE: integer type-checking already done as part of number_arrayref_hashref_hashref_CHECKTRACE()
//      number_CHECK(input_avref_hvref_hv_entry_value);
//      number_CHECKTRACE(input_avref_hvref_hv_entry_value, (char*)((string)"input_avref_hvref_hv_entry_value at key '" + (string)SvPV_nolen(input_avref_hvref_hv_entry_key) + "'").c_str(), "XS_unpack_number_arrayref_hashref_hashref()");

        // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
        // 1.  delete pre-existing 1D ARRAY CODE
        // 2.  naming bridge
        // 3.  XS_unpack_TYPE_arrayref_hashref -> XS_unpack_TYPE_arrayref_hashref_hashref
        // 4.  UNORDERED MAP ENTRY ASSIGNMENT under pasted 2D code, output_vector -> output_vector_unordered_map
        // 5.  j -> k
        // 6.  i -> j

        // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

        // DEV NOTE: naming bridge between 3D code and pasted 2D code
        SV* input_avref_hvref = input_avref_hvref_hv_entry_value;

        // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

        //    number_arrayref_hashref_CHECK(input_avref_hvref);
            number_arrayref_hashref_CHECKTRACE(input_avref_hvref, "input_avref_hvref", "XS_unpack_number_arrayref_hashref_hashref()");

            HV* input_avref_hv;
            integer input_avref_hv_num_keys;
            integer j;
            HE* input_avref_hv_entry;
            SV* input_avref_hv_entry_key;
            SV* input_avref_hv_entry_value;
            number_arrayref_hashref output_vector_unordered_map;

            input_avref_hv = (HV*)SvRV(input_avref_hvref);

            input_avref_hv_num_keys = hv_iterinit(input_avref_hv);
        //    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref_hashref_hashref(), have input_avref_hv_num_keys = %"INTEGER"\n", input_avref_hv_num_keys);

            // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
            // reserve() ahead of time to avoid resizing and rehashing in for() loop
            output_vector_unordered_map.reserve((size_t)input_avref_hv_num_keys);

            // incrementing iteration, iterator i not actually used in loop body
            for (j = 0;  j < input_avref_hv_num_keys;  ++j) {
                // does not utilize j in entry retrieval
                input_avref_hv_entry = hv_iternext(input_avref_hv);
                // DEV NOTE: hash entry type-checking already done as part of number_arrayref_hashref_CHECKTRACE()
        //      hashentry_CHECK(input_avref_hv_entry);
        //      hashentry_CHECKTRACE(input_avref_hv_entry, "input_avref_hv_entry", "XS_unpack_number_arrayref_hashref_hashref()");

                input_avref_hv_entry_key = hv_iterkeysv(input_avref_hv_entry);
                input_avref_hv_entry_value = hv_iterval(input_avref_hv, input_avref_hv_entry);
                // DEV NOTE: integer type-checking already done as part of number_arrayref_hashref_CHECKTRACE()
        //      number_CHECK(input_avref_hv_entry_value);
        //      number_CHECKTRACE(input_avref_hv_entry_value, (char*)((string)"input_avref_hv_entry_value at key '" + (string)SvPV_nolen(input_avref_hv_entry_key) + "'").c_str(), "XS_unpack_number_arrayref_hashref_hashref()");

                // [[[ BEGIN PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

                AV* input_av;
                integer input_av_length;
                integer k;
                SV** input_av_element;
                number_arrayref output_vector;

        //      input_av = (AV*)SvRV(*input_avref);  // input_avref is an unused shorthand for input_avref_hv_entry_value
        //        input_av = (AV*)SvRV(*input_avref_hv_entry_value);  // error: base operand of ‘->’ has non-pointer type ‘SV {aka sv}’, in expansion of macro ‘SvRV’
                input_av = (AV*)SvRV(input_avref_hv_entry_value);
                input_av_length = av_len(input_av) + 1;
        //        fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref_hashref_hashref(), have input_av_length = %"INTEGER"\n", input_av_length);

                // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
                // resize() ahead of time to allow l-value subscript notation
                output_vector.resize((size_t)input_av_length);

                // incrementing iteration
                for (k = 0;  k < input_av_length;  ++k) {
                    // utilizes k in element retrieval
                    input_av_element = av_fetch(input_av, k, 0);

                    // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes k in assignment
                    output_vector[k] = SvNV(*input_av_element);
                }

        //        fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref_hashref_hashref(), bottom of inner for() loop k = %"INTEGER", have output_vector.size() = %"INTEGER"\n", k, (integer) output_vector.size());

                // [[[ END PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

                // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize j in assignment
                output_vector_unordered_map[SvPV_nolen(input_avref_hv_entry_key)] = output_vector;
            }

        //    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref_hashref_hashref(), after outer for() loop, have output_vector_unordered_map.size() = %"INTEGER"\n", output_vector_unordered_map.size());

        // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]

        // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize i in assignment
        output_vector_unordered_map_unordered_map[SvPV_nolen(input_avref_hvref_hv_entry_key)] = output_vector_unordered_map;
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref_hashref_hashref(), after outer for() loop, have output_vector_unordered_map_unordered_map.size() = %"INTEGER"\n", output_vector_unordered_map_unordered_map.size());
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number_arrayref_hashref_hashref(), bottom of subroutine\n");

    return(output_vector_unordered_map_unordered_map);
}

// convert from (C++ std::unordered_map of (C++ std::unordered_map of (C++ std::vector of numbers))) to (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs)))))))
void XS_pack_number_arrayref_hashref_hashref(SV* output_avref_hvref_hvref, number_arrayref_hashref_hashref input_vector_unordered_map_unordered_map) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), top of subroutine\n");

    HV* output_avref_hvref_hv = newHV();  // initialize output hash-of-hashes-of-arrays to empty
    integer input_vector_unordered_map_unordered_map_num_keys = input_vector_unordered_map_unordered_map.size();
    number_arrayref_hashref_hashref_const_iterator i;
    SV* temp_sv_pointer;

//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), have input_vector_unordered_map_unordered_map_num_keys = %"INTEGER"\n", input_vector_unordered_map_unordered_map_num_keys);

    if (input_vector_unordered_map_unordered_map_num_keys > 0) {
        for (i = input_vector_unordered_map_unordered_map.begin();  i != input_vector_unordered_map_unordered_map.end();  ++i) {
//            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), top of outer loop, have i->first AKA key = '%s'\n", (i->first).c_str());
            number_arrayref_hashref input_vector_unordered_map = i->second;

            // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
            // 1.  delete pre-existing 1D ARRAY CODE
            // 2.  no naming bridge required
            // 3.  XS_unpack_TYPE_arrayref_hashref -> XS_unpack_TYPE_arrayref_hashref_hashref
            // 4.  hv_store under pasted 2D code, output_av -> output_avref_hv
            // 5.  j -> k
            // 6.  i -> j

            // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

            // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

            HV* output_avref_hv = newHV();  // initialize output hash-of-arrays to empty
            integer input_vector_unordered_map_num_keys = input_vector_unordered_map.size();
            number_arrayref_hashref_const_iterator j;
            SV* temp_sv_pointer;

        //    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), have input_vector_unordered_map_num_keys = %"INTEGER"\n", input_vector_unordered_map_num_keys);

            if (input_vector_unordered_map_num_keys > 0) {
                for (j = input_vector_unordered_map.begin();  j != input_vector_unordered_map.end();  ++j) {
        //            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), top of outer loop, have j->first AKA key = '%s'\n", (j->first).c_str());
                    number_arrayref input_vector = j->second;

                    // [[[ BEGIN PASTED-AND-CONVERTED 1D ARRAY CODE ]]]
                    AV* output_av = newAV();  // initialize output sub-array to empty
                    integer input_vector_length = input_vector.size();
                    integer k;

        //            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), have input_vector_length = %"INTEGER"\n", input_vector_length);

                    if (input_vector_length > 0) {
                        for (k = 0;  k < input_vector_length;  ++k) {
        //                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), top of inner loop, have (j->first, k) = ('%s', %"INTEGER")\n", (j->first).c_str(), k);
        //                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), have input_vector_unordered_map['%s'][%"INTEGER"] = %"INTEGER"\n", (j->first).c_str(), k, input_vector[k]);
                            av_push(output_av, newSVnv(input_vector[k]));
        //                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), bottom of inner loop, have (j->first, k) = ('%s', %"INTEGER")\n", (j->first).c_str(), k);
                        }
                    }
                    else warn("in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), sub-array was empty, returning empty sub-array via newAV()");
                    // [[[ END PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

                    // NEED ANSWER: is it really okay to NOT increase the reference count below???
                    hv_store(output_avref_hv, (const char*)((j->first).c_str()), (U32)((j->first).size()), newRV_noinc((SV*)output_av), (U32)0);  // reference, do not increase reference count
        //            hv_store(output_avref_hv, (const char*)((j->first).c_str()), (U32)((j->first).size()), newRV_inc((SV*)output_av), (U32)0);  // reference, do increase reference count

        //            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), bottom of outer loop, have j->first = '%s'\n", (j->first).c_str());
                }
            }
            else warn("in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), hash was empty, returning empty hash via newHV()");

            // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]

            // NEED ANSWER: is it really okay to NOT increase the reference count below???
            hv_store(output_avref_hvref_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newRV_noinc((SV*)output_avref_hv), (U32)0);  // reference, do not increase reference count
//            hv_store(output_avref_hvref_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newRV_inc((SV*)output_avref_hv), (U32)0);  // reference, do increase reference count

//            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), bottom of outer loop, have i->first = '%s'\n", (i->first).c_str());
        }
    }
    else warn("in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), hash was empty, returning empty hash via newHV()");

    temp_sv_pointer = newSVrv(output_avref_hvref_hvref, NULL);    // upgrade output stack SV to an RV
    SvREFCNT_dec(temp_sv_pointer);       // discard temporary pointer
    SvRV(output_avref_hvref_hvref) = (SV*)output_avref_hvref_hv;       // make output stack RV pointer at our output HV

//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number_arrayref_hashref_hashref(), bottom of subroutine\n");
}

// DEV NOTE, STEPS TO CONVERT FROM number TO string:
// 1.  NVs -> PVs
// 2.  SvNV -> SvPV_nolen
// 3.  newSVnv(FOO) -> newSVpv(FOO.c_str(), 0)
// 4.  numbers -> strings
// 5.  number_ -> string_

// convert from (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs))))))) to (C++ std::unordered_map of (C++ std::unordered_map of (C++ std::vector of strings)))
string_arrayref_hashref_hashref XS_unpack_string_arrayref_hashref_hashref(SV* input_avref_hvref_hvref) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref_hashref_hashref(), top of subroutine\n");

//    string_arrayref_hashref_hashref_CHECK(input_avref_hvref_hvref);
    string_arrayref_hashref_hashref_CHECKTRACE(input_avref_hvref_hvref, "input_avref_hvref_hvref", "XS_unpack_string_arrayref_hashref_hashref()");

    HV* input_avref_hvref_hv;
    integer input_avref_hvref_hv_num_keys;
    integer i;
    HE* input_avref_hvref_hv_entry;
    SV* input_avref_hvref_hv_entry_key;
    SV* input_avref_hvref_hv_entry_value;
    string_arrayref_hashref_hashref output_vector_unordered_map_unordered_map;

    input_avref_hvref_hv = (HV*)SvRV(input_avref_hvref_hvref);

    input_avref_hvref_hv_num_keys = hv_iterinit(input_avref_hvref_hv);
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref_hashref_hashref(), have input_avref_hvref_hv_num_keys = %"INTEGER"\n", input_avref_hvref_hv_num_keys);

    // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
    // reserve() ahead of time to avoid resizing and rehashing in for() loop
    output_vector_unordered_map_unordered_map.reserve((size_t)input_avref_hvref_hv_num_keys);

    // incrementing iteration, iterator i not actually used in loop body
    for (i = 0;  i < input_avref_hvref_hv_num_keys;  ++i) {
        // does not utilize i in entry retrieval
        input_avref_hvref_hv_entry = hv_iternext(input_avref_hvref_hv);
        // DEV NOTE: hash entry type-checking already done as part of string_arrayref_hashref_hashref_CHECKTRACE()
//      hashentry_CHECK(input_avref_hvref_hv_entry);
//      hashentry_CHECKTRACE(input_avref_hvref_hv_entry, "input_avref_hvref_hv_entry", "XS_unpack_string_arrayref_hashref_hashref()");

        input_avref_hvref_hv_entry_key = hv_iterkeysv(input_avref_hvref_hv_entry);
        input_avref_hvref_hv_entry_value = hv_iterval(input_avref_hvref_hv, input_avref_hvref_hv_entry);
        // DEV NOTE: integer type-checking already done as part of string_arrayref_hashref_hashref_CHECKTRACE()
//      string_CHECK(input_avref_hvref_hv_entry_value);
//      string_CHECKTRACE(input_avref_hvref_hv_entry_value, (char*)((string)"input_avref_hvref_hv_entry_value at key '" + (string)SvPV_nolen(input_avref_hvref_hv_entry_key) + "'").c_str(), "XS_unpack_string_arrayref_hashref_hashref()");

        // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
        // 1.  delete pre-existing 1D ARRAY CODE
        // 2.  naming bridge
        // 3.  XS_unpack_TYPE_arrayref_hashref -> XS_unpack_TYPE_arrayref_hashref_hashref
        // 4.  UNORDERED MAP ENTRY ASSIGNMENT under pasted 2D code, output_vector -> output_vector_unordered_map
        // 5.  j -> k
        // 6.  i -> j

        // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

        // DEV NOTE: naming bridge between 3D code and pasted 2D code
        SV* input_avref_hvref = input_avref_hvref_hv_entry_value;

        // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

        //    string_arrayref_hashref_CHECK(input_avref_hvref);
            string_arrayref_hashref_CHECKTRACE(input_avref_hvref, "input_avref_hvref", "XS_unpack_string_arrayref_hashref_hashref()");

            HV* input_avref_hv;
            integer input_avref_hv_num_keys;
            integer j;
            HE* input_avref_hv_entry;
            SV* input_avref_hv_entry_key;
            SV* input_avref_hv_entry_value;
            string_arrayref_hashref output_vector_unordered_map;

            input_avref_hv = (HV*)SvRV(input_avref_hvref);

            input_avref_hv_num_keys = hv_iterinit(input_avref_hv);
        //    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref_hashref_hashref(), have input_avref_hv_num_keys = %"INTEGER"\n", input_avref_hv_num_keys);

            // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
            // reserve() ahead of time to avoid resizing and rehashing in for() loop
            output_vector_unordered_map.reserve((size_t)input_avref_hv_num_keys);

            // incrementing iteration, iterator i not actually used in loop body
            for (j = 0;  j < input_avref_hv_num_keys;  ++j) {
                // does not utilize j in entry retrieval
                input_avref_hv_entry = hv_iternext(input_avref_hv);
                // DEV NOTE: hash entry type-checking already done as part of string_arrayref_hashref_CHECKTRACE()
        //      hashentry_CHECK(input_avref_hv_entry);
        //      hashentry_CHECKTRACE(input_avref_hv_entry, "input_avref_hv_entry", "XS_unpack_string_arrayref_hashref_hashref()");

                input_avref_hv_entry_key = hv_iterkeysv(input_avref_hv_entry);
                input_avref_hv_entry_value = hv_iterval(input_avref_hv, input_avref_hv_entry);
                // DEV NOTE: integer type-checking already done as part of string_arrayref_hashref_CHECKTRACE()
        //      string_CHECK(input_avref_hv_entry_value);
        //      string_CHECKTRACE(input_avref_hv_entry_value, (char*)((string)"input_avref_hv_entry_value at key '" + (string)SvPV_nolen(input_avref_hv_entry_key) + "'").c_str(), "XS_unpack_string_arrayref_hashref_hashref()");

                // [[[ BEGIN PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

                AV* input_av;
                integer input_av_length;
                integer k;
                SV** input_av_element;
                string_arrayref output_vector;

        //      input_av = (AV*)SvRV(*input_avref);  // input_avref is an unused shorthand for input_avref_hv_entry_value
        //        input_av = (AV*)SvRV(*input_avref_hv_entry_value);  // error: base operand of ‘->’ has non-pointer type ‘SV {aka sv}’, in expansion of macro ‘SvRV’
                input_av = (AV*)SvRV(input_avref_hv_entry_value);
                input_av_length = av_len(input_av) + 1;
        //        fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref_hashref_hashref(), have input_av_length = %"INTEGER"\n", input_av_length);

                // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
                // resize() ahead of time to allow l-value subscript notation
                output_vector.resize((size_t)input_av_length);

                // incrementing iteration
                for (k = 0;  k < input_av_length;  ++k) {
                    // utilizes k in element retrieval
                    input_av_element = av_fetch(input_av, k, 0);

                    // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes k in assignment
                    output_vector[k] = SvPV_nolen(*input_av_element);
                }

        //        fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref_hashref_hashref(), bottom of inner for() loop k = %"INTEGER", have output_vector.size() = %"INTEGER"\n", k, (integer) output_vector.size());

                // [[[ END PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

                // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize j in assignment
                output_vector_unordered_map[SvPV_nolen(input_avref_hv_entry_key)] = output_vector;
            }

        //    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref_hashref_hashref(), after outer for() loop, have output_vector_unordered_map.size() = %"INTEGER"\n", output_vector_unordered_map.size());

        // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]

        // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize i in assignment
        output_vector_unordered_map_unordered_map[SvPV_nolen(input_avref_hvref_hv_entry_key)] = output_vector_unordered_map;
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref_hashref_hashref(), after outer for() loop, have output_vector_unordered_map_unordered_map.size() = %"INTEGER"\n", output_vector_unordered_map_unordered_map.size());
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string_arrayref_hashref_hashref(), bottom of subroutine\n");

    return(output_vector_unordered_map_unordered_map);
}

// convert from (C++ std::unordered_map of (C++ std::unordered_map of (C++ std::vector of strings))) to (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs)))))))
void XS_pack_string_arrayref_hashref_hashref(SV* output_avref_hvref_hvref, string_arrayref_hashref_hashref input_vector_unordered_map_unordered_map) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), top of subroutine\n");

    HV* output_avref_hvref_hv = newHV();  // initialize output hash-of-hashes-of-arrays to empty
    integer input_vector_unordered_map_unordered_map_num_keys = input_vector_unordered_map_unordered_map.size();
    string_arrayref_hashref_hashref_const_iterator i;
    SV* temp_sv_pointer;

//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), have input_vector_unordered_map_unordered_map_num_keys = %"INTEGER"\n", input_vector_unordered_map_unordered_map_num_keys);

    if (input_vector_unordered_map_unordered_map_num_keys > 0) {
        for (i = input_vector_unordered_map_unordered_map.begin();  i != input_vector_unordered_map_unordered_map.end();  ++i) {
//            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), top of outer loop, have i->first AKA key = '%s'\n", (i->first).c_str());
            string_arrayref_hashref input_vector_unordered_map = i->second;

            // DEV NOTE, STEPS TO CONVERT PASTED 2D CODE:
            // 1.  delete pre-existing 1D ARRAY CODE
            // 2.  no naming bridge required
            // 3.  XS_unpack_TYPE_arrayref_hashref -> XS_unpack_TYPE_arrayref_hashref_hashref
            // 4.  hv_store under pasted 2D code, output_av -> output_avref_hv
            // 5.  j -> k
            // 6.  i -> j

            // [[[ DELETED ORIGINAL PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

            // [[[ BEGIN PASTED-AND-CONVERTED 2D CODE ]]]

            HV* output_avref_hv = newHV();  // initialize output hash-of-arrays to empty
            integer input_vector_unordered_map_num_keys = input_vector_unordered_map.size();
            string_arrayref_hashref_const_iterator j;
            SV* temp_sv_pointer;

        //    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), have input_vector_unordered_map_num_keys = %"INTEGER"\n", input_vector_unordered_map_num_keys);

            if (input_vector_unordered_map_num_keys > 0) {
                for (j = input_vector_unordered_map.begin();  j != input_vector_unordered_map.end();  ++j) {
        //            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), top of outer loop, have j->first AKA key = '%s'\n", (j->first).c_str());
                    string_arrayref input_vector = j->second;

                    // [[[ BEGIN PASTED-AND-CONVERTED 1D ARRAY CODE ]]]
                    AV* output_av = newAV();  // initialize output sub-array to empty
                    integer input_vector_length = input_vector.size();
                    integer k;

        //            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), have input_vector_length = %"INTEGER"\n", input_vector_length);

                    if (input_vector_length > 0) {
                        for (k = 0;  k < input_vector_length;  ++k) {
        //                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), top of inner loop, have (j->first, k) = ('%s', %"INTEGER")\n", (j->first).c_str(), k);
        //                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), have input_vector_unordered_map['%s'][%"INTEGER"] = %"INTEGER"\n", (j->first).c_str(), k, input_vector[k]);
                            av_push(output_av, newSVpv(input_vector[k].c_str(), 0));
        //                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), bottom of inner loop, have (j->first, k) = ('%s', %"INTEGER")\n", (j->first).c_str(), k);
                        }
                    }
                    else warn("in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), sub-array was empty, returning empty sub-array via newAV()");
                    // [[[ END PASTED-AND-CONVERTED 1D ARRAY CODE ]]]

                    // NEED ANSWER: is it really okay to NOT increase the reference count below???
                    hv_store(output_avref_hv, (const char*)((j->first).c_str()), (U32)((j->first).size()), newRV_noinc((SV*)output_av), (U32)0);  // reference, do not increase reference count
        //            hv_store(output_avref_hv, (const char*)((j->first).c_str()), (U32)((j->first).size()), newRV_inc((SV*)output_av), (U32)0);  // reference, do increase reference count

        //            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), bottom of outer loop, have j->first = '%s'\n", (j->first).c_str());
                }
            }
            else warn("in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), hash was empty, returning empty hash via newHV()");

            // [[[ END PASTED-AND-CONVERTED 2D CODE ]]]

            // NEED ANSWER: is it really okay to NOT increase the reference count below???
            hv_store(output_avref_hvref_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newRV_noinc((SV*)output_avref_hv), (U32)0);  // reference, do not increase reference count
//            hv_store(output_avref_hvref_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newRV_inc((SV*)output_avref_hv), (U32)0);  // reference, do increase reference count

//            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), bottom of outer loop, have i->first = '%s'\n", (i->first).c_str());
        }
    }
    else warn("in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), hash was empty, returning empty hash via newHV()");

    temp_sv_pointer = newSVrv(output_avref_hvref_hvref, NULL);    // upgrade output stack SV to an RV
    SvREFCNT_dec(temp_sv_pointer);       // discard temporary pointer
    SvRV(output_avref_hvref_hvref) = (SV*)output_avref_hvref_hv;       // make output stack RV pointer at our output HV

//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string_arrayref_hashref_hashref(), bottom of subroutine\n");
}

# endif

#endif

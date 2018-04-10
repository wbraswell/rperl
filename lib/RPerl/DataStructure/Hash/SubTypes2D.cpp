using std::cout;  using std::cerr;  using std::endl;  using std::to_string;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes2D_cpp
#define __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes2D_cpp 0.005_000

#include <RPerl/DataStructure/Hash/SubTypes2D.h>  // -> ??? (relies on <unordered_map> being included via Inline::CPP's AUTO_INCLUDE config option in RPerl/Inline.pm)

// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]

void integer_arrayref_hashref_CHECK(SV* possible_integer_arrayref_hashref, const char* variable_name, const char* subroutine_name)
{
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_CHECK(), top of subroutine\n");

    // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with integer-specific error codes
    if ( not( SvOK(possible_integer_arrayref_hashref) ) ) { croak( "\nERROR EIVAVRVHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref value expected but undefined/null value found,\ncroaking" ); }
    if ( not( SvHROKp(possible_integer_arrayref_hashref) ) ) { croak( "\nERROR EIVAVRVHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref value expected but non-hashref value found,\ncroaking" ); }

    HV* possible_integer_arrayref_hash;
    integer possible_integer_arrayref_hash_num_keys;
    integer i;
    HE* possible_integer_arrayref_hashentry;
    SV* possible_integer_arrayref_hashentry_value;
    SV* possible_integer_arrayref_hashentry_key;
    string possible_integer_arrayref_hashentry_key_string;

    possible_integer_arrayref_hash = (HV*)SvRV(possible_integer_arrayref_hashref);
    possible_integer_arrayref_hash_num_keys = hv_iterinit(possible_integer_arrayref_hash);

    for (i = 0;  i < possible_integer_arrayref_hash_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
    {
        possible_integer_arrayref_hashentry = hv_iternext(possible_integer_arrayref_hash);

        // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with integer-specific error code
        if (possible_integer_arrayref_hashentry == NULL) { croak("\nERROR EIVAVRVHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashentry value expected but undefined/null value found,\ncroaking"); }
        possible_integer_arrayref_hashentry_value = hv_iterval(possible_integer_arrayref_hash, possible_integer_arrayref_hashentry);

        // DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECK() macro & subroutine, but with hash-specific error codes
        if (not(SvOK(possible_integer_arrayref_hashentry_value)))
        {
            possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
            possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
            croak("\nERROR EIVAVRVHVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but undefined/null value found at key '%s',\ncroaking", possible_integer_arrayref_hashentry_key_string.c_str());
        }

        if (not(SvAROKp(possible_integer_arrayref_hashentry_value)))
        {
            possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
            possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
            croak("\nERROR EIVAVRVHVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but non-arrayref value found at key '%s',\ncroaking", possible_integer_arrayref_hashentry_key_string.c_str());
        }

        SV* possible_integer_arrayref = possible_integer_arrayref_hashentry_value;

        AV* possible_integer_array;
        integer possible_integer_array_length;
        integer j;
        SV** possible_integer_array_element;

        possible_integer_array = (AV*)SvRV(possible_integer_arrayref);
        possible_integer_array_length = av_len(possible_integer_array) + 1;

        for (j = 0;  j < possible_integer_array_length;  ++j)  // incrementing iteration
        {
            possible_integer_array_element = av_fetch(possible_integer_array, j, 0);
            if (not(SvOK(*possible_integer_array_element)))
            {
                possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EIVAVRVHVRV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found at index %"INTEGER", key '%s',\ncroaking", j, possible_integer_arrayref_hashentry_key_string.c_str());
            }
            if (not(SvIOKp(*possible_integer_array_element)))
            {
                possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EIVAVRVHVRV05, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found at index %"INTEGER", key '%s',\ncroaking", j, possible_integer_arrayref_hashentry_key_string.c_str());
            }
        }
    }
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_CHECK(), bottom of subroutine\n");
}

void integer_arrayref_hashref_CHECKTRACE(SV* possible_integer_arrayref_hashref, const char* variable_name, const char* subroutine_name)
{
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_CHECKTRACE(), top of subroutine, received variable_name = %s\n", variable_name);
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_CHECKTRACE(), top of subroutine, received subroutine_name = %s\n", subroutine_name);

    // DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() macro, but with integer-specific error codes
    if ( not( SvOK(possible_integer_arrayref_hashref) ) ) { croak( "\nERROR EIVAVRVHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name ); }
    if ( not( SvHROKp(possible_integer_arrayref_hashref) ) ) { croak( "\nERROR EIVAVRVHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashref value expected but non-hashref value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name ); }

    HV* possible_integer_arrayref_hash;
    integer possible_integer_arrayref_hash_num_keys;
    integer i;
    HE* possible_integer_arrayref_hashentry;
    SV* possible_integer_arrayref_hashentry_value;
    SV* possible_integer_arrayref_hashentry_key;
    string possible_integer_arrayref_hashentry_key_string;

    possible_integer_arrayref_hash = (HV*)SvRV(possible_integer_arrayref_hashref);
    possible_integer_arrayref_hash_num_keys = hv_iterinit(possible_integer_arrayref_hash);

    for (i = 0;  i < possible_integer_arrayref_hash_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
    {
        possible_integer_arrayref_hashentry = hv_iternext(possible_integer_arrayref_hash);

        // DEV NOTE: the following if() statement is functionally equivalent to the hashentry_CHECK() macro, but with integer-specific error code
        if (possible_integer_arrayref_hashentry == NULL) { croak("\nERROR EIVAVRVHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_hashentry value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name); }
        possible_integer_arrayref_hashentry_value = hv_iterval(possible_integer_arrayref_hash, possible_integer_arrayref_hashentry);

        // DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECK() macro & subroutine, but with hash-specific error codes
        if (not(SvOK(possible_integer_arrayref_hashentry_value)))
        {
            possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
            possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
            croak("\nERROR EIVAVRVHVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but undefined/null value found at key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_integer_arrayref_hashentry_key_string.c_str(), variable_name, subroutine_name);
        }

        if (not(SvAROKp(possible_integer_arrayref_hashentry_value)))
        {
            possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
            possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
            croak("\nERROR EIVAVRVHVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref value expected but non-arrayref value found at key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", possible_integer_arrayref_hashentry_key_string.c_str(), variable_name, subroutine_name);
        }

        SV* possible_integer_arrayref = possible_integer_arrayref_hashentry_value;

        AV* possible_integer_array;
        integer possible_integer_array_length;
        integer j;
        SV** possible_integer_array_element;

        possible_integer_array = (AV*)SvRV(possible_integer_arrayref);
        possible_integer_array_length = av_len(possible_integer_array) + 1;

        for (j = 0;  j < possible_integer_array_length;  ++j)  // incrementing iteration
        {
            possible_integer_array_element = av_fetch(possible_integer_array, j, 0);
            if (not(SvOK(*possible_integer_array_element)))
            {
                possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EIVAVRVHVRV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found at index %"INTEGER", key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", j, possible_integer_arrayref_hashentry_key_string.c_str(), variable_name, subroutine_name);
            }
            if (not(SvIOKp(*possible_integer_array_element)))
            {
                possible_integer_arrayref_hashentry_key = hv_iterkeysv(possible_integer_arrayref_hashentry);
                possible_integer_arrayref_hashentry_key_string = escape_backslash_singlequote(string(SvPV_nolen(possible_integer_arrayref_hashentry_key)));  // escape key string for error message
                croak("\nERROR EIVAVRVHVRV05, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found at index %"INTEGER", key '%s',\nin variable '%s' from subroutine '%s',\ncroaking", j, possible_integer_arrayref_hashentry_key_string.c_str(), variable_name, subroutine_name);
            }
        }
    }
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_CHECKTRACE(), bottom of subroutine\n");
}

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES


// START HERE: number & string variations, w/ new t/06 tests
// START HERE: number & string variations, w/ new t/06 tests
// START HERE: number & string variations, w/ new t/06 tests


// convert from (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))))) to (C++ std::unordered_map of (C++ std::vector of integers))
integer_arrayref_hashref XS_unpack_integer_arrayref_hashref(SV* input_avref_hvref)
{
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref(), top of subroutine\n");

//    integer_arrayref_hashref_CHECK(input_avref_hvref);
    integer_arrayref_hashref_CHECKTRACE(input_avref_hvref, "input_avref_hvref", "XS_unpack_integer_arrayref_hashref()");

    HV* input_avref_hv;
    integer input_avref_hv_num_keys;
    integer i;
    HE* input_avref_hv_entry;
    SV* input_avref_hv_entry_key;
    SV* input_avref_hv_entry_value;
    integer_arrayref_hashref output_vector_unordered_map;

    input_avref_hv = (HV*)SvRV(input_avref_hvref);

    input_avref_hv_num_keys = hv_iterinit(input_avref_hv);
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref(), have input_avref_hv_num_keys = %"INTEGER"\n", input_avref_hv_num_keys);

    // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
    // reserve() ahead of time to avoid resizing and rehashing in for() loop
    output_vector_unordered_map.reserve((size_t)input_avref_hv_num_keys);

    for (i = 0;  i < input_avref_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
    {
        // does not utilize i in entry retrieval
        input_avref_hv_entry = hv_iternext(input_avref_hv);
        // DEV NOTE: hash entry type-checking already done as part of integer_arrayref_hashref_CHECKTRACE()
//      hashentry_CHECK(input_avref_hv_entry);
//      hashentry_CHECKTRACE(input_avref_hv_entry, "input_avref_hv_entry", "XS_unpack_integer_arrayref_hashref()");

        input_avref_hv_entry_key = hv_iterkeysv(input_avref_hv_entry);
        input_avref_hv_entry_value = hv_iterval(input_avref_hv, input_avref_hv_entry);
        // DEV NOTE: integer type-checking already done as part of integer_arrayref_hashref_CHECKTRACE()
//      integer_CHECK(input_avref_hv_entry_value);
//      integer_CHECKTRACE(input_avref_hv_entry_value, (char*)((string)"input_avref_hv_entry_value at key '" + (string)SvPV_nolen(input_avref_hv_entry_key) + "'").c_str(), "XS_unpack_integer_arrayref_hashref()");

        // BEGIN ARRAY CODE
        AV* input_av;
        integer input_av_length;
        integer j;
        SV** input_av_element;
        integer_arrayref output_vector;

//      input_av = (AV*)SvRV(*input_avref);  // input_avref is an unused shorthand for input_avref_hv_entry_value
//        input_av = (AV*)SvRV(*input_avref_hv_entry_value);  // error: base operand of ‘->’ has non-pointer type ‘SV {aka sv}’, in expansion of macro ‘SvRV’
        input_av = (AV*)SvRV(input_avref_hv_entry_value);
        input_av_length = av_len(input_av) + 1;
//        fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref(), have input_av_length = %"INTEGER"\n", input_av_length);

        // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
        // resize() ahead of time to allow l-value subscript notation
        output_vector.resize((size_t)input_av_length);

        for (j = 0;  j < input_av_length;  ++j)  // incrementing iteration
        {
            // utilizes j in element retrieval
            input_av_element = av_fetch(input_av, j, 0);

            // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes j in assignment
            output_vector[j] = SvIV(*input_av_element);
        }

//        fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref(), bottom of inner for() loop j = %"INTEGER", have output_vector.size() = %"INTEGER"\n", j, (integer) output_vector.size());
        // END ARRAY CODE

        // UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize i in assignment
        output_vector_unordered_map[SvPV_nolen(input_avref_hv_entry_key)] = output_vector;
    }

//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref(), after outer for() loop, have output_vector_unordered_map.size() = %"INTEGER"\n", output_vector_unordered_map.size());
//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_hashref(), bottom of subroutine\n");

    return(output_vector_unordered_map);
}

// convert from (C++ std::unordered_map of (C++ std::vector of integers)) to (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs)))))
void XS_pack_integer_arrayref_hashref(SV* output_avref_hvref, integer_arrayref_hashref input_vector_unordered_map) {
    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref(), top of subroutine\n");

    HV* output_avref_hv = newHV();  // initialize output hash-of-arrays to empty
    integer input_vector_unordered_map_num_keys = input_vector_unordered_map.size();
    integer_arrayref_hashref_const_iterator i;
    SV* temp_sv_pointer;

    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref(), have input_vector_unordered_map_num_keys = %"INTEGER"\n", input_vector_unordered_map_num_keys);

    if (input_vector_unordered_map_num_keys > 0) {
        for (i = input_vector_unordered_map.begin();  i != input_vector_unordered_map.end();  ++i) {
            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref(), top of outer loop, have i->first AKA key = '%s'\n", (i->first).c_str());
            integer_arrayref input_vector = i->second;

            // BEGIN ARRAY CODE
            AV* output_av = newAV();  // initialize output sub-array to empty
            integer input_vector_length = input_vector.size();
            integer j;

            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref(), have input_vector_length = %"INTEGER"\n", input_vector_length);

            if (input_vector_length > 0) {
                for (j = 0;  j < input_vector_length;  ++j) {
                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref(), top of inner loop, have (i->first, j) = ('%s', %"INTEGER")\n", (i->first).c_str(), j);
                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref(), have input_vector_unordered_map['%s'][%"INTEGER"] = %"INTEGER"\n", (i->first).c_str(), j, input_vector[j]);
                    av_push(output_av, newSViv(input_vector[j]));
                    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref(), bottom of inner loop, have (i->first, j) = ('%s', %"INTEGER")\n", (i->first).c_str(), j);
                }
            }
            else warn("in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref(), sub-array was empty, returning empty sub-array via newAV()");
            // END ARRAY CODE

            // NEED ANSWER: is it really okay to NOT increase the reference count below???
            hv_store(output_avref_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newRV_noinc((SV*)output_av), (U32)0);  // reference, do not increase reference count
//            hv_store(output_avref_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newRV_inc((SV*)output_av), (U32)0);  // reference, do increase reference count

            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref(), bottom of outer loop, have i->first = '%s'\n", (i->first).c_str());
        }
    }
    else warn("in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref(), hash was empty, returning empty hash via newHV()");

    temp_sv_pointer = newSVrv(output_avref_hvref, NULL);    // upgrade output stack SV to an RV
    SvREFCNT_dec(temp_sv_pointer);       // discard temporary pointer
    SvRV(output_avref_hvref) = (SV*)output_avref_hv;       // make output stack RV pointer at our output HV

//    fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_hashref(), bottom of subroutine\n");
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

// call actual stringify routine, format level -1 (compact), indent level 0
SV* integer_arrayref_hashref_to_string_compact(SV* input_hvref) {
    return integer_arrayref_hashref_to_string_format(input_hvref, newSViv(-1), newSViv(0));
}

// call actual stringify routine, format level 0 (normal), indent level 0, DEFAULT
SV* integer_arrayref_hashref_to_string(SV* input_hvref) {
    return integer_arrayref_hashref_to_string_format(input_hvref, newSViv(0), newSViv(0));
}

// call actual stringify routine, format level 1 (pretty), indent level 0
SV* integer_arrayref_hashref_to_string_pretty(SV* input_hvref) {
    return integer_arrayref_hashref_to_string_format(input_hvref, newSViv(1), newSViv(0));
}

// call actual stringify routine, format level 2 (expand), indent level 0
SV* integer_arrayref_hashref_to_string_expand(SV* input_hvref) {
    return integer_arrayref_hashref_to_string_format(input_hvref, newSViv(2), newSViv(0));
}

// convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
SV* integer_arrayref_hashref_to_string_format(SV* input_avref_hvref, SV* format_level, SV* indent_level)
{
//    fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_to_string(), top of subroutine...\n");
//    fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_to_string(), received format_level = %"INTEGER", indent_level = %"INTEGER"\n", SvIV(format_level), SvIV(indent_level));

//  integer_arrayref_hashref_CHECK(input_avref_hvref);
    integer_arrayref_hashref_CHECKTRACE(input_avref_hvref, "input_avref_hvref", "integer_arrayref_hashref_to_string()");

    // declare local variables
    HV* input_avref_hv;
    integer input_avref_hv_num_keys;
    integer i;
    boolean i_is_0 = 1;
    HE* input_avref_hv_entry;
    SV* input_avref_hv_entry_key;
    string input_avref_hv_entry_key_string;
    size_t input_avref_hv_entry_key_string_pos;
    SV* input_avref_hv_entry_value;
    SV* output_sv = newSVpv("", 0);

    // generate indent
    SV* indent = newSVpv("", 0);
    for (i = 0; i < SvIV(indent_level); i++) { sv_catpvn(indent, "    ", 4); }

    // compute length of (number of keys in) input hash
    input_avref_hv = (HV*)SvRV(input_avref_hvref);
    input_avref_hv_num_keys = hv_iterinit(input_avref_hv);
//  fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_to_string(), have input_avref_hv_num_keys = %"INTEGER"\n", input_avref_hv_num_keys);

    // pre-begin with optional indent, depending on format level
    if (SvIV(format_level) >= 1) { sv_catsv(output_sv, indent); }  // pretty

    // begin output string with left-curly-brace, as required for all RPerl hashes
    sv_setpvn(output_sv, "{", 1);

    // loop through all hash keys
    for (i = 0;  i < input_avref_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
    {
//      fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_to_string(), top of loop i = %"INTEGER"\n", i);

        // does not utilize i in entry retrieval
        input_avref_hv_entry = hv_iternext(input_avref_hv);

        // DEV NOTE: hash entry type-checking already done as part of integer_arrayref_hashref_CHECKTRACE()
//      hashentry_CHECK(input_avref_hv_entry);
//      hashentry_CHECKTRACE(input_avref_hv_entry, "input_avref_hv_entry", "integer_arrayref_hashref_to_string()");

        // retrieve input hash's entry value at key
        input_avref_hv_entry_key = hv_iterkeysv(input_avref_hv_entry);
        input_avref_hv_entry_value = hv_iterval(input_avref_hv, input_avref_hv_entry);

        // DEV NOTE: integer type-checking already done as part of integer_arrayref_hashref_CHECKTRACE()
//      integer_CHECK(input_avref_hv_entry_value);
//      integer_CHECKTRACE(input_avref_hv_entry_value, (char*)((string)"input_avref_hv_entry_value at key '" + (string)SvPV_nolen(input_avref_hv_entry_key) + "'").c_str(), "integer_arrayref_hashref_to_string()");

        // append comma to output string for all elements except index 0
        if (i_is_0) { i_is_0 = 0; }
        else        { sv_catpvn(output_sv, ",", 1); }

        // append newline-indent-tab or space, depending on format level
        if      (SvIV(format_level) >= 1) { sv_catpvn(output_sv, "\n", 1);  sv_catsv(output_sv, indent);  sv_catpvn(output_sv, "    ", 4); }  // pretty & expand
        else if (SvIV(format_level) >= 0) { sv_catpvn(output_sv, " ", 1); }                                                                   // normal

        input_avref_hv_entry_key_string = escape_backslash_singlequote(string(SvPV_nolen(input_avref_hv_entry_key)));  // escape key string for error message

        // DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
//        sv_catpvf(output_sv, "'%s'", SvPV_nolen(input_avref_hv_entry_key));  // alternative form
        sv_catpvf(output_sv, "'%s'", input_avref_hv_entry_key_string.c_str());

        // append spaces before and after fat arrow AKA fat comma, depending on format level
        if      (SvIV(format_level) >= 0) { sv_catpvn(output_sv, " => ", 4); }  // normal & pretty & expand
        else                               { sv_catpvn(output_sv, "=>", 2); }   // compact

        // append newline after fat arrow AKA fat comma, depending on format level
        if      (SvIV(format_level) >= 2) { sv_catpvn(output_sv, "\n", 1); }    // expand

        // call *_to_string_format() for data sub-structure
        sv_catsv(output_sv, integer_arrayref_to_string_format(input_avref_hv_entry_value, newSViv(SvIV(format_level) - 1), newSViv(SvIV(indent_level) + 1)));  // YES UNDERSCORES
    }

    // append newline-indent or space, depending on format level
    if      (SvIV(format_level) >= 1) { sv_catpvn(output_sv, "\n", 1);  sv_catsv(output_sv, indent); }  // pretty & expand
    else if (SvIV(format_level) >= 0) { sv_catpvn(output_sv, " ", 1); }                                 // normal

    // end output string with right-curly-brace, as required for all RPerl hashes
    sv_catpvn(output_sv, "}", 1);

//  fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_to_string(), after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
//  fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_to_string(), bottom of subroutine\n");

    return(output_sv);
}

// NEED ADD CODE HERE: stringify, CPPOPS_PERLTYPES, number & string
// NEED ADD CODE HERE: stringify, CPPOPS_PERLTYPES, number & string
// NEED ADD CODE HERE: stringify, CPPOPS_PERLTYPES, number & string

# elif defined __CPP__TYPES

// NEED ADD CODE HERE: stringify, CPPOPS_CPPTYPES, integer & number & string
// NEED ADD CODE HERE: stringify, CPPOPS_CPPTYPES, integer & number & string
// NEED ADD CODE HERE: stringify, CPPOPS_CPPTYPES, integer & number & string




// call actual stringify routine, format level -1 (compact), indent level 0
string integer_arrayref_hashref_to_string_compact(integer_arrayref_hashref input_vector_unordered_map) {
    return integer_arrayref_hashref_to_string_format(input_vector_unordered_map, -1, 0);
}

// call actual stringify routine, format level 0 (normal), indent level 0, DEFAULT
string integer_arrayref_hashref_to_string(integer_arrayref_hashref input_vector_unordered_map) {
    return integer_arrayref_hashref_to_string_format(input_vector_unordered_map, 0, 0);
}

// call actual stringify routine, format level 1 (pretty), indent level 0
string integer_arrayref_hashref_to_string_pretty(integer_arrayref_hashref input_vector_unordered_map) {
    return integer_arrayref_hashref_to_string_format(input_vector_unordered_map, 1, 0);
}

// call actual stringify routine, format level 2 (expand), indent level 0
string integer_arrayref_hashref_to_string_expand(integer_arrayref_hashref input_vector_unordered_map) {
    return integer_arrayref_hashref_to_string_format(input_vector_unordered_map, 2, 0);
}

// convert from (C++ std::unordered_map of (C++ std::vector of integers)) to Perl-parsable (C++ std::string)
string integer_arrayref_hashref_to_string_format(integer_arrayref_hashref input_vector_unordered_map, integer format_level, integer indent_level) {
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_to_string(), top of subroutine\n");
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_to_string(), received format_level = %"INTEGER", indent_level = %"INTEGER"\n", format_level, indent_level);

    // declare local variables
    ostringstream output_stream;
    integer_arrayref_hashref_const_iterator i;
    boolean i_is_0 = 1;
    string key_string;
    size_t key_string_pos;

    // generate indent
    string indent = "";
    for (integer indent_i = 0; indent_i < indent_level; indent_i++) { indent += "    "; }

    // pre-begin with optional indent, depending on format level
    if (format_level >= 1) { output_stream << indent; }  // pretty

    // begin output string with left-curly-brace, as required for all RPerl hashes
    output_stream << '{';

    // loop through all hash keys
    for (i = input_vector_unordered_map.begin();  i != input_vector_unordered_map.end();  ++i)
    {
        // append comma to output string for all elements except index 0
        if (i_is_0) { i_is_0 = 0; }
        else        { output_stream << ','; }

        // append newline-indent-tab or space, depending on format level
        if      (format_level >= 1) { output_stream << endl << indent << "    "; }  // pretty & expand
        else if (format_level >= 0) { output_stream << ' '; }                       // normal

        // escape key string
        key_string = escape_backslash_singlequote(i->first);

        // DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
//        output_stream << "'" << (i->first).c_str() << "'";  // alternative format
        output_stream << "'" << key_string.c_str() << "'";

        // append spaces before and after fat arrow AKA fat comma, depending on format level
        if (format_level >= 0) { output_stream << " => "; }  // normal & pretty & expand
        else                   { output_stream << "=>"; }    // compact

        // append newline after fat arrow AKA fat comma, depending on format level
        if (format_level >= 2) { output_stream << "\n"; }    // expand

        // call *_to_string_format() for data sub-structure
        output_stream << integer_arrayref_to_string_format(i->second, format_level - 1, indent_level + 1);  // YES UNDERSCORES
    }

    // append newline-indent or space, depending on format level
    if      (format_level >= 1) { output_stream << endl << indent; }  // pretty & expand
    else if (format_level >= 0) { output_stream << ' '; }             // normal

    // end output string with right-curly-brace, as required for all RPerl hashes
    output_stream << '}';

//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_to_string(), after for() loop, have output_stream =\n%s\n", (char*)(output_stream.str().c_str()));
//    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_to_string(), bottom of subroutine\n");

    return(output_stream.str());
}

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif


// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* integer_arrayref_hashref_typetest0(SV* lucky_integer_arrayrefs)
{
//  integer_arrayref_hashref_CHECK(lucky_integer_arrayrefs);
    integer_arrayref_hashref_CHECKTRACE(lucky_integer_arrayrefs, "lucky_integer_arrayrefs", "integer_arrayref_hashref_typetest0()");

    // BEGIN DEBUG CODE
    HV* lucky_integer_arrayrefs_deref = (HV*)SvRV(lucky_integer_arrayrefs);
    integer how_lucky = hv_iterinit(lucky_integer_arrayrefs_deref);
    integer i;

    for (i = 0;  i < how_lucky;  ++i)
    {
        HE* lucky_integer_arrayref_entry = hv_iternext(lucky_integer_arrayrefs_deref);
        // DEV NOTE: hash entry type-checking already done as part of integer_arrayref_hashref_CHECKTRACE()
//      hashentry_CHECK(lucky_integer_arrayref_entry);
//      hashentry_CHECKTRACE(lucky_integer_arrayref_entry, "lucky_integer_arrayref_entry", "integer_arrayref_hashref_typetest0()");

        // DEV NOTE: not using lucky_number variable as in Hash.pm
        // DEV NOTE: integer type-checking already done as part of integer_arrayref_hashref_CHECKTRACE()
//      integer_CHECK(hv_iterval(lucky_integer_arrayrefs_deref, lucky_integer_arrayref_entry));
//      integer_CHECKTRACE(hv_iterval(lucky_integer_arrayrefs_deref, lucky_integer_arrayref_entry), (char*)((string)"hv_iterval(lucky_integer_arrayrefs_deref, lucky_integer_arrayref_entry) at key '" + (string)SvPV_nolen(hv_iterkeysv(lucky_integer_arrayref_entry)) + "'").c_str(), "integer_arrayref_hashref_typetest0()");

        SV* lucky_integer_arrayref_key = hv_iterkeysv(lucky_integer_arrayref_entry);
        SV* lucky_integer_arrayref_value = hv_iterval(lucky_integer_arrayrefs_deref, lucky_integer_arrayref_entry);

        AV* lucky_integer_array = (AV*)SvRV(lucky_integer_arrayref_value);
        integer how_luckier = av_len(lucky_integer_array) + 1;
        integer j;

        for (j = 0;  j < how_luckier;  ++j)
        {
            integer_CHECK(*av_fetch(lucky_integer_array, j, 0));
            integer_CHECKTRACE(*av_fetch(lucky_integer_array, j, 0), (char*)((string)"*av_fetch(lucky_integer_array, j, 0) at index " + to_string(j)).c_str() + (string)", key '" + (string)SvPV_nolen(lucky_integer_arrayref_key) + (string)"'", "integer_arrayref_hashref_typetest0()");
//            fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_typetest0(), have lucky integer %"INTEGER"/%"INTEGER" = %"INTEGER", key '%s', BARSTEP\n", j, (how_luckier - 1), (integer)SvNV(*av_fetch(lucky_integer_array, j, 0)), SvPV_nolen(lucky_integer_arrayref_key));
        }
    }
    // END DEBUG CODE

    return(newSVpvf("%s%s", SvPV_nolen(integer_arrayref_hashref_to_string(lucky_integer_arrayrefs)), "CPPOPS_PERLTYPES"));
}

SV* integer_arrayref_hashref_typetest1(SV* my_size)
{
//  integer_CHECK(my_size);
    integer_CHECKTRACE(my_size, "my_size", "integer_arrayref_hashref_typetest1()");
    HV* output_hv = newHV();
    integer i;
    char temp_key[30];

    for (i = 0;  i < SvIV(my_size);  ++i)
    {
        // set key up here so it can be used by the debugging print statement inside the inner loop
        sprintf(temp_key, "CPPOPS_PERLTYPES_funkey%"INTEGER"", i);

        // BEGIN ARRAY CODE
        AV* temp_av = newAV();
        integer j;

        av_extend(temp_av, (I32)(SvIV(my_size) - 1));

        for (j = 0;  j < SvIV(my_size);  ++j)
        {
            av_store(temp_av, (I32)j, newSViv(i * j));
//            fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_typetest1(), setting element at key '%s', at index %"INTEGER"/%"INTEGER" = %"INTEGER", BARBAT\n", temp_key, j, (integer)(SvIV(my_size) - 1), (integer)SvIV(*av_fetch(temp_av, (I32)j, 0)));
        }
        // END ARRAY CODE

        hv_store(output_hv, (const char*)temp_key, (U32)strlen(temp_key), newRV_noinc((SV*) temp_av), (U32)0);
    }

    return(newRV_noinc((SV*) output_hv));
}

// NEED ADD CODE HERE: type testing, CPPOPS_PERLTYPES, number & string
// NEED ADD CODE HERE: type testing, CPPOPS_PERLTYPES, number & string
// NEED ADD CODE HERE: type testing, CPPOPS_PERLTYPES, number & string

# elif defined __CPP__TYPES

string integer_arrayref_hashref_typetest0(integer_arrayref_hashref lucky_integer_arrayrefs) {
    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_typetest0(), top of subroutine...\n");

    // BEGIN DEBUG CODE
    integer_arrayref_hashref_const_iterator i;
    for (i = lucky_integer_arrayrefs.begin();  i != lucky_integer_arrayrefs.end();  ++i) {
        // BEGIN ARRAY CODE
        integer_arrayref lucky_integer_arrayref = i->second;
        integer how_luckier = lucky_integer_arrayref.size();
        integer j;

        for (j = 0;  j < how_luckier;  ++j) {
            fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_typetest0(), have lucky integer %"INTEGER"/%"INTEGER" = %"INTEGER", key '%s', BARSTEP\n", j, (how_luckier - 1), lucky_integer_arrayref[j], (i->first).c_str());
        }
        // END ARRAY CODE
    }
    // END DEBUG CODE

    return(integer_arrayref_hashref_to_string(lucky_integer_arrayrefs) + "CPPOPS_CPPTYPES");
}

integer_arrayref_hashref integer_arrayref_hashref_typetest1(integer my_size) {
    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_typetest1(), top of subroutine...\n");

    integer_arrayref_hashref new_vector_unordered_map(my_size);
    integer i;
    string temp_key;
    for (i = 0;  i < my_size;  ++i) {
        temp_key = "CPPOPS_CPPTYPES_funkey" + std::to_string(i);

        // BEGIN ARRAY CODE
        integer_arrayref temp_vec(my_size);
        integer j;
        for (j = 0;  j < my_size;  ++j)
        {
            temp_vec[j] = i * j;
            fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_typetest1(), setting element at key '%s', at index %"INTEGER"/%"INTEGER" = %"INTEGER", BARBAZ\n", temp_key.c_str(), j, (my_size - 1), temp_vec[j]);
        }
        // END ARRAY CODE

        new_vector_unordered_map[temp_key] = temp_vec;
    }
    return(new_vector_unordered_map);
}

// NEED ADD CODE HERE: type testing, CPPOPS_CPPTYPES, number & string
// NEED ADD CODE HERE: type testing, CPPOPS_CPPTYPES, number & string
// NEED ADD CODE HERE: type testing, CPPOPS_CPPTYPES, number & string

# endif

#endif

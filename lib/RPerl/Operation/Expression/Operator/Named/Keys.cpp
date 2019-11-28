using std::cout;  using std::cerr;  using std::endl;  using std::to_string;

#ifndef __CPP__INCLUDED__RPerl__Operation__Expression__Operator__Named__Keys_cpp
#define __CPP__INCLUDED__RPerl__Operation__Expression__Operator__Named__Keys_cpp 0.002_000

#include <RPerl/Operation/Expression/Operator/Named/Keys.h>  // -> ???

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

// short-hand, type-independent; call actual keys routine, after determining input data type
SV* keys(SV* input_hvref) {
    // NEED ADD CODE
    // will require extending or modifying *_CHECK*() functions to detect positive instead of negative only, then use to detect data type
    // can also be used for other type-independent operators such as stringify() and type-reporting
}

// convert from (Perl SV containing RV to (Perl HV of (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))))) to (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs)))
SV* integer_arrayref_hashref_keys(SV* input_avref_hvref) {
//    fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_keys(), top of subroutine...\n");
//    fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_keys(), received format_level = %"INTEGER", indent_level = %"INTEGER"\n", SvIV(format_level), SvIV(indent_level));

//  integer_arrayref_hashref_CHECK(input_avref_hvref);
    integer_arrayref_hashref_CHECKTRACE(input_avref_hvref, "input_avref_hvref", "integer_arrayref_hashref_to_string()");

/*
 * START HERE, CONVERT FROM STRINGIFY TO KEYS
 * START HERE, CONVERT FROM STRINGIFY TO KEYS
 * START HERE, CONVERT FROM STRINGIFY TO KEYS

    // declare local variables
    HV* input_avref_hv;
    integer input_avref_hv_num_keys;
    integer i;
    boolean i_is_0 = 1;
    HE* input_avref_hv_entry;
    SV* input_avref_hv_entry_key;
    string input_avref_hv_entry_key_string;
    SV* input_avref_hv_entry_value;
    SV* output_sv = newSVpv("", 0);

    // generate indent
    SV* indent = newSVpv("", 0);
    for (i = 0; i < SvIV(indent_level); i++) { sv_catpvn(indent, "    ", 4); }

    // compute length of (number of keys in) input hash
    input_avref_hv = (HV*)SvRV(input_avref_hvref);
    input_avref_hv_num_keys = hv_iterinit(input_avref_hv);
//  fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_keys(), have input_avref_hv_num_keys = %"INTEGER"\n", input_avref_hv_num_keys);

    // pre-begin with optional indent, depending on format level
    if (SvIV(format_level) >= 1) { sv_catsv(output_sv, indent); }  // pretty

    // begin output string with left-curly-brace, as required for all RPerl hashes
    sv_setpvn(output_sv, "{", 1);

    // loop through all hash keys
    // incrementing iteration, iterator i not actually used in loop body
    for (i = 0;  i < input_avref_hv_num_keys;  ++i) {
//      fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_keys(), top of loop i = %"INTEGER"\n", i);

        // does not utilize i in entry retrieval
        input_avref_hv_entry = hv_iternext(input_avref_hv);

        // DEV NOTE: hash entry type-checking already done as part of integer_arrayref_hashref_CHECKTRACE()
//      hashentry_CHECK(input_avref_hv_entry);
//      hashentry_CHECKTRACE(input_avref_hv_entry, "input_avref_hv_entry", "integer_arrayref_hashref_keys()");

        // retrieve input hash's entry value at key
        input_avref_hv_entry_key = hv_iterkeysv(input_avref_hv_entry);
        input_avref_hv_entry_value = hv_iterval(input_avref_hv, input_avref_hv_entry);

        // DEV NOTE: integer type-checking already done as part of integer_arrayref_hashref_CHECKTRACE()
//      integer_CHECK(input_avref_hv_entry_value);
//      integer_CHECKTRACE(input_avref_hv_entry_value, (char*)((string)"input_avref_hv_entry_value at key '" + (string)SvPV_nolen(input_avref_hv_entry_key) + "'").c_str(), "integer_arrayref_hashref_keys()");

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

//  fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_keys(), after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
//  fprintf(stderr, "in CPPOPS_PERLTYPES integer_arrayref_hashref_keys(), bottom of subroutine\n");

    return(output_sv);
*/
}

# elif defined __CPP__TYPES

template<string, typename HASH_VALUE_TYPE>
void print_keys_values(std::unordered_map<string, HASH_VALUE_TYPE> const &input_hash)
{
    for (auto iterator = input_hash.cbegin(); iterator != input_hash.cend(); ++iterator) {
        std::cout << "key: " << (*iterator).first << "\n" << "value: " << (*iterator).second << "\n\n";
    }
}

// convert from (C++ std::unordered_map of (C++ std::vector of integers)) to (C++ std::vector of strings)
template<string, typename HASH_VALUE_TYPE>
string_arrayref keys(std::unordered_map<string, HASH_VALUE_TYPE> const &input_unordered_map) {
    fprintf(stderr, "in CPPOPS_CPPTYPES keys(), top of subroutine\n");
    fprintf(stderr, "in CPPOPS_CPPTYPES keys(), received format_level = %"INTEGER", indent_level = %"INTEGER"\n", format_level, indent_level);

    // declare local variables
    string_arrayref output_keys;

    // loop through all hash keys
    for (auto iterator = input_unordered_map.begin();  iterator != input_unordered_map.end();  ++iterator) {
        // append key string to output vector
        output_keys.push_back(iterator->first);
    }

    fprintf(stderr, "in CPPOPS_CPPTYPES keys(), after for() loop, have output_keys =\n%s\n", (char*)(integer_arrayref_hashref_to_string(output_keys).c_str()));
    fprintf(stderr, "in CPPOPS_CPPTYPES keys(), bottom of subroutine\n");

    return(output_keys);
}


/* NEED DELETE, TYPE-SPECIFIC CODE REPLACED BY TYPE-INDEPENDENT TEMPLATE CODE

// short-hand, type-dependent; call actual keys routine
string_arrayref keys(integer_arrayref_hashref input_vector_unordered_map) {
    return integer_arrayref_hashref_keys(input_vector_unordered_map);
}

// convert from (C++ std::unordered_map of (C++ std::vector of integers)) to (C++ std::vector of strings)
string_arrayref integer_arrayref_hashref_keys(integer_arrayref_hashref input_vector_unordered_map) {
    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_keys(), top of subroutine\n");
    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_keys(), received format_level = %"INTEGER", indent_level = %"INTEGER"\n", format_level, indent_level);

    // declare local variables
    string_arrayref output_keys;
    integer_arrayref_hashref_const_iterator i;
    string key_string;

    // loop through all hash keys
    for (i = input_vector_unordered_map.begin();  i != input_vector_unordered_map.end();  ++i) {

        // escape key string
        key_string = escape_backslash_singlequote(i->first);

        // DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
        key_string = (const string)"'" + key_string << (const string)"'";

        // append key string to output vector
        output_keys.push_back(key_string);
    }

    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_keys(), after for() loop, have output_keys =\n%s\n", (char*)(integer_arrayref_hashref_to_string(output_keys).c_str()));
    fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_hashref_keys(), bottom of subroutine\n");

    return(output_keys);
}
*/

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

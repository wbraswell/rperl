using std::cout;  using std::cerr;  using std::endl;  //using std::to_string;  // NEED DELETE, PRE-TEMPLATE C++

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes1D_tpp
#define __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes1D_tpp 0.003_000


// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES





// VERY VERY VERY VERY VERY: need move DYNAMIC DISPATCH & type_fast*() code back to rperltypes.h or similar location
// VERY VERY VERY VERY VERY: need move DYNAMIC DISPATCH & type_fast*() code back to rperltypes.h or similar location
// VERY VERY VERY VERY VERY: need move DYNAMIC DISPATCH & type_fast*() code back to rperltypes.h or similar location

// DYNAMIC DISPATCH aka MULTIPLE DISPATCH
typedef SV* (*type_case)(SV*);

typedef enum {
//    TYPE_BOOLEAN,
//    TYPE_UNSIGNED_INTEGER,
    TYPE_INTEGER,
    TYPE_NUMBER,
//    TYPE_CHARACTER,
    TYPE_STRING,
    TYPE_UNKNOWN,
    TYPE_COUNT // not a type itself, instead used to find number of types
} type_enum;

type_case TYPE_CASES[TYPE_COUNT] = {
//    &boolean_to_string,
//    &unsigned_integer_to_string,
    &integer_to_string,
    &number_to_string,
//    &character_to_string,
    &string_to_string,
    &string_to_string,  // NEED UPGRADE: implement unknown_to_string()???
};

/* NEED DELETE, UNUSED: receives input_sv_type from type_enum_fast() instead of type_enum_fast_raw()
SV* DYNAMIC_to_string(SV* input_sv, SV* input_sv_type) {
    // warning: format ‘%i’ expects argument of type ‘int’, but argument 3 has type ‘IV {aka long int}’
    // warning: format ‘%d’ expects argument of type ‘int’, but argument 3 has type ‘IV {aka long int}’
    fprintf(stderr, "in CPPOPS_PERLTYPES DYNAMIC_to_string(), received input_sv_type = %ld\n", SvIV(input_sv_type));
    return (*TYPE_CASES[SvIV(input_sv_type)])(input_sv);
}
*/

SV* DYNAMIC_to_string(SV* input_sv, type_enum input_sv_type) {
    fprintf(stderr, "in CPPOPS_PERLTYPES DYNAMIC_to_string(), received input_sv_type = %d\n", input_sv_type);

    // NEED DELETE, TMP DEBUG
    struct timeval current_time;  gettimeofday(&current_time, NULL);
    fprintf(stderr, "in CPPOPS_PERLTYPES DYNAMIC_to_string(), have current_time seconds = %ld, micro seconds = %ld\n", current_time.tv_sec, current_time.tv_usec);

    return (*TYPE_CASES[input_sv_type])(input_sv);
}




// NEED UPGRADE: convert type_fast*() functions into equivalent macros

// a short-circuited, non-recursive version of type() subroutine
SV* type_fast(SV* variable) {
    if (not_defined(variable))   { return newSVpv("unknown", 0); }

    // DEV NOTE, CORRELATION #rp025: only report core types integer, number, string, arrayref, hashref, object;
    // do NOT report non-core types boolean, unsigned_integer, char, etc.
    // DEV NOTE: Perl's implicit casting can cause 1 constant or variable to report multiple types,
    // always report number before integer to avoid incorrect to_string() formatting
    if      ( SvNOKp(variable) ) { return newSVpv("number",  0); }
    else if ( SvIOKp(variable) ) { return newSVpv("integer", 0); }
    else if ( SvPOKp(variable) ) { return newSVpv("string",  0); }
    else                         { return newSVpv("unknown", 0); }
}

// a short-circuited, non-recursive version of type() subroutine; returns type enum value instead of type name string
SV* type_fast_enum(SV* variable) {
    if (not_defined(variable))   { return newSViv(TYPE_UNKNOWN); }

    // DEV NOTE, CORRELATION #rp025: only report core types integer, number, string, arrayref, hashref, object;
    // do NOT report non-core types boolean, unsigned_integer, char, etc.
    // DEV NOTE: Perl's implicit casting can cause 1 constant or variable to report multiple types,
    // always report number before integer to avoid incorrect to_string() formatting
    if      ( SvNOKp(variable) ) { return newSViv(TYPE_NUMBER ); }
    else if ( SvIOKp(variable) ) { return newSViv(TYPE_INTEGER); }
    else if ( SvPOKp(variable) ) { return newSViv(TYPE_STRING ); }
    else                         { return newSViv(TYPE_UNKNOWN); }
}

// a short-circuited, non-recursive version of type() subroutine; returns type enum raw value instead of type name string
type_enum type_fast_enum_raw(SV* variable) {
    fprintf(stderr, "in CPPOPS_PERLTYPES type_fast_enum_raw(), top of subroutine\n");

    // NEED DELETE, TMP DEBUG
    struct timeval current_time;  gettimeofday(&current_time, NULL);
    fprintf(stderr, "in CPPOPS_PERLTYPES type_fast_enum_raw(), have current_time seconds = %ld, micro seconds = %ld\n", current_time.tv_sec, current_time.tv_usec);

    if (not_defined(variable))   { return TYPE_UNKNOWN; }

    // DEV NOTE, CORRELATION #rp025: only report core types integer, number, string, arrayref, hashref, object;
    // do NOT report non-core types boolean, unsigned_integer, char, etc.
    // DEV NOTE: Perl's implicit casting can cause 1 constant or variable to report multiple types,
    // always report number before integer to avoid incorrect to_string() formatting
    if      ( SvNOKp(variable) ) { return TYPE_NUMBER;  }
    else if ( SvIOKp(variable) ) { return TYPE_INTEGER; }
    else if ( SvPOKp(variable) ) { return TYPE_STRING;  }
    else                         { return TYPE_UNKNOWN; }
}







// DEV NOTE: 1-D format levels are 1 less than 2-D format levels

// call actual stringify routine, format level -2 (compact), indent level 0
SV* arrayref_to_string_compact(SV* input_avref) {
    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_compact(), about to call arrayref_to_string_format() DYNAMIC DISPATCH & return value...\n");
    return arrayref_to_string_format(input_avref, newSViv(-2), newSViv(0));
}

// call actual stringify routine, format level -1 (normal), indent level 0, DEFAULT
SV* arrayref_to_string(SV* input_avref) {
    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string(), about to call arrayref_to_string_format() DYNAMIC DISPATCH & return value...\n");
    return arrayref_to_string_format(input_avref, newSViv(-1), newSViv(0));
}

// call actual stringify routine, format level 0 (pretty), indent level 0
SV* arrayref_to_string_pretty(SV* input_avref) {
    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_pretty(), about to call arrayref_to_string_format() DYNAMIC DISPATCH & return value...\n");
    return arrayref_to_string_format(input_avref, newSViv(0), newSViv(0));
}

// call actual stringify routine, format level 1 (expand), indent level 0
SV* arrayref_to_string_expand(SV* input_avref) {
    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_expand(), about to call arrayref_to_string_format() DYNAMIC DISPATCH & return value...\n");
    return arrayref_to_string_format(input_avref, newSViv(1), newSViv(0));
}

// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing (IVs or NVs or PVs)))) to Perl-parsable (Perl SV containing PV)
SV* arrayref_to_string_format(SV* input_avref, SV* format_level, SV* indent_level)
{
    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, top of subroutine\n");
    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 00\n");





// VERY VERY VERY VERY VERY: generalize CHECKTRACE type
// VERY VERY VERY VERY VERY: generalize CHECKTRACE type
// VERY VERY VERY VERY VERY: generalize CHECKTRACE type


//  number_arrayref_CHECK(input_avref);
    number_arrayref_CHECKTRACE(input_avref, "input_avref", "number_arrayref_to_string()");  // NEED RE-ENABLE VIA DYNAMIC




    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 01\n");



    // declare local variables
    AV* input_av;
    integer input_av_length;
    integer i;
    SV** input_av_element;
    SV* output_sv = newSVpv("", 0);
    boolean i_is_0 = 1;

    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 02\n");

    // generate indent
    SV* indent = newSVpv("", 0);
    for (i = 0; i < SvIV(indent_level); i++) { sv_catpvn(indent, "    ", 4); }

    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 03\n");

    // NEED ANSWER: do we actually need to be using ostringstream here for precision, since the actual numbers are being stringified by number_to_string() below???
    ostringstream temp_stream;
    temp_stream.precision(std::numeric_limits<double>::digits10);

    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 04\n");

    // compute length of (number of elements in) input array
    input_av = (AV*)SvRV(input_avref);
    input_av_length = av_len(input_av) + 1;
    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, have input_av_length = %"INTEGER"\n", input_av_length);

    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 05\n");

    // pre-begin with optional indent, depending on format level
    if (SvIV(format_level) >= 1) { temp_stream << SvPV_nolen(indent); }

    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 06\n");

    // begin output string with left-square-bracket, as required for all RPerl arrays
//    sv_catpvn(output_sv, "[", 1);
    temp_stream << "[";

    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 07\n");

    // loop through all valid values of i for use as index to input array
    for (i = 0;  i < input_av_length;  ++i)
    {
        fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 10\n");

        // utilizes i in element retrieval
        input_av_element = av_fetch(input_av, i, 0);

        fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 11\n");

        // append comma to output string for all elements except index 0
        if (i_is_0) { i_is_0 = 0; }
//        else        { sv_catpvn(output_sv, ",", 1); }
        else        { temp_stream << ","; }

        fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 12\n");

        // append newline-indent-tab or space, depending on format level
//        if      (SvIV(format_level) >=  1) { sv_catpvn(output_sv, "\n", 1);  sv_catsv(output_sv, indent);  sv_catpvn(output_sv, "    ", 4); }
//        else if (SvIV(format_level) >= -1) { sv_catpvn(output_sv, " ", 1); }
        if      (SvIV(format_level) >=  1) { temp_stream << "\n" << SvPV_nolen(indent) << "    "; }
        else if (SvIV(format_level) >= -1) { temp_stream << " "; }

        fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 13\n");





//        temp_stream << (string)SvPV_nolen(number_to_string(*input_av_element));  // GOOD ORIGINAL
//      sv_catpvf(output_sv, "%"NUMBER"", (number)SvNV(*input_av_element));  // NEED ANSWER: can we make fprintf(stderr, )-like %"NUMBER" (AKA %Lf or %f) act like ostringstream's precision?  probably not...





// VERY VERY VERY VERY VERY: implement manual DYNAMIC for CHECKTRACE() above; re-enable integer_arrayref_to_string*() & string_arrayref_to_string*() in SubTypes.1D.cpp; generalize DYNAMIC; remove duplicate DYNAMIC; move DYNAMIC to rperltypes.h or similar; enable DYNAMIC for boolean & unsigned_integer & character???
// VERY VERY VERY VERY VERY: implement manual DYNAMIC for CHECKTRACE() above; re-enable integer_arrayref_to_string*() & string_arrayref_to_string*() in SubTypes.1D.cpp; generalize DYNAMIC; remove duplicate DYNAMIC; move DYNAMIC to rperltypes.h or similar; enable DYNAMIC for boolean & unsigned_integer & character???
// VERY VERY VERY VERY VERY: implement manual DYNAMIC for CHECKTRACE() above; re-enable integer_arrayref_to_string*() & string_arrayref_to_string*() in SubTypes.1D.cpp; generalize DYNAMIC; remove duplicate DYNAMIC; move DYNAMIC to rperltypes.h or similar; enable DYNAMIC for boolean & unsigned_integer & character???



        SV* DYNAMIC_to_string_retval = DYNAMIC_to_string(*input_av_element, type_fast_enum_raw(*input_av_element));
        fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 13a\n");

        // DEV NOTE: the SvPV_nolen() macro appears to duplicate its argument, presumably for the "nolen" automatic length checking; will wrongly call operation twice, only pass variable as argument
        temp_stream <<
            (string)SvPV_nolen(
                DYNAMIC_to_string_retval  // RIGHT, called once (above)
//                DYNAMIC_to_string(*input_av_element, type_fast_enum_raw(*input_av_element))  // WRONG, called twice
            );






        fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 14\n");

        


    }

    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 20\n");

    // append newline-indent or space, depending on format level
//    if      (SvIV(format_level) >=  1) { sv_catpvn(output_sv, "\n", 1);  sv_catsv(output_sv, indent); }
//    else if (SvIV(format_level) >= -1) { sv_catpvn(output_sv, " ", 1); }
    if      (SvIV(format_level) >=  1) { temp_stream << "\n" << SvPV_nolen(indent); }
    else if (SvIV(format_level) >= -1) { temp_stream << " "; }

    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 21\n");

    // end output string with right-square-bracket, as required for all RPerl arrays
    temp_stream << "]";
    sv_setpv(output_sv, (char *)(temp_stream.str().c_str()));
//  sv_catpvn(output_sv, "]", 1);

    fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, checkpoint 22\n");

  fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
  fprintf(stderr, "in CPPOPS_PERLTYPES arrayref_to_string_format() DYNAMIC DISPATCH, bottom of subroutine\n");

    return(output_sv);
}





# elif defined __CPP__TYPES

// DEV NOTE: 1-D format levels are 1 less than 2-D format levels

// call actual stringify routine, format level -2 (compact), indent level 0
template <class ARRAYREF_TYPENAME>
string arrayref_to_string_compact(ARRAYREF_TYPENAME input_vector)
{
    return arrayref_to_string_format(input_vector, -2, 0);
}

// call actual stringify routine, format level -1 (normal), indent level 0, DEFAULT
template <class ARRAYREF_TYPENAME>
string arrayref_to_string(ARRAYREF_TYPENAME input_vector)
{
    return arrayref_to_string_format(input_vector, -1, 0);
}

// call actual stringify routine, format level 0 (pretty), indent level 0
template <class ARRAYREF_TYPENAME>
string arrayref_to_string_pretty(ARRAYREF_TYPENAME input_vector)
{
    return arrayref_to_string_format(input_vector, 0, 0);
}

// call actual stringify routine, format level 1 (expand), indent level 0
template <class ARRAYREF_TYPENAME>
string arrayref_to_string_expand(ARRAYREF_TYPENAME input_vector)
{
    return arrayref_to_string_format(input_vector, 1, 0);
}





// VERY VERY VERY VERY VERY: determine if corresponding PERLOPS_PERLTYPES stringify code and/or tests need to be updated to match to_string() calling convention; what about To_string() vs to_string()??? 
// VERY VERY VERY VERY VERY: determine if corresponding PERLOPS_PERLTYPES stringify code and/or tests need to be updated to match to_string() calling convention; what about To_string() vs to_string()??? 
// VERY VERY VERY VERY VERY: determine if corresponding PERLOPS_PERLTYPES stringify code and/or tests need to be updated to match to_string() calling convention; what about To_string() vs to_string()??? 





// convert from (C++ std::vector of ARRAYREF_TYPENAMEs) to Perl-parsable (C++ std::string)
template <class ARRAYREF_TYPENAME>
string arrayref_to_string_format(ARRAYREF_TYPENAME input_vector, integer format_level, integer indent_level)
{
    fprintf(stderr, "in CPPOPS_CPPTYPES arrayref_to_string_format() TEMPLATE, top of subroutine...\n");
    fprintf(stderr, "in CPPOPS_CPPTYPES arrayref_to_string_format() TEMPLATE, received format_level = %"INTEGER", indent_level = %"INTEGER"\n", format_level, indent_level);

    // declare local variables
    ostringstream output_stream;
    integer input_vector_length = input_vector.size();  // compute length of (number of elements in) input array
    integer i;
    typename ARRAYREF_TYPENAME::value_type input_vector_element;
    boolean i_is_0 = 1;

    // generate indent
    string indent = "";
    for (i = 0; i < indent_level; i++) { indent += "    "; }

//  fprintf(stderr, "in CPPOPS_CPPTYPES arrayref_to_string_format(), have input_vector_length = %"INTEGER"\n", input_vector_length);

    // pre-begin with optional indent, depending on format level
    if (format_level >= 1) { output_stream << indent; }

    // begin output string with left-square-bracket, as required for all RPerl arrays
    output_stream << '[';

    // loop through all valid values of i for use as index to input array
    for (i = 0;  i < input_vector_length;  ++i)
    {
        // utilizes i in element retrieval
        input_vector_element = input_vector[i];

        // append comma to output string for all elements except index 0
        if (i_is_0) { i_is_0 = 0; }
        else        { output_stream << ','; }

        // append newline-indent-tab or space, depending on format level
        if      (format_level >=  1) { output_stream << endl << indent << "    "; }
        else if (format_level >= -1) { output_stream << ' '; }
 
        fprintf(stderr, "in CPPOPS_CPPTYPES arrayref_to_string_format() TEMPLATE, about to call to_string()...\n");

//      output_stream << input_vector_element;  // INCORRECT: NO UNDERSCORES
        output_stream << to_string(input_vector_element);  // CORRECT: YES UNDERSCORES FOR NUMERIC TYPES, BACKSLASH-ESCAPES FOR STRING TYPE
      
        fprintf(stderr, "in CPPOPS_CPPTYPES arrayref_to_string_format() TEMPLATE, ret from call to to_string()\n");
    }

    // append newline-indent or space, depending on format level
    if      (format_level >=  1) { output_stream << endl << indent; }
    else if (format_level >= -1) { output_stream << ' '; }

    // end output string with right-square-bracket, as required for all RPerl arrays
    output_stream << ']';

//  fprintf(stderr, "in CPPOPS_CPPTYPES arrayref_to_string_format() TEMPLATE, after for() loop, have output_stream =\n%s\n", (char *)(output_stream.str().c_str()));
//  fprintf(stderr, "in CPPOPS_CPPTYPES arrayref_to_string_format() TEMPLATE, bottom of subroutine\n");

    return(output_stream.str());
}

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

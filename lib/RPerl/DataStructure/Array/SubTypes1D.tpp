using std::cout;  using std::cerr;  using std::endl;  //using std::to_string;  // NEED DELETE, PRE-TEMPLATE C++

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes1D_tpp
#define __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes1D_tpp 0.003_000


// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

// ADD CODE, PERL TYPES

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

//      output_stream << input_vector_element;  // NO UNDERSCORES
        output_stream << to_string(input_vector_element);  // YES UNDERSCORES FOR NUMERIC TYPES, BACKSLASH-ESCAPES FOR STRING TYPE
      
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

using std::cout;  using std::cerr;  using std::endl;  using std::to_string;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes2D_cpp
#define __CPP__INCLUDED__RPerl__DataStructure__Array__SubTypes2D_cpp 0.003_000

#include <RPerl/DataStructure/Array/SubTypes2D.h>  // -> ??? (relies on <vector> being included via Inline::CPP's AUTO_INCLUDE config option in RPerl/Inline.pm)

// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]

void integer_arrayref_arrayref_CHECK(SV* possible_integer_arrayref_arrayref)
{
	fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_arrayref_CHECK(), top of subroutine\n");

    if ( not( SvOK(possible_integer_arrayref_arrayref) ) ) { croak( "\nERROR EIVAVRVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_arrayref value expected but undefined/null value found,\ncroaking" ); }
    if ( not( SvAROKp(possible_integer_arrayref_arrayref) ) ) { croak( "\nERROR EIVAVRVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_arrayref value expected but non-arrayref value found,\ncroaking" ); }

    AV* possible_integer_arrayref_array;
    integer possible_integer_arrayref_array_length;
    integer i;
    SV** possible_integer_arrayref_array_element;

    possible_integer_arrayref_array = (AV*)SvRV(possible_integer_arrayref_arrayref);
	possible_integer_arrayref_array_length = av_len(possible_integer_arrayref_array) + 1;

	for (i = 0;  i < possible_integer_arrayref_array_length;  ++i)  // incrementing iteration
	{
		possible_integer_arrayref_array_element = av_fetch(possible_integer_arrayref_array, i, 0);
		if ( not( SvOK(*possible_integer_arrayref_array_element) ) ) { croak( "\nERROR EIVAVRVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_arrayref sub-arrayref value expected but undefined/null value found at index %"INTEGER",\ncroaking", i ); }
		if ( not( SvAROKp(*possible_integer_arrayref_array_element) ) ) { croak( "\nERROR EIVAVRVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_arrayref sub-arrayref value expected but non-arrayref value found at index %"INTEGER",\ncroaking", i ); }

		SV* possible_integer_arrayref = *possible_integer_arrayref_array_element;

	    AV* possible_integer_array;
	    integer possible_integer_array_length;
	    integer j;
	    SV** possible_integer_array_element;

	    possible_integer_array = (AV*)SvRV(possible_integer_arrayref);
	    possible_integer_array_length = av_len(possible_integer_array) + 1;

	    for (j = 0;  j < possible_integer_array_length;  ++j)  // incrementing iteration
	    {
	        possible_integer_array_element = av_fetch(possible_integer_array, j, 0);
	        if (not(SvOK(*possible_integer_array_element))) { croak("\nERROR EIVAVRVAVRV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref element value expected but undefined/null value found at index (%"INTEGER", %"INTEGER"),\ncroaking", i, j); }
	        if (not(SvIOKp(*possible_integer_array_element))) { croak("\nERROR EIVAVRVAVRV05, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref element value expected but non-integer value found at index (%"INTEGER", %"INTEGER"),\ncroaking", i, j); }
	    }
	}
	fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_arrayref_CHECK(), bottom of subroutine\n");
}

void integer_arrayref_arrayref_CHECKTRACE(SV* possible_integer_arrayref_arrayref, const char* variable_name, const char* subroutine_name)
{
	fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_arrayref_CHECKTRACE(), top of subroutine, received variable_name = %s\n", variable_name);
	fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_arrayref_CHECKTRACE(), top of subroutine, received subroutine_name = %s\n", subroutine_name);

    if ( not( SvOK(possible_integer_arrayref_arrayref) ) ) { croak( "\nERROR EIVAVRVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_arrayref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }
    if ( not( SvAROKp(possible_integer_arrayref_arrayref) ) ) { croak( "\nERROR EIVAVRVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_arrayref value expected but non-arrayref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }

    AV* possible_integer_arrayref_array;
    integer possible_integer_arrayref_array_length;
    integer i;
    SV** possible_integer_arrayref_array_element;

    possible_integer_arrayref_array = (AV*)SvRV(possible_integer_arrayref_arrayref);
    possible_integer_arrayref_array_length = av_len(possible_integer_arrayref_array) + 1;

    for (i = 0;  i < possible_integer_arrayref_array_length;  ++i)  // incrementing iteration
    {
        possible_integer_arrayref_array_element = av_fetch(possible_integer_arrayref_array, i, 0);
        if ( not( SvOK(*possible_integer_arrayref_array_element) ) ) { croak( "\nERROR EIVAVRVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_arrayref sub-arrayref value expected but undefined/null value found at index %"INTEGER",\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name ); }
        if ( not( SvAROKp(*possible_integer_arrayref_array_element) ) ) { croak( "\nERROR EIVAVRVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref_arrayref sub-arrayref value expected but non-arrayref value found at index %"INTEGER",\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name ); }

        SV* possible_integer_arrayref = *possible_integer_arrayref_array_element;

        AV* possible_integer_array;
        integer possible_integer_array_length;
        integer j;
        SV** possible_integer_array_element;

        possible_integer_array = (AV*)SvRV(possible_integer_arrayref);
        possible_integer_array_length = av_len(possible_integer_array) + 1;

        for (j = 0;  j < possible_integer_array_length;  ++j)  // incrementing iteration
        {
            possible_integer_array_element = av_fetch(possible_integer_array, j, 0);
            if (not(SvOK(*possible_integer_array_element))) { croak("\nERROR EIVAVRVAVRV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref element value expected but undefined/null value found at index (%"INTEGER", %"INTEGER"),\nin variable %s from subroutine %s,\ncroaking", i, j, variable_name, subroutine_name ); }
            if (not(SvIOKp(*possible_integer_array_element))) { croak("\nERROR EIVAVRVAVRV05, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger_arrayref element value expected but non-integer value found at index (%"INTEGER", %"INTEGER"),\nin variable %s from subroutine %s,\ncroaking", i, j, variable_name, subroutine_name ); }
        }
    }
	fprintf(stderr, "in CPPOPS_CPPTYPES integer_arrayref_arrayref_CHECKTRACE(), bottom of subroutine\n");
}

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES

// convert from (Perl SV containing RV to (Perl AV of (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))))) to (C++ std::vector of (C++ std::vector of integers))
integer_arrayref_arrayref XS_unpack_integer_arrayref_arrayref(SV* input_avref_avref)
{
	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_arrayref(), top of subroutine\n");
//	integer_arrayref_arrayref_CHECK(input_avref_avref);
	integer_arrayref_arrayref_CHECKTRACE(input_avref_avref, "input_avref_avref", "XS_unpack_integer_arrayref_arrayref()");

    AV* input_avref_av;
    integer input_avref_av_length;
    integer i;
    SV** input_avref_av_element;
    integer_arrayref_arrayref output_vector_vector;

    input_avref_av = (AV*)SvRV(input_avref_avref);
	input_avref_av_length = av_len(input_avref_av) + 1;
	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_arrayref(), have input_avref_av_length = %"INTEGER"\n", input_avref_av_length);

	// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// resize() ahead of time to allow l-value subscript notation
	output_vector_vector.resize((size_t)input_avref_av_length);

	for (i = 0;  i < input_avref_av_length;  ++i)  // incrementing iteration
	{
	    AV* input_av;
	    integer input_av_length;
	    integer j;
	    SV** input_av_element;
	    integer_arrayref output_vector;

	    // utilizes i in element retrieval
	    input_avref_av_element = av_fetch(input_avref_av, i, 0);

//	    input_av = (AV*)SvRV(*input_avref);  // input_avref is an unused shorthand for input_avref_av_element
	    input_av = (AV*)SvRV(*input_avref_av_element);
	    input_av_length = av_len(input_av) + 1;
	    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_arrayref(), have input_av_length = %"INTEGER"\n", input_av_length);

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

	    fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_arrayref(), bottom of outer for() loop i = %"INTEGER", have output_vector.size() = %"INTEGER"\n", i, (integer) output_vector.size());

	    // VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
	    output_vector_vector[i] = output_vector;
	}

	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_arrayref(), after for() loop, have output_vector_vector.size() = %"INTEGER"\n", (integer) output_vector_vector.size());
	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer_arrayref_arrayref(), bottom of subroutine\n");

	return(output_vector_vector);
}


// convert from (C++ std::vector of (C++ std::vector of integers)) to (Perl SV containing RV to (Perl AV of (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs)))))
void XS_pack_integer_arrayref_arrayref(SV* output_avref_avref, integer_arrayref_arrayref input_vector_vector)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_arrayref(), top of subroutine\n");

	AV* output_avref_av = newAV();  // initialize output array-of-arrays to empty
	integer input_vector_vector_length = input_vector_vector.size();
	integer i;
	SV* temp_sv_pointer;

//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_arrayref(), have input_vector_vector_length = %"INTEGER"\n", input_vector_vector_length);

	if (input_vector_vector_length > 0) {
	    for (i = 0;  i < input_vector_vector_length;  ++i) {
//            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_arrayref(), top of outer loop, have i = %"INTEGER"\n", i);
	        integer_arrayref input_vector = input_vector_vector[i];

	        AV* output_av = newAV();  // initialize output sub-array to empty
	        integer input_vector_length = input_vector.size();
	        integer j;

//	        fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_arrayref(), have input_vector_length = %"INTEGER"\n", input_vector_length);

	        if (input_vector_length > 0) {
	            for (j = 0;  j < input_vector_length;  ++j) {
//	                fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_arrayref(), top of inner loop, have (i, j) = (%"INTEGER", %"INTEGER")\n", i, j);
//	                fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_arrayref(), have input_vector_vector[%"INTEGER"][%"INTEGER"] = %"INTEGER"\n", i, j, input_vector[j]);
	                av_push(output_av, newSViv(input_vector[j]));
//	                fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_arrayref(), bottom of inner loop, have (i, j) = (%"INTEGER", %"INTEGER")\n", i, j);
	            }
	        }
	        else warn("in CPPOPS_CPPTYPES XS_pack_integer_arrayref_arrayref(), sub-array was empty, returning empty sub-array via newAV()");

	        // NEED ANSWER: is it really okay to NOT increase the reference count below???
	        av_push(output_avref_av, newRV_noinc((SV*)output_av));  // reference, do not increase reference count
//	        av_push(output_avref_av, newRV_inc((SV*)output_av));  // reference, do increase reference count

//            fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_arrayref(), bottom of outer loop, have i = %"INTEGER"\n", i);
	    }
	}
	else warn("in CPPOPS_CPPTYPES XS_pack_integer_arrayref_arrayref(), array was empty, returning empty array via newAV()");

	temp_sv_pointer = newSVrv(output_avref_avref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointer);		 // discard temporary pointer
	SvRV(output_avref_avref) = (SV*)output_avref_av;	   // make output stack RV pointer at our output AV

//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer_arrayref_arrayref(), bottom of subroutine\n");
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

// THEN START HERE: implement *_arrayref_arrayref_to_string() & *_hashref_arrayref_to_string() CPPOPS_PERLTYPES
// THEN START HERE: implement *_arrayref_arrayref_to_string() & *_hashref_arrayref_to_string() CPPOPS_PERLTYPES
// THEN START HERE: implement *_arrayref_arrayref_to_string() & *_hashref_arrayref_to_string() CPPOPS_PERLTYPES

# elif defined __CPP__TYPES

// START HERE: implement *_arrayref_arrayref_to_string() & *_hashref_arrayref_to_string() CPPOPS_CPPTYPES
// START HERE: implement *_arrayref_arrayref_to_string() & *_hashref_arrayref_to_string() CPPOPS_CPPTYPES
// START HERE: implement *_arrayref_arrayref_to_string() & *_hashref_arrayref_to_string() CPPOPS_CPPTYPES

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif


// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

# elif defined __CPP__TYPES

// NEED ADD CODE HERE
// NEED ADD CODE HERE
// NEED ADD CODE HERE

# endif

#endif

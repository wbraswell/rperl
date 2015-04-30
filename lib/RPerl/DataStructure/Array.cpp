////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::to_string;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array_cpp
#define __CPP__INCLUDED__RPerl__DataStructure__Array_cpp 0.004_000

#include <RPerl/DataStructure/Array.h>		// -> NULL (relies on <vector> being included via Inline::CPP's AUTO_INCLUDE config option)

/*
 * NEED FIX, CORRELATION #02: bug, possibly in Inline, causing inability to declare 3rd count_FOO argument to T_PACKEDARRAY;
 * temporarily fixed by changing typemap to set char** to T_PACKED;
 * may need Inline to add declaration of count_FOO to PREINIT section of auto-generated XS code
 *
 * eval_FOO.c: In function ‘void XS_main_XS_unpack_charPtrPtr(PerlInterpreter*, CV*)’:
 * eval_FOO.c:1322:36: error: ‘count_charPtrPtr’ was not declared in this scope
 */

// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]
// [[[ TYPE-CHECKING ]]]

// DEV NOTE: for() loops are statements not expressions, so they can't be embedded in ternary operators, and thus this type-checking must be done with subroutines instead of macros
void integer__array_ref__CHECK(SV* possible_integer__array_ref)
{
	// DEV NOTE: the following two if() statements are functionally equivalent to the array_ref__CHECK() macro, but with integer-specific error codes
    if ( not( SvOK(possible_integer__array_ref) ) ) { croak( "\nERROR EIVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger__array_ref value expected but undefined/null value found,\ncroaking" ); }
    if ( not( SvAROKp(possible_integer__array_ref) ) ) { croak( "\nERROR EIVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger__array_ref value expected but non-array_ref value found,\ncroaking" ); }

    AV* possible_integer__array;
    integer possible_integer__array_length;
    integer i;
    SV** possible_integer__array_element;

    possible_integer__array = (AV*)SvRV(possible_integer__array_ref);
	possible_integer__array_length = av_len(possible_integer__array) + 1;

	for (i = 0;  i < possible_integer__array_length;  ++i)  // incrementing iteration
	{
		possible_integer__array_element = av_fetch(possible_integer__array, i, 0);

		// DEV NOTE: the following two if() statements are functionally equivalent to the integer__CHECK() macro & subroutine, but with array-specific error codes
	    if (not(SvOK(*possible_integer__array_element))) { croak("\nERROR EIVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger__array_ref element value expected but undefined/null value found at index %d,\ncroaking", i); }
		if (not(SvIOKp(*possible_integer__array_element))) { croak("\nERROR EIVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger__array_ref element value expected but non-integer value found at index %d,\ncroaking", i); }
	}
}
void integer__array_ref__CHECKTRACE(SV* possible_integer__array_ref, const char* variable_name, const char* subroutine_name)
{
    if ( not( SvOK(possible_integer__array_ref) ) ) { croak( "\nERROR EIVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger__array_ref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }
    if ( not( SvAROKp(possible_integer__array_ref) ) ) { croak( "\nERROR EIVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger__array_ref value expected but non-array_ref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }

    AV* possible_integer__array;
    integer possible_integer__array_length;
    integer i;
    SV** possible_integer__array_element;

    possible_integer__array = (AV*)SvRV(possible_integer__array_ref);
	possible_integer__array_length = av_len(possible_integer__array) + 1;

	for (i = 0;  i < possible_integer__array_length;  ++i)  // incrementing iteration
	{
		possible_integer__array_element = av_fetch(possible_integer__array, i, 0);

	    if (not(SvOK(*possible_integer__array_element))) { croak("\nERROR EIVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger__array_ref element value expected but undefined/null value found at index %d,\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
		if (not(SvIOKp(*possible_integer__array_element))) { croak("\nERROR EIVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger__array_ref element value expected but non-integer value found at index %d,\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
	}
}
void number__array_ref__CHECK(SV* possible_number__array_ref)
{
    if ( not( SvOK(possible_number__array_ref) ) ) { croak( "\nERROR ENVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber__array_ref value expected but undefined/null value found,\ncroaking" ); }
    if ( not( SvAROKp(possible_number__array_ref) ) ) { croak( "\nERROR ENVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber__array_ref value expected but non-array_ref value found,\ncroaking" ); }

    AV* possible_number__array;
    integer possible_number__array_length;
    integer i;
    SV** possible_number__array_element;

    possible_number__array = (AV*)SvRV(possible_number__array_ref);
	possible_number__array_length = av_len(possible_number__array) + 1;

	for (i = 0;  i < possible_number__array_length;  ++i)  // incrementing iteration
	{
		possible_number__array_element = av_fetch(possible_number__array, i, 0);

	    if (not(SvOK(*possible_number__array_element))) { croak("\nERROR ENVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber__array_ref element value expected but undefined/null value found at index %d,\ncroaking", i); }
		if (not(SvNOKp(*possible_number__array_element) || SvIOKp(*possible_number__array_element))) { croak("\nERROR ENVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber__array_ref element value expected but non-number value found at index %d,\ncroaking", i); }
	}
}
void number__array_ref__CHECKTRACE(SV* possible_number__array_ref, const char* variable_name, const char* subroutine_name)
{
    if ( not( SvOK(possible_number__array_ref) ) ) { croak( "\nERROR ENVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber__array_ref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }
    if ( not( SvAROKp(possible_number__array_ref) ) ) { croak( "\nERROR ENVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber__array_ref value expected but non-array_ref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }

    AV* possible_number__array;
    integer possible_number__array_length;
    integer i;
    SV** possible_number__array_element;

    possible_number__array = (AV*)SvRV(possible_number__array_ref);
	possible_number__array_length = av_len(possible_number__array) + 1;

	for (i = 0;  i < possible_number__array_length;  ++i)  // incrementing iteration
	{
		possible_number__array_element = av_fetch(possible_number__array, i, 0);

	    if (not(SvOK(*possible_number__array_element))) { croak("\nERROR ENVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber__array_ref element value expected but undefined/null value found at index %d,\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
		if (not(SvNOKp(*possible_number__array_element) || SvIOKp(*possible_number__array_element))) { croak("\nERROR ENVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber__array_ref element value expected but non-number value found at index %d,\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
	}
}
void string__array_ref__CHECK(SV* possible_string__array_ref)
{
    if ( not( SvOK(possible_string__array_ref) ) ) { croak( "\nERROR EPVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring__array_ref value expected but undefined/null value found,\ncroaking" ); }
    if ( not( SvAROKp(possible_string__array_ref) ) ) { croak( "\nERROR EPVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring__array_ref value expected but non-array_ref value found,\ncroaking" ); }

    AV* possible_string__array;
    integer possible_string__array_length;
    integer i;
    SV** possible_string__array_element;

    possible_string__array = (AV*)SvRV(possible_string__array_ref);
	possible_string__array_length = av_len(possible_string__array) + 1;

	for (i = 0;  i < possible_string__array_length;  ++i)  // incrementing iteration
	{
		possible_string__array_element = av_fetch(possible_string__array, i, 0);

	    if (not(SvOK(*possible_string__array_element))) { croak("\nERROR EPVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring__array_ref element value expected but undefined/null value found at index %d,\ncroaking", i); }
		if (not(SvPOKp(*possible_string__array_element))) { croak("\nERROR EPVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring__array_ref element value expected but non-string value found at index %d,\ncroaking", i); }
	}
}
void string__array_ref__CHECKTRACE(SV* possible_string__array_ref, const char* variable_name, const char* subroutine_name)
{
    if ( not( SvOK(possible_string__array_ref) ) ) { croak( "\nERROR EPVAVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring__array_ref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }
    if ( not( SvAROKp(possible_string__array_ref) ) ) { croak( "\nERROR EPVAVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring__array_ref value expected but non-array_ref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name ); }

    AV* possible_string__array;
    integer possible_string__array_length;
    integer i;
    SV** possible_string__array_element;

    possible_string__array = (AV*)SvRV(possible_string__array_ref);
	possible_string__array_length = av_len(possible_string__array) + 1;

	for (i = 0;  i < possible_string__array_length;  ++i)  // incrementing iteration
	{
		possible_string__array_element = av_fetch(possible_string__array, i, 0);

	    if (not(SvOK(*possible_string__array_element))) { croak("\nERROR EPVAVRV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring__array_ref element value expected but undefined/null value found at index %d,\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
		if (not(SvPOKp(*possible_string__array_element))) { croak("\nERROR EPVAVRV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring__array_ref element value expected but non-string value found at index %d,\nin variable %s from subroutine %s,\ncroaking", i, variable_name, subroutine_name); }
	}
}

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

# ifdef __CPP__TYPES

// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))) to (C++ std::vector of integers)
integer__array_ref XS_unpack_integer__array_ref(SV* input_av_ref)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer__array_ref(), top of subroutine\n");
//	integer__array_ref__CHECK(input_av_ref);
	integer__array_ref__CHECKTRACE(input_av_ref, "input_av_ref", "XS_unpack_integer__array_ref()");

    AV* input_av;
    integer input_av_length;
    integer i;
    SV** input_av_element;
    integer__array_ref output_vector;

    input_av = (AV*)SvRV(input_av_ref);
	input_av_length = av_len(input_av) + 1;
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer__array_ref(), have input_av_length = %d\n", input_av_length);

	// DEV NOTE: VECTOR ELEMENT ASSIGNMENT OPTION information is not specific to this subroutine or packing/unpacking

	// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// resize() ahead of time to allow l-value subscript notation
	output_vector.resize((size_t)input_av_length);

	// VECTOR ELEMENT ASSIGNMENT, OPTION C, PUSH, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid memory reallocation(s) (aka change in vector capacity) during element copying in for() loop
//	output_vector.reserve((size_t)input_av_length);

	// VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE:
//	output_vector.reserve((size_t)input_av_length);  // if incrementing iteration
//	output_vector.resize((size_t)input_av_length);  // if decrementing iteration

	for (i = 0;  i < input_av_length;  ++i)  // incrementing iteration
//	for (i = (input_av_length - 1);  i >= 0;  --i)  // decrementing iteration
	{
		// utilizes i in element retrieval
		input_av_element = av_fetch(input_av, i, 0);
		// DEV NOTE: integer type-checking already done as part of integer__array_ref__CHECKTRACE()
//		integer__CHECK(*input_av_element);
//		integer__CHECKTRACE(*input_av_element, (char*)((string)"*input_av_element at index " + to_string(i)).c_str(), "XS_unpack_integer__hash_ref()");

		// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
		output_vector[i] = SvIV(*input_av_element);

		// VECTOR ELEMENT ASSIGNMENT, OPTION B, SUBSCRIPT, UNKNOWN SIZE: unpredictable value of i and thus unpredictable vector size,
		// call resize() every time we use l-value subscript; utilizes i in assignment
//		VECTOR_RESIZE_NOSHRINK(output_vector, (i + 1));  output_vector[i] = SvIV(*input_av_element);

		// VECTOR ELEMENT ASSIGNMENT, OPTIONS C & D, PUSH, KNOWN & UNKNOWN SIZE: push_back() calls resize(); does not utilize i in assignment;
		// only works for incrementing iteration!!!  will reverse list order for decrementing iteration, there is no push_front() method
//		output_vector.push_back(SvIV(*input_av_element));

		// VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE: utilizes i in assignment
//		output_vector.insert((i + output_vector.begin()), SvIV(*input_av_element));  // if incrementing iteration
//		output_vector.erase(i + output_vector.begin());  output_vector.insert((i + output_vector.begin()), SvIV(*input_av_element));  // if decrementing iteration

		// VECTOR ELEMENT ASSIGNMENT, OPTION F, ITERATOR, UNKNOWN SIZE: unpredictable value of i and thus unpredictable vector size,
		// call resize() every time we use insert(); utilizes i in assignment
//		VECTOR_RESIZE_NOSHRINK(output_vector, (i + 1));  output_vector.erase(i + output_vector.begin());  output_vector.insert((i + output_vector.begin()), SvIV(*input_av_element));
	}

//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer__array_ref(), after for() loop, have output_vector.size() = %d\n", output_vector.size());
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_integer__array_ref(), bottom of subroutine\n");

	return(output_vector);
}


// convert from (C++ std::vector of integers) to (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs)))
void XS_pack_integer__array_ref(SV* output_av_ref, integer__array_ref input_vector)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer__array_ref(), top of subroutine\n");

	AV* output_av = newAV();  // initialize output array to empty
	integer input_vector_length = input_vector.size();
	integer i;
	SV* temp_sv_pointegerer;

//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer__array_ref(), have input_vector_length = %d\n", input_vector_length);

	if (input_vector_length > 0) { for (i = 0;  i < input_vector_length;  ++i) { av_push(output_av, newSViv(input_vector[i])); } }
//	else warn("in CPPOPS_CPPTYPES XS_pack_integer__array_ref(), array was empty, returning empty array via newAV()");

	temp_sv_pointegerer = newSVrv(output_av_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointegerer);		 // discard temporary pointegerer
	SvRV(output_av_ref) = (SV*)output_av;	   // make output stack RV pointeger at our output AV

//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_integer__array_ref(), bottom of subroutine\n");
}


// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs))) to (C++ std::vector of numbers)
number__array_ref XS_unpack_number__array_ref(SV* input_av_ref)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number__array_ref(), top of subroutine\n");
//	number__array_ref__CHECK(input_av_ref);
	number__array_ref__CHECKTRACE(input_av_ref, "input_av_ref", "XS_unpack_number__array_ref()");

    AV* input_av;
    integer input_av_length;
    integer i;
    SV** input_av_element;
    number__array_ref output_vector;

    input_av = (AV*)SvRV(input_av_ref);
	input_av_length = av_len(input_av) + 1;
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number__array_ref(), have input_av_length = %d\n", input_av_length);

	// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// resize() ahead of time to allow l-value subscript notation
	output_vector.resize((size_t)input_av_length);

	for (i = 0;  i < input_av_length;  ++i)  // incrementing iteration
	{
		// utilizes i in element retrieval
		input_av_element = av_fetch(input_av, i, 0);

		// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
		output_vector[i] = SvNV(*input_av_element);
	}

//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number__array_ref(), after for() loop, have output_vector.size() = %d\n", output_vector.size());
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_number__array_ref(), bottom of subroutine\n");

	return(output_vector);
}


// convert from (C++ std::vector of numbers) to (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs)))
void XS_pack_number__array_ref(SV* output_av_ref, number__array_ref input_vector)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number__array_ref(), top of subroutine\n");

	AV* output_av = newAV();  // initialize output array to empty
	integer input_vector_length = input_vector.size();
	integer i;
	SV* temp_sv_pointegerer;

//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number__array_ref(), have input_vector_length = %d\n", input_vector_length);

	if (input_vector_length > 0) { for (i = 0;  i < input_vector_length;  ++i) { av_push(output_av, newSVnv(input_vector[i])); } }
//	else warn("in CPPOPS_CPPTYPES XS_pack_number__array_ref(), array was empty, returning empty array via newAV()");

	temp_sv_pointegerer = newSVrv(output_av_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointegerer);		 // discard temporary pointegerer
	SvRV(output_av_ref) = (SV*)output_av;	   // make output stack RV pointeger at our output AV

//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_number__array_ref(), bottom of subroutine\n");
}


// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs))) to (C++ std::vector of std::strings)
string__array_ref XS_unpack_string__array_ref(SV* input_av_ref)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string__array_ref(), top of subroutine\n");
//	string__array_ref__CHECK(input_av_ref);
	string__array_ref__CHECKTRACE(input_av_ref, "input_av_ref", "XS_unpack_string__array_ref()");

    AV* input_av;
    integer input_av_length;
    integer i;
    SV** input_av_element;
    string__array_ref output_vector;

    input_av = (AV*)SvRV(input_av_ref);
	input_av_length = av_len(input_av) + 1;
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string__array_ref(), have input_av_length = %d\n", input_av_length);

	// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// resize() ahead of time to allow l-value subscript notation
	output_vector.resize((size_t)input_av_length);

	for (i = 0;  i < input_av_length;  ++i)  // incrementing iteration
	{
		// utilizes i in element retrieval
		input_av_element = av_fetch(input_av, i, 0);

		// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
		output_vector[i] = SvPV_nolen(*input_av_element);
	}

//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string__array_ref(), after for() loop, have output_vector.size() = %d\n", output_vector.size());
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_unpack_string__array_ref(), bottom of subroutine\n");

	return(output_vector);
}


// convert from (C++ std::vector of std::strings) to (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs)))
void XS_pack_string__array_ref(SV* output_av_ref, string__array_ref input_vector)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string__array_ref(), top of subroutine\n");

	AV* output_av = newAV();  // initialize output array to empty
	integer input_vector_length = input_vector.size();
	integer i;
	SV* temp_sv_pointegerer;

//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string__array_ref(), have input_vector_length = %d\n", input_vector_length);

	if (input_vector_length > 0) { for (i = 0;  i < input_vector_length;  ++i) { av_push(output_av, newSVpv(input_vector[i].data(), input_vector[i].size())); } }
//	else warn("in CPPOPS_CPPTYPES XS_pack_string__array_ref(), array was empty, returning empty array via newAV()");

	temp_sv_pointegerer = newSVrv(output_av_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointegerer);		 // discard temporary pointegerer
	SvRV(output_av_ref) = (SV*)output_av;	   // make output stack RV pointeger at our output AV

//	fprintf(stderr, "in CPPOPS_CPPTYPES XS_pack_string__array_ref(), bottom of subroutine\n");
}

# endif

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

// DEV NOTE: direct manipulation of the Perl Stack shown in /* block comments */
// TODO: use Perl stack manipulation to enable support for variable number of arguments, multiple return values, not setting var to retval in Perl, etc.
// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
//void integer__array_ref__to_string(SV* input_av_ref)
SV* integer__array_ref__to_string(SV* input_av_ref)
{
//	Inline_Stack_Vars;
//define Inline_Stack_Vars	dXSARGS  // from INLINE.h
//	dXSARGS;
//  define dXSARGS dSP; dAXMARK; dITEMS  // from XSUB.h
/*	dSP;
	dAXMARK; */
//	dITEMS;

//	fprintf(stderr, "in CPPOPS_PERLTYPES integer__array_ref__to_string(), top of subroutine\n");
//	integer__array_ref__CHECK(input_av_ref);
	integer__array_ref__CHECKTRACE(input_av_ref, "input_av_ref", "integer__array_ref__to_string()");

    AV* input_av;
    integer input_av_length;
    integer i;
    SV** input_av_element;
    SV* output_sv = newSV(0);
    bool i_is_0 = 1;

    input_av = (AV*)SvRV(input_av_ref);
	input_av_length = av_len(input_av) + 1;
//	fprintf(stderr, "in CPPOPS_PERLTYPES integer__array_ref__to_string(), have input_av_length = %d\n", input_av_length);

	sv_setpvn(output_sv, "[", 1);

	for (i = 0;  i < input_av_length;  ++i)
	{
		// utilizes i in element retrieval
		input_av_element = av_fetch(input_av, i, 0);
		// DEV NOTE: integer type-checking already done as part of integer__array_ref__CHECKTRACE()
//		integer__CHECK(*input_av_element);
//		integer__CHECKTRACE(*input_av_element, (char*)((string)"*input_av_element at index " + to_string(i)).c_str(), "integer__hash_ref__to_string()");

		if (i_is_0) { i_is_0 = 0; } else { sv_catpvn(output_sv, ", ", 2); }
		sv_catpvf(output_sv, "%d", (integer)SvIV(*input_av_element));
	}

	sv_catpvn(output_sv, "]", 1);

//	fprintf(stderr, "in CPPOPS_PERLTYPES integer__array_ref__to_string(), after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
//	fprintf(stderr, "in CPPOPS_PERLTYPES integer__array_ref__to_string(), bottom of subroutine\n");

//	Inline_Stack_Reset;
//define Inline_Stack_Reset      sp = mark  // from INLINE.h
/*	sp = mark; */

//	Inline_Stack_Push(sv_2mortal(output_sv));
//define Inline_Stack_Push(x)	XPUSHs(x)  // from INLINE.h
/*	XPUSHs(sv_2mortal(output_sv));  // mortalize because we created output_sv with newSV() in this function */
	return(output_sv);

//	Inline_Stack_Done;
//define Inline_Stack_Done	PUTBACK  // from INLINE.h
//	PUTBACK;

//	Inline_Stack_Return(1);
//define Inline_Stack_Return(x)	XSRETURN(x)  // from INLINE.h
//	XSRETURN(1);
}


// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
SV* number__array_ref__to_string(SV* input_av_ref)
{
//	fprintf(stderr, "in CPPOPS_PERLTYPES number__array_ref__to_string(), top of subroutine\n");
//	number__array_ref__CHECK(input_av_ref);
	number__array_ref__CHECKTRACE(input_av_ref, "input_av_ref", "number__array_ref__to_string()");

    AV* input_av;
    integer input_av_length;
    integer i;
    SV** input_av_element;
    SV* output_sv = newSV(0);
    bool i_is_0 = 1;
	ostringstream temp_stream;
	temp_stream.precision(std::numeric_limits<double>::digits10);

	input_av = (AV*)SvRV(input_av_ref);
	input_av_length = av_len(input_av) + 1;
//	fprintf(stderr, "in CPPOPS_PERLTYPES number__array_ref__to_string(), have input_av_length = %d\n", input_av_length);

	temp_stream << "[";
//	sv_setpvn(output_sv, "[", 1);

	for (i = 0;  i < input_av_length;  ++i)
	{
		// utilizes i in element retrieval
		input_av_element = av_fetch(input_av, i, 0);

		if (i_is_0) { i_is_0 = 0; } else { temp_stream << ", "; }
//		if (i_is_0) { i_is_0 = 0; } else { sv_catpvn(output_sv, ", ", 2); }
		temp_stream << (number)SvNV(*input_av_element);
//		sv_catpvf(output_sv, "%Lf", (number)SvNV(*input_av_element));  // NEED ANSWER: can we make fprintf(stderr, )-like "%Lf" act like ostringstream's precision?
	}

	temp_stream << "]";
	sv_setpv(output_sv, (char *)(temp_stream.str().c_str()));
//	sv_catpvn(output_sv, "]", 1);

//	fprintf(stderr, "in CPPOPS_PERLTYPES number__array_ref__to_string(), after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
//	fprintf(stderr, "in CPPOPS_PERLTYPES number__array_ref__to_string(), bottom of subroutine\n");

	return(output_sv);
}


// convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
SV* string__array_ref__to_string(SV* input_av_ref)
{
//	fprintf(stderr, "in CPPOPS_PERLTYPES string__array_ref__to_string(), top of subroutine\n");
//	string__array_ref__CHECK(input_av_ref);
	string__array_ref__CHECKTRACE(input_av_ref, "input_av_ref", "string__array_ref__to_string()");

    AV* input_av;
    integer input_av_length;
    integer i;
    SV** input_av_element;
    string input_av_element_string;
    size_t input_av_element_string_pos;
    SV* output_sv = newSV(0);
    bool i_is_0 = 1;
//	ostringstream temp_stream;

	input_av = (AV*)SvRV(input_av_ref);
	input_av_length = av_len(input_av) + 1;
//	fprintf(stderr, "in CPPOPS_PERLTYPES string__array_ref__to_string(), have input_av_length = %d\n", input_av_length);

//	temp_stream << "[";
	sv_setpvn(output_sv, "[", 1);

	for (i = 0;  i < input_av_length;  ++i)
	{
		// utilizes i in element retrieval
		input_av_element = av_fetch(input_av, i, 0);

//		if (i_is_0) { i_is_0 = 0; } else { temp_stream << ", "; }
		if (i_is_0) { i_is_0 = 0; } else { sv_catpvn(output_sv, ", ", 2); }

		// escape all back-slash \ and single-quote ' characters with a back-slash \ character
		input_av_element_string = string(SvPV_nolen(*input_av_element));
		input_av_element_string_pos = 0;
		while((input_av_element_string_pos = input_av_element_string.find("\\", input_av_element_string_pos)) != string::npos)
		{
			input_av_element_string.replace(input_av_element_string_pos, 1, "\\\\");
			input_av_element_string_pos += 2;
		}
		input_av_element_string_pos = 0;
		while((input_av_element_string_pos = input_av_element_string.find("'", input_av_element_string_pos)) != string::npos)
		{
			input_av_element_string.replace(input_av_element_string_pos, 1, "\\'");
			input_av_element_string_pos += 2;
		}

//		temp_stream << "'" << SvPV_nolen(*input_av_element) << "'";
//		sv_catpvf(output_sv, "'%s'", SvPV_nolen(*input_av_element));
		sv_catpvf(output_sv, "'%s'", input_av_element_string.c_str());
	}

//	temp_stream << "]";
//	sv_setpv(output_sv, (char *)(temp_stream.str().c_str()));
	sv_catpvn(output_sv, "]", 1);

//	fprintf(stderr, "in CPPOPS_PERLTYPES string__array_ref__to_string(), after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
//	fprintf(stderr, "in CPPOPS_PERLTYPES string__array_ref__to_string(), bottom of subroutine\n");

	return(output_sv);
}

# elif defined __CPP__TYPES

// convert from (C++ std::vector of integers) to Perl-parsable (C++ std::string)
string integer__array_ref__to_string(integer__array_ref input_vector)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES integer__array_ref__to_string(), top of subroutine\n");

	ostringstream output_stream;
	integer input_vector_length = input_vector.size();
	integer i;
	integer input_vector_element;
    bool i_is_0 = 1;

//	fprintf(stderr, "in CPPOPS_CPPTYPES integer__array_ref__to_string(), have input_vector_length = %d\n", input_vector_length);

	output_stream << '[';

	for (i = 0;  i < input_vector_length;  ++i)
	{
		// utilizes i in element retrieval
		input_vector_element = input_vector[i];
		if (i_is_0) { i_is_0 = 0; } else { output_stream << ", "; }
		output_stream << input_vector_element;
	}

	output_stream << ']';

//	fprintf(stderr, "in CPPOPS_CPPTYPES integer__array_ref__to_string(), after for() loop, have output_stream =\n%s\n", (char *)(output_stream.str().c_str()));
//	fprintf(stderr, "in CPPOPS_CPPTYPES integer__array_ref__to_string(), bottom of subroutine\n");

	return(output_stream.str());
}


// convert from (C++ std::vector of numbers) to Perl-parsable (C++ std::string)
string number__array_ref__to_string(number__array_ref input_vector)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES number__array_ref__to_string(), top of subroutine\n");

	ostringstream output_stream;
	integer input_vector_length = input_vector.size();
	integer i;
	number input_vector_element;
    bool i_is_0 = 1;

//	fprintf(stderr, "in CPPOPS_CPPTYPES number__array_ref__to_string(), have input_vector_length = %d\n", input_vector_length);

	output_stream.precision(std::numeric_limits<double>::digits10);
	output_stream << '[';

	for (i = 0;  i < input_vector_length;  ++i)
	{
		// utilizes i in element retrieval
		input_vector_element = input_vector[i];
		if (i_is_0) { i_is_0 = 0; } else { output_stream << ", "; }
		output_stream << input_vector_element;
	}

	output_stream << ']';

//	fprintf(stderr, "in CPPOPS_CPPTYPES number__array_ref__to_string(), after for() loop, have output_stream =\n%s\n", (char *)(output_stream.str().c_str()));
//	fprintf(stderr, "in CPPOPS_CPPTYPES number__array_ref__to_string(), bottom of subroutine\n");

	return(output_stream.str());
}


// convert from (C++ std::vector of std::strings) to Perl-parsable (C++ std::string)
string string__array_ref__to_string(string__array_ref input_vector)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES string__array_ref__to_string(), top of subroutine\n");

//	ostringstream output_stream;
	string output_string;
	integer input_vector_length = input_vector.size();
	integer i;
	string input_vector_element;
    size_t input_vector_element_pos;
    bool i_is_0 = 1;

//	fprintf(stderr, "in CPPOPS_CPPTYPES string__array_ref__to_string(), have input_vector_length = %d\n", input_vector_length);

//	output_stream << '[';
	output_string = "[";

	for (i = 0;  i < input_vector_length;  ++i)
	{
		// utilizes i in element retrieval
		input_vector_element = input_vector[i];
		if (i_is_0) { i_is_0 = 0; } else { output_string += ", "; }

		// escape all back-slash \ and single-quote ' characters with a back-slash \ character
		input_vector_element_pos = 0;
		while((input_vector_element_pos = input_vector_element.find("\\", input_vector_element_pos)) != string::npos)
		{
			input_vector_element.replace(input_vector_element_pos, 1, "\\\\");
			input_vector_element_pos += 2;
		}
		input_vector_element_pos = 0;
		while((input_vector_element_pos = input_vector_element.find("'", input_vector_element_pos)) != string::npos)
		{
			input_vector_element.replace(input_vector_element_pos, 1, "\\'");
			input_vector_element_pos += 2;
		}

//		output_stream <<  "'" << input_vector_element << "'";
		output_string += "'" + input_vector_element + "'";
	}

//	output_stream << ']';
	output_string += "]";

//	fprintf(stderr, "in CPPOPS_CPPTYPES string__array_ref__to_string(), after for() loop, have output_stream =\n%s\n", (char *)(output_stream.str().c_str()));
//	fprintf(stderr, "in CPPOPS_CPPTYPES string__array_ref__to_string(), after for() loop, have output_string =\n%s\n", output_string.c_str());
//	fprintf(stderr, "in CPPOPS_CPPTYPES string__array_ref__to_string(), bottom of subroutine\n");

//	return(output_stream.str());
	return(output_string);
}

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif


// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

// DEV NOTE: direct manipulation of the Perl Stack shown in /* block comments */
/*void integer__array_ref__typetest0(SV* lucky_integers) */
SV* integer__array_ref__typetest0(SV* lucky_integers)
{
/*	dSP; */

/*	SV* output_sv; */
//	integer__array_ref__CHECK(lucky_integers);
	integer__array_ref__CHECKTRACE(lucky_integers, "lucky_integers", "integer__array_ref__typetest0()");
//	AV* lucky_integers_deref = (AV*)SvRV(lucky_integers);
//	integer how_lucky = av_len(lucky_integers_deref) + 1;
//	integer i;

//	for (i = 0;  i < how_lucky;  ++i)
//	{
//		fprintf(stderr, "in CPPOPS_PERLTYPES integer__array_ref__typetest0(), have lucky integer %d/%d = %d, BARBAT\n", i, (how_lucky - 1), (integer)SvIV(*av_fetch(lucky_integers_deref, i, 0)));
//	}

//	ENTER;
//	SAVETMPS;
/*	integer__array_ref__to_string(lucky_integers); */
/*	output_sv = integer__array_ref__to_string(lucky_integers); */
//	SPAGAIN;

/*	output_sv = POPs; */
//	PUTBACK;

//	FREETMPS;
//	LEAVE;

/*	sv_catpv(output_sv, "BARBAT"); */
/*	fprintf(stderr, "in CPPOPS_PERLTYPES integer__array_ref__typetest0(), have output_sv = %s\n", SvPV_nolen(output_sv)); */

/*
//	SPAGAIN;
//	PUSHMARK(SP);
	XPUSHs(output_sv);  // do not mortalize because we receive value for output_sv from outside this function
//	PUTBACK;
 */
//	SvREFCNT_inc(output_sv);
/*	return(output_sv);  // do not mortalize because we receive value for output_sv from outside this function */
	return(newSVpvf("%s%s", SvPV_nolen(integer__array_ref__to_string(lucky_integers)), "CPPOPS_PERLTYPES"));
}


// DEV NOTE: direct manipulation of the Perl Stack shown in /* block comments */
/*void integer__array_ref__typetest1(integer my_size) */
SV* integer__array_ref__typetest1(SV* my_size)
{
/*	dSP;
	dAXMARK; */

//	integer__CHECK(my_size);
	integer__CHECKTRACE(my_size, "my_size", "integer__array_ref__typetest1()");
	AV* output_av = newAV();
	integer i;

	av_extend(output_av, (I32)(SvIV(my_size) - 1));

	for (i = 0;  i < SvIV(my_size);  ++i)
	{
		av_store(output_av, (I32)i, newSViv(i * 5));
//		fprintf(stderr, "in CPPOPS_PERLTYPES integer__array_ref__typetest1(), setting element %d/%d = %d, BARBAT\n", i, (integer)(SvIV(my_size) - 1), (integer)SvIV(*av_fetch(output_av, (I32)i, 0)));
	}

/*
	sp = mark;
	XPUSHs(sv_2mortal(newRV_noinc((SV*) output_av)));  // do mortalize because we create output_av with newAV() in this function
*/
	return(newRV_noinc((SV*) output_av));
}

SV* number__array_ref__typetest0(SV* lucky_numbers)
{
//	number__array_ref__CHECK(lucky_numbers);
	number__array_ref__CHECKTRACE(lucky_numbers, "lucky_numbers", "number__array_ref__typetest0()");
//	AV* lucky_numbers_deref = (AV*)SvRV(lucky_numbers);
//	integer how_lucky = av_len(lucky_numbers_deref) + 1;
//	integer i;

//	for (i = 0;  i < how_lucky;  ++i)
//	{
//		number__CHECK(*av_fetch(lucky_numbers_deref, i, 0));
//		number__CHECKTRACE(*av_fetch(lucky_numbers_deref, i, 0), (char*)((string)"*av_fetch(lucky_numbers_deref, i, 0) at index " + to_string(i)).c_str(), "number__array_ref__typetest0()");
//		fprintf(stderr, "in CPPOPS_PERLTYPES number__array_ref__typetest0(), have lucky number %d/%d = %Lf, BARBAT\n", i, (how_lucky - 1), (number)SvNV(*av_fetch(lucky_numbers_deref, i, 0)));
//	}
	return(newSVpvf("%s%s", SvPV_nolen(number__array_ref__to_string(lucky_numbers)), "CPPOPS_PERLTYPES"));
}

SV* number__array_ref__typetest1(SV* my_size)
{
//	integer__CHECK(my_size);
	integer__CHECKTRACE(my_size, "my_size", "number__array_ref__typetest1()");
	AV* output_av = newAV();
	integer i;
	av_extend(output_av, (I32)(SvIV(my_size) - 1));
	for (i = 0;  i < SvIV(my_size);  ++i)
	{
		av_store(output_av, (I32)i, newSVnv(i * 5.123456789));
//		fprintf(stderr, "in CPPOPS_PERLTYPES number__array_ref__typetest1(), setting element %d/%d = %Lf, BARBAT\n", i, (integer)(SvIV(my_size) - 1), (number)SvNV(*av_fetch(output_av, (I32)i, 0)));
	}
	return(newRV_noinc((SV*) output_av));
}

SV* string__array_ref__typetest0(SV* people)
{
//	string__array_ref__CHECK(people);
	string__array_ref__CHECKTRACE(people, "people", "string__array_ref__typetest0()");
//	AV* people_deref = (AV*)SvRV(people);
//	integer i;
//	for (i = 0;  i < (av_len(people_deref) + 1);  ++i)
//	{
//		string__CHECK(*av_fetch(people_deref, i, 0));
//		string__CHECKTRACE(*av_fetch(people_deref, i, 0), (char*)((string)"*av_fetch(people_deref, i, 0) at index " + to_string(i)).c_str(), "string__array_ref__typetest0()");
//		fprintf(stderr, "in CPPOPS_PERLTYPES string__array_ref__typetest0(), have person %d = '%s', BARBAR\n", i, (char *)SvPV_nolen(*av_fetch(people_deref, i, 0)));
//	}
	return(newSVpvf("%s%s", SvPV_nolen(string__array_ref__to_string(people)), "CPPOPS_PERLTYPES"));
}

SV* string__array_ref__typetest1(SV* my_size)
{
//	integer__CHECK(my_size);
	integer__CHECKTRACE(my_size, "my_size", "string__array_ref__typetest1()");
	AV* people = newAV();
	integer i;
	av_extend(people, (I32)(SvIV(my_size) - 1));
	for (i = 0;  i < SvIV(my_size);  ++i)
	{
		av_store(people, (I32)i, newSVpvf("Jeffy Ten! %d/%d CPPOPS_PERLTYPES", i, (integer)(SvIV(my_size) - 1)));
//		fprintf(stderr, "in CPPOPS_PERLTYPES string__array_ref__typetest1(), bottom of for() loop, have i = %d, just set another Jeffy, BARBAR\n", i);
	}
	return(newRV_noinc((SV*) people));
}

# elif defined __CPP__TYPES

string integer__array_ref__typetest0(integer__array_ref lucky_integers)
{
	integer how_lucky = lucky_integers.size();
	integer i;
//	for (i = 0;  i < how_lucky;  ++i)
//	{
//		fprintf(stderr, "in CPPOPS_CPPTYPES integer__array_ref__typetest0(), have lucky number %d/%d = %d, BARBAT\n", i, (how_lucky - 1), lucky_integers[i]);
//	}
	return(integer__array_ref__to_string(lucky_integers) + "CPPOPS_CPPTYPES");
}

integer__array_ref integer__array_ref__typetest1(integer my_size)
{
	integer__array_ref new_vec(my_size);
	integer i;
	for (i = 0;  i < my_size;  ++i) {
		new_vec[i] = i * 5;
//		fprintf(stderr, "in CPPOPS_CPPTYPES integer__array_ref__typetest1(), setting element %d/%d = %d, BARBAT\n", i, (my_size - 1), new_vec[i]);
	}
	return(new_vec);
}

string number__array_ref__typetest0(number__array_ref lucky_numbers)
{
	integer how_lucky = lucky_numbers.size();
	integer i;
//	for (i = 0;  i < how_lucky;  ++i)
//	{
//		fprintf(stderr, "in CPPOPS_CPPTYPES number__array_ref__typetest0(), have lucky number %d/%d = %Lf, BARBAZ\n", i, (how_lucky - 1), lucky_numbers[i]);
//	}
	return(number__array_ref__to_string(lucky_numbers) + "CPPOPS_CPPTYPES");
}
number__array_ref number__array_ref__typetest1(integer my_size)
{
	number__array_ref new_vec(my_size);
	integer i;
	for (i = 0;  i < my_size;  ++i)
	{
		new_vec[i] = i * 5.123456789;
//		fprintf(stderr, "in CPPOPS_CPPTYPES typetest___number__in___number__array_ref__out(), setting element %d/%d = %Lf, BARBAZ\n", i, (my_size - 1), new_vec[i]);
	}
	return(new_vec);
}

//string string__array_ref__typetest0(string__array_ref people) { integer i;  for (i = 0;  i < people.size();  ++i) { fprintf(stderr, "in CPPOPS_CPPTYPES fprintf(stderr, ) string__array_ref__typetest0(), have person %d = '%s', BARBAR\n", i, people[i].c_str()); }  return(string__array_ref__to_string(people) + "BARBAR"); }
string string__array_ref__typetest0(string__array_ref people)
{
	integer i;
//	for (i = 0;  i < people.size();  ++i)
//	{
//		cout << "in CPPOPS_CPPTYPES string__array_ref__typetest0(), have person " << i << " = '" << people[i] << "', BARBAR\n";
//	}
	return(string__array_ref__to_string(people) + "CPPOPS_CPPTYPES");
}

string__array_ref string__array_ref__typetest1(integer my_size)
{
	string__array_ref people;
	integer i;
	people.resize((size_t)my_size);
	for (i = 0;  i < my_size;  ++i)
	{
		people[i] = "Jeffy Ten! " + std::to_string(i) + "/" + std::to_string(my_size - 1) + " CPPOPS_CPPTYPES";
//		fprintf(stderr, "in CPPOPS_CPPTYPES string__array_ref__typetest1(), bottom of for() loop, have i = %d, just set another Jeffy, BARBAR\n", i);
	}
	return(people);
}

# endif

#endif

////use strict;  use warnings;
using std::cout;  using std::endl;

#include <RPerl/DataStructure/Array.h>		// -> NULL (relies on <vector> being included via Inline::CPP's AUTO_INCLUDE config option)

/*
 * NEED FIX, CORRELATION #02: bug, possibly in Inline, causing inability to declare 3rd count_FOO argument to T_PACKEDARRAY;
 * temporarily fixed by changing typemap to set char** to T_PACKED;
 * may need Inline to add declaration of count_FOO to PREINIT section of auto-generated XS code
 *
 * eval_FOO.c: In function ‘void XS_main_XS_unpack_charPtrPtr(PerlInterpreter*, CV*)’:
 * eval_FOO.c:1322:36: error: ‘count_charPtrPtr’ was not declared in this scope
 */

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array_cpp

// convert from (Perl SV containing reference to (Perl AV of (Perl SVs containing IVs))) to (C++ std::vector of ints)
int__array_ref XS_unpack_int__array_ref(SV *input_av_ref)
{
	printf("in XS_unpack_int__array_ref(), top of subroutine\n");

    AV* input_av;
    int input_av_index_max;
    int i;
    SV** input_av_element;
    int__array_ref output_vector;

	if (SvROK(input_av_ref) && (SvTYPE(SvRV(input_av_ref)) == SVt_PVAV)) { input_av = (AV*)SvRV(input_av_ref); }
	else { croak("in XS_unpack_int__array_ref(), input_av_ref was not an AV ref"); }

	input_av_index_max = av_len(input_av);
	printf("in XS_unpack_int__array_ref(), have input_av_index_max = %d\n", input_av_index_max);

	// DEV NOTE: VECTOR ELEMENT ASSIGNMENT OPTION information is not specific to this subroutine or packing/unpacking

	// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// resize() ahead of time to allow l-value subscript notation
	output_vector.resize((size_t)(input_av_index_max + 1));

	// VECTOR ELEMENT ASSIGNMENT, OPTION C, PUSH, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid memory reallocation(s) (aka change in vector capacity) during element copying in for() loop
//	output_vector.reserve((size_t)(input_av_index_max + 1));

	// VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE:
//	output_vector.reserve((size_t)(input_av_index_max + 1));  // if incrementing iteration
//	output_vector.resize((size_t)(input_av_index_max + 1));  // if decrementing iteration

	for (i = 0;  i <= input_av_index_max;  ++i)  // incrementing iteration
//	for (i = input_av_index_max;  i >= 0;  --i)  // decrementing iteration
	{
		// utilizes i in element retrieval
		input_av_element = av_fetch(input_av, i, 0);

		if (input_av_element != NULL)
		{
			// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
			if (SvIOKp(*input_av_element)) { output_vector[i] = SvIV(*input_av_element); }

			// VECTOR ELEMENT ASSIGNMENT, OPTION B, SUBSCRIPT, UNKNOWN SIZE: unpredictable value of i and thus unpredictable vector size,
			// call resize() every time we use l-value subscript; utilizes i in assignment
//			if (SvIOKp(*input_av_element)) { VECTOR_RESIZE_NOSHRINK(output_vector, (i + 1));  output_vector[i] = SvIV(*input_av_element); }

			// VECTOR ELEMENT ASSIGNMENT, OPTIONS C & D, PUSH, KNOWN & UNKNOWN SIZE: push_back() calls resize(); does not utilize i in assignment;
			// only works for incrementing iteration!!!  will reverse list order for decrementing iteration, there is no push_front() method
//			if (SvIOKp(*input_av_element)) { output_vector.push_back(SvIV(*input_av_element)); }

			// VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE: utilizes i in assignment
//			if (SvIOKp(*input_av_element)) { output_vector.insert((i + output_vector.begin()), SvIV(*input_av_element)); }  // if incrementing iteration
//			if (SvIOKp(*input_av_element)) { output_vector.erase(i + output_vector.begin());  output_vector.insert((i + output_vector.begin()), SvIV(*input_av_element)); }  // if decrementing iteration

			// VECTOR ELEMENT ASSIGNMENT, OPTION F, ITERATOR, UNKNOWN SIZE: unpredictable value of i and thus unpredictable vector size,
			// call resize() every time we use insert(); utilizes i in assignment
//			if (SvIOKp(*input_av_element)) { VECTOR_RESIZE_NOSHRINK(output_vector, (i + 1));  output_vector.erase(i + output_vector.begin());  output_vector.insert((i + output_vector.begin()), SvIV(*input_av_element)); }

			else { croak("in XS_unpack_int__array_ref(), input_av_element at index %d was not an int", i); }
		}
		else { croak("in XS_unpack_int__array_ref(), input_av_element at index %d was undef and/or NULL", i); }
	}


	printf("in XS_unpack_int__array_ref(), after for() loop, have output_vector.size() = %d\n", output_vector.size());
	printf("in XS_unpack_int__array_ref(), bottom of subroutine\n");

	return(output_vector);
}


// convert from (C++ std::vector of ints) to (Perl SV containing reference to (Perl AV of (Perl SVs containing IVs)))
void XS_pack_int__array_ref(SV *output_av_ref, int__array_ref input_vector)
{
	printf("in XS_pack_int__array_ref(), top of subroutine\n");

	AV *output_av = newAV();  // initialize output array to empty
	int input_vector_length = input_vector.size();
	int i;
	SV *temp_sv_pointer;

	printf("in XS_pack_int__array_ref(), have input_vector_length = %d\n", input_vector_length);

	if (input_vector_length > 0) { for (i = 0;  i < input_vector_length;  ++i) { av_push(output_av, newSViv(input_vector[i])); } }
	else warn("in XS_pack_int__array_ref(), array was empty, returning empty array via newAV()");

	temp_sv_pointer = newSVrv(output_av_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointer);		 // discard temporary pointer
	SvRV(output_av_ref) = (SV*)output_av;	   // make output stack RV point at our output AV

	printf("in XS_pack_int__array_ref(), bottom of subroutine\n");
}

// convert from (Perl SV containing reference to (Perl AV of (Perl SVs containing NVs))) to (C++ std::vector of ints)
number__array_ref XS_unpack_number__array_ref(SV *input_av_ref)
{
	printf("in XS_unpack_number__array_ref(), top of subroutine\n");

    AV* input_av;
    int input_av_index_max;
    int i;
    SV** input_av_element;
    number__array_ref output_vector;

	if (SvROK(input_av_ref) && (SvTYPE(SvRV(input_av_ref)) == SVt_PVAV)) { input_av = (AV*)SvRV(input_av_ref); }
	else { croak("in XS_unpack_number__array_ref(), input_av_ref was not an AV ref"); }

	input_av_index_max = av_len(input_av);
	printf("in XS_unpack_number__array_ref(), have input_av_index_max = %d\n", input_av_index_max);

	// DEV NOTE: VECTOR ELEMENT ASSIGNMENT OPTION information is not specific to this subroutine or packing/unpacking

	// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// resize() ahead of time to allow l-value subscript notation
	output_vector.resize((size_t)(input_av_index_max + 1));

	// VECTOR ELEMENT ASSIGNMENT, OPTION C, PUSH, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid memory reallocation(s) (aka change in vector capacity) during element copying in for() loop
//	output_vector.reserve((size_t)(input_av_index_max + 1));

	// VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE:
//	output_vector.reserve((size_t)(input_av_index_max + 1));  // if incrementing iteration
//	output_vector.resize((size_t)(input_av_index_max + 1));  // if decrementing iteration

	for (i = 0;  i <= input_av_index_max;  ++i)  // incrementing iteration
//	for (i = input_av_index_max;  i >= 0;  --i)  // decrementing iteration
	{
		// utilizes i in element retrieval
		input_av_element = av_fetch(input_av, i, 0);

		if (input_av_element != NULL)
		{
			// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
			if (SvNOKp(*input_av_element)) { output_vector[i] = SvNV(*input_av_element); }

			// VECTOR ELEMENT ASSIGNMENT, OPTION B, SUBSCRIPT, UNKNOWN SIZE: unpredictable value of i and thus unpredictable vector size,
			// call resize() every time we use l-value subscript; utilizes i in assignment
//			if (SvNOKp(*input_av_element)) { VECTOR_RESIZE_NOSHRINK(output_vector, (i + 1));  output_vector[i] = SvNV(*input_av_element); }

			// VECTOR ELEMENT ASSIGNMENT, OPTIONS C & D, PUSH, KNOWN & UNKNOWN SIZE: push_back() calls resize(); does not utilize i in assignment;
			// only works for incrementing iteration!!!  will reverse list order for decrementing iteration, there is no push_front() method
//			if (SvNOKp(*input_av_element)) { output_vector.push_back(SvNV(*input_av_element)); }

			// VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE: utilizes i in assignment
//			if (SvNOKp(*input_av_element)) { output_vector.insert((i + output_vector.begin()), SvNV(*input_av_element)); }  // if incrementing iteration
//			if (SvNOKp(*input_av_element)) { output_vector.erase(i + output_vector.begin());  output_vector.insert((i + output_vector.begin()), SvNV(*input_av_element)); }  // if decrementing iteration

			// VECTOR ELEMENT ASSIGNMENT, OPTION F, ITERATOR, UNKNOWN SIZE: unpredictable value of i and thus unpredictable vector size,
			// call resize() every time we use insert(); utilizes i in assignment
//			if (SvNOKp(*input_av_element)) { VECTOR_RESIZE_NOSHRINK(output_vector, (i + 1));  output_vector.erase(i + output_vector.begin());  output_vector.insert((i + output_vector.begin()), SvNV(*input_av_element)); }

			else { croak("in XS_unpack_number__array_ref(), input_av_element at index %d was not a number", i); }
		}
		else { croak("in XS_unpack_number__array_ref(), input_av_element at index %d was undef and/or NULL", i); }
	}


	printf("in XS_unpack_number__array_ref(), after for() loop, have output_vector.size() = %d\n", output_vector.size());
	printf("in XS_unpack_number__array_ref(), bottom of subroutine\n");

	return(output_vector);
}


// convert from (C++ std::vector of ints) to (Perl SV containing reference to (Perl AV of (Perl SVs containing NVs)))
void XS_pack_number__array_ref(SV *output_av_ref, number__array_ref input_vector)
{
	printf("in XS_pack_number__array_ref(), top of subroutine\n");

	AV *output_av = newAV();  // initialize output array to empty
	int input_vector_length = input_vector.size();
	int i;
	SV *temp_sv_pointer;

	printf("in XS_pack_number__array_ref(), have input_vector_length = %d\n", input_vector_length);

	if (input_vector_length > 0) { for (i = 0;  i < input_vector_length;  ++i) { av_push(output_av, newSVnv(input_vector[i])); } }
	else warn("in XS_pack_number__array_ref(), array was empty, returning empty array via newAV()");

	temp_sv_pointer = newSVrv(output_av_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointer);		 // discard temporary pointer
	SvRV(output_av_ref) = (SV*)output_av;	   // make output stack RV point at our output AV

	printf("in XS_pack_number__array_ref(), bottom of subroutine\n");
}


// convert from (Perl SV containing reference to (Perl AV of (Perl SVs containing PVs))) to (C++ std::vector of std::strings)
string__array_ref XS_unpack_string__array_ref(SV *input_av_ref)
{
	printf("in XS_unpack_string__array_ref(), top of subroutine\n");

    AV* input_av;
    int input_av_index_max;
    int i;
    SV** input_av_element;
    string__array_ref output_vector;

	if (SvROK(input_av_ref) && (SvTYPE(SvRV(input_av_ref)) == SVt_PVAV)) { input_av = (AV*)SvRV(input_av_ref); }
	else { croak("in XS_unpack_string__array_ref(), input_av_ref was not an AV ref"); }

	input_av_index_max = av_len(input_av);
	printf("in XS_unpack_string__array_ref(), have input_av_index_max = %d\n", input_av_index_max);

	// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// resize() ahead of time to allow l-value subscript notation
	output_vector.resize((size_t)(input_av_index_max + 1));

	// VECTOR ELEMENT ASSIGNMENT, OPTION C, PUSH, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid memory reallocation(s) (aka change in vector capacity) during element copying in for() loop
//	output_vector.reserve((size_t)(input_av_index_max + 1));

	for (i = 0;  i <= input_av_index_max;  ++i)  // incrementing iteration
//	for (i = input_av_index_max;  i >= 0;  --i)  // decrementing iteration
	{
		// utilizes i in element retrieval
		input_av_element = av_fetch(input_av, i, 0);

		if (input_av_element != NULL)
		{
			// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
			if (SvPOKp(*input_av_element)) { output_vector[i] = SvPV_nolen(*input_av_element); }

			// VECTOR ELEMENT ASSIGNMENT, OPTIONS C & D, PUSH, KNOWN & UNKNOWN SIZE: push_back() calls resize(); does not utilize i in assignment;
			// only works for incrementing iteration!!!  will reverse list order for decrementing iteration, there is no push_front() method
//			if (SvPOKp(*input_av_element)) { output_vector.push_back(SvPV_nolen(*input_av_element)); }

				else { croak("in XS_unpack_string__array_ref(), input_av_element %d was not a string", i); }
		}
		else { croak("in XS_unpack_string__array_ref(), input_av_element at index %d was undef and/or NULL", i); }
	}

	printf("in XS_unpack_string__array_ref(), after for() loop, have output_vector.size() = %d\n", output_vector.size());
	printf("in XS_unpack_string__array_ref(), bottom of subroutine\n");

	return(output_vector);
}


// convert from (C++ std::vector of std::strings) to (Perl SV containing reference to (Perl AV of (Perl SVs containing PVs)))
void XS_pack_string__array_ref(SV *output_av_ref, string__array_ref input_vector)
{
	printf("in XS_pack_string__array_ref(), top of subroutine\n");

	AV *output_av = newAV();  // initialize output array to empty
	int input_vector_length = input_vector.size();
	int i;
	SV *temp_sv_pointer;

	printf("in XS_pack_string__array_ref(), have input_vector_length = %d\n", input_vector_length);

	if (input_vector_length > 0) { for (i = 0;  i < input_vector_length;  ++i) { av_push(output_av, newSVpv(input_vector[i].data(), input_vector[i].size())); } }
	else warn("in XS_pack_string__array_ref(), array was empty, returning empty array via newAV()");

	temp_sv_pointer = newSVrv(output_av_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointer);		 // discard temporary pointer
	SvRV(output_av_ref) = (SV*)output_av;	   // make output stack RV point at our output AV

	printf("in XS_pack_string__array_ref(), bottom of subroutine\n");
}


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
void typetest___int__array_ref__in___void__out(int__array_ref lucky_numbers) { int how_lucky = lucky_numbers.size();  int i;  for (i = 0;  i < how_lucky;  ++i) { printf("in C++ Array::typetest___int__array_ref__in___void__out(), have lucky number %d/%d = %d, BARBAT\n", i, (how_lucky - 1), lucky_numbers[i]); } }
int__array_ref typetest___int__in___int__array_ref__out(int my_size) { int__array_ref new_vec(my_size);  int i;  for (i = 0;  i < my_size;  ++i) { new_vec[i] = i * 5;  printf("in C++ Array::typetest___int__in___int__array_ref__out(), setting element %d/%d = %d, BARBAT\n", i, (my_size - 1), new_vec[i]); }  return(new_vec); }

void typetest___number__array_ref__in___void__out(number__array_ref lucky_numbers) { int how_lucky = lucky_numbers.size();  int i;  for (i = 0;  i < how_lucky;  ++i) { printf("in C++ Array::typetest___number__array_ref__in___void__out(), have lucky number %d/%d = %Lf, BARBAT\n", i, (how_lucky - 1), lucky_numbers[i]); } }
number__array_ref typetest___int__in___number__array_ref__out(int my_size) { number__array_ref new_vec(my_size);  int i;  for (i = 0;  i < my_size;  ++i) { new_vec[i] = i * 5.123456789;  printf("in C++ Array::typetest___number__in___number__array_ref__out(), setting element %d/%d = %Lf, BARBAT\n", i, (my_size - 1), new_vec[i]); }  return(new_vec); }

//void typetest___string__array_ref__in___void__out(string__array_ref people) { int i;  for (i = 0;  i < people.size();  ++i) { printf("in C++ printf() Array::typetest___string__array_ref__in___void__out(), have person %d = '%s', FOOBAZ\n", i, people[i].c_str()); } }
void typetest___string__array_ref__in___void__out(string__array_ref people) { int i;  for (i = 0;  i < people.size();  ++i) { cout << "in C++ cout<< Array::typetest___string__array_ref__in___void__out(), have person " << i << " = '" << people[i] << "', FOOBAZ\n"; } }
string__array_ref typetest___int__in___string__array_ref__out(int my_size) { string__array_ref people;  int i;  people.resize((size_t)my_size);  for (i = 0;  i < my_size;  ++i) { people[i] = "Jeffy Ten! " + std::to_string(i) + "/" + std::to_string(my_size - 1); printf("in C++ Array::typetest___void__in___string__array_ref__out(), bottom of for() loop, have i = %d, just set another Jeffy!\n", i); }  return(people); }

#endif
#define __CPP__INCLUDED__RPerl__DataStructure__Array_cpp 1

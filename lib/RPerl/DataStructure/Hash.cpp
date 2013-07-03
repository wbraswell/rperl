////use strict;  use warnings;
using std::cout;  using std::endl;

#include <RPerl/DataStructure/Hash.h>		// -> NULL (relies on <unordered_map> being included via Inline::CPP's AUTO_INCLUDE config option)

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash_cpp



// START HERE: convert the code in this file to run on hashes, then convert Hash_cpp.pm and hash_test.pl
// START HERE: convert the code in this file to run on hashes, then convert Hash_cpp.pm and hash_test.pl
// START HERE: convert the code in this file to run on hashes, then convert Hash_cpp.pm and hash_test.pl





// convert from (Perl SV containing reference to (Perl HV of (Perl SVs containing IVs))) to (C++ std::unordered_map of ints)
int__hash_ref XS_unpack_int__hash_ref(SV *input_hv_ref)
{
	printf("in XS_unpack_int__hash_ref(), top of subroutine\n");

    HV* input_hv;
    int input_hv_index_max;
    int i;
    SV** input_hv_element;
    int__hash_ref output_unordered_map;

	if (SvROK(input_hv_ref) && (SvTYPE(SvRV(input_hv_ref)) == SVt_PVHV)) { input_hv = (HV*)SvRV(input_hv_ref); }
	else { croak("in XS_unpack_int__hash_ref(), input_hv_ref was not an HV ref"); }

	input_hv_index_max = av_len(input_hv);
	printf("in XS_unpack_int__hash_ref(), have input_hv_index_max = '%d'\n", input_hv_index_max);

	// DEV NOTE: VECTOR ELEMENT ASSIGNMENT OPTION information is not specific to this subroutine or packing/unpacking

	// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
	// resize() ahead of time to allow l-value subscript notation
	output_unordered_map.resize((size_t)(input_hv_index_max + 1));

	// VECTOR ELEMENT ASSIGNMENT, OPTION C, PUSH, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid memory reallocation(s) (aka change in unordered_map capacity) during element copying in for() loop
//	output_unordered_map.reserve((size_t)(input_hv_index_max + 1));

	// VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE:
//	output_unordered_map.reserve((size_t)(input_hv_index_max + 1));  // if incrementing iteration
//	output_unordered_map.resize((size_t)(input_hv_index_max + 1));  // if decrementing iteration

	for (i = 0;  i <= input_hv_index_max;  ++i)  // incrementing iteration
//	for (i = input_hv_index_max;  i >= 0;  --i)  // decrementing iteration
	{
		// utilizes i in element retrieval
		input_hv_element = av_fetch(input_hv, i, 0);

		if (input_hv_element != NULL)
		{
			// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
			if (SvIOKp(*input_hv_element)) { output_unordered_map[i] = SvIV(*input_hv_element); }

			// VECTOR ELEMENT ASSIGNMENT, OPTION B, SUBSCRIPT, UNKNOWN SIZE: unpredictable value of i and thus unpredictable unordered_map size,
			// call resize() every time we use l-value subscript; utilizes i in assignment
//			if (SvIOKp(*input_hv_element)) { VECTOR_RESIZE_NOSHRINK(output_unordered_map, (i + 1));  output_unordered_map[i] = SvIV(*input_hv_element); }

			// VECTOR ELEMENT ASSIGNMENT, OPTIONS C & D, PUSH, KNOWN & UNKNOWN SIZE: push_back() calls resize(); does not utilize i in assignment;
			// only works for incrementing iteration!!!  will reverse list order for decrementing iteration, there is no push_front() method
//			if (SvIOKp(*input_hv_element)) { output_unordered_map.push_back(SvIV(*input_hv_element)); }

			// VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE: utilizes i in assignment
//			if (SvIOKp(*input_hv_element)) { output_unordered_map.insert((i + output_unordered_map.begin()), SvIV(*input_hv_element)); }  // if incrementing iteration
//			if (SvIOKp(*input_hv_element)) { output_unordered_map.erase(i + output_unordered_map.begin());  output_unordered_map.insert((i + output_unordered_map.begin()), SvIV(*input_hv_element)); }  // if decrementing iteration

			// VECTOR ELEMENT ASSIGNMENT, OPTION F, ITERATOR, UNKNOWN SIZE: unpredictable value of i and thus unpredictable unordered_map size,
			// call resize() every time we use insert(); utilizes i in assignment
//			if (SvIOKp(*input_hv_element)) { VECTOR_RESIZE_NOSHRINK(output_unordered_map, (i + 1));  output_unordered_map.erase(i + output_unordered_map.begin());  output_unordered_map.insert((i + output_unordered_map.begin()), SvIV(*input_hv_element)); }

			else { croak("in XS_unpack_int__hash_ref(), input_hv_element at index %d was not an int", i); }
		}
		else { croak("in XS_unpack_int__hash_ref(), input_hv_element at index %d was undef and/or NULL", i); }
	}


	printf("in XS_unpack_int__hash_ref(), after for() loop, have output_unordered_map.size() = %d\n", output_unordered_map.size());
	printf("in XS_unpack_int__hash_ref(), bottom of subroutine\n");

	return(output_unordered_map);
}


// convert from (C++ std::unordered_map of ints) to (Perl SV containing reference to (Perl HV of (Perl SVs containing IVs)))
void XS_pack_int__hash_ref(SV *output_hv_ref, int__hash_ref input_unordered_map)
{
	printf("in XS_pack_int__hash_ref(), top of subroutine\n");

	HV *output_hv = newHV();  // initialize output hash to empty
	int input_unordered_map_length = input_unordered_map.size();
	int i;
	SV *temp_sv_pointer;

	printf("in XS_pack_int__hash_ref(), have input_unordered_map_length = '%d'\n", input_unordered_map_length);

	if (input_unordered_map_length > 0) { for (i = 0;  i < input_unordered_map_length;  ++i) { av_push(output_hv, newSViv(input_unordered_map[i])); } }
	else warn("in XS_pack_int__hash_ref(), hash was empty, returning empty hash via newHV()");

	temp_sv_pointer = newSVrv(output_hv_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointer);		 // discard temporary pointer
	SvRV(output_hv_ref) = (SV*)output_hv;	   // make output stack RV point at our output HV

	printf("in XS_pack_int__hash_ref(), bottom of subroutine\n");
}


// convert from (Perl SV containing reference to (Perl HV of (Perl SVs containing PVs))) to (C++ std::unordered_map of std::strings)
string__hash_ref XS_unpack_string__hash_ref(SV *input_hv_ref)
{
	printf("in XS_unpack_string__hash_ref(), top of subroutine\n");

    HV* input_hv;
    int input_hv_index_max;
    int i;
    SV** input_hv_element;
    string__hash_ref output_unordered_map;

	if (SvROK(input_hv_ref) && (SvTYPE(SvRV(input_hv_ref)) == SVt_PVHV)) { input_hv = (HV*)SvRV(input_hv_ref); }
	else { croak("in XS_unpack_string__hash_ref(), input_hv_ref was not an HV ref"); }

	input_hv_index_max = av_len(input_hv);
	printf("in XS_unpack_string__hash_ref(), have input_hv_index_max = '%d'\n", input_hv_index_max);

	// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
	// resize() ahead of time to allow l-value subscript notation
	output_unordered_map.resize((size_t)(input_hv_index_max + 1));

	// VECTOR ELEMENT ASSIGNMENT, OPTION C, PUSH, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid memory reallocation(s) (aka change in unordered_map capacity) during element copying in for() loop
//	output_unordered_map.reserve((size_t)(input_hv_index_max + 1));

	for (i = 0;  i <= input_hv_index_max;  ++i)  // incrementing iteration
//	for (i = input_hv_index_max;  i >= 0;  --i)  // decrementing iteration
	{
		// utilizes i in element retrieval
		input_hv_element = av_fetch(input_hv, i, 0);

		if (input_hv_element != NULL)
		{
			// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
			if (SvPOKp(*input_hv_element)) { output_unordered_map[i] = SvPV_nolen(*input_hv_element); }

			// VECTOR ELEMENT ASSIGNMENT, OPTIONS C & D, PUSH, KNOWN & UNKNOWN SIZE: push_back() calls resize(); does not utilize i in assignment;
			// only works for incrementing iteration!!!  will reverse list order for decrementing iteration, there is no push_front() method
//			if (SvPOKp(*input_hv_element)) { output_unordered_map.push_back(SvPV_nolen(*input_hv_element)); }

				else { croak("in XS_unpack_string__hash_ref(), input_hv_element %d was not a string", i); }
		}
		else { croak("in XS_unpack_string__hash_ref(), input_hv_element at index %d was undef and/or NULL", i); }
	}

	printf("in XS_unpack_string__hash_ref(), after for() loop, have output_unordered_map.size() = %d\n", output_unordered_map.size());
	printf("in XS_unpack_string__hash_ref(), bottom of subroutine\n");

	return(output_unordered_map);
}


// convert from (C++ std::unordered_map of std::strings) to (Perl SV containing reference to (Perl HV of (Perl SVs containing PVs)))
void XS_pack_string__hash_ref(SV *output_hv_ref, string__hash_ref input_unordered_map)
{
	printf("in XS_pack_string__hash_ref(), top of subroutine\n");

	HV *output_hv = newHV();  // initialize output hash to empty
	int input_unordered_map_length = input_unordered_map.size();
	int i;
	SV *temp_sv_pointer;

	printf("in XS_pack_string__hash_ref(), have input_unordered_map_length = '%d'\n", input_unordered_map_length);

	if (input_unordered_map_length > 0) { for (i = 0;  i < input_unordered_map_length;  ++i) { av_push(output_hv, newSVpv(input_unordered_map[i].data(), input_unordered_map[i].size())); } }
	else warn("in XS_pack_string__hash_ref(), hash was empty, returning empty hash via newHV()");

	temp_sv_pointer = newSVrv(output_hv_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointer);		 // discard temporary pointer
	SvRV(output_hv_ref) = (SV*)output_hv;	   // make output stack RV point at our output HV

	printf("in XS_pack_string__hash_ref(), bottom of subroutine\n");
}


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
void typetest___int__in___void__out(int fuzznum) { printf("in C++ CPP_TYPES Hash::typetest___int__in___void__out(), have fuzznum '%d', BOOFAZ\n", fuzznum); }  // CPP_TYPES
void typetest___int__hash_ref__in___void__out(int__hash_ref lucky_numbers) { int how_lucky = lucky_numbers.size();  int i;  for (i = 0;  i < how_lucky;  i++) { printf("in C++ CPP_TYPES Hash::typetest___int__hash_ref__in___void__out(), have lucky number %d/%d = '%d', BARBAT\n", i, (how_lucky - 1), lucky_numbers[i]); } }
int__hash_ref typetest___int__in___int__hash_ref__out(int my_size) { int__hash_ref new_vec(my_size);  int i;  for (i = 0;  i < my_size;  i++) { new_vec[i] = i * 5;  printf("in C++ CPP_TYPES Hash::typetest___int__in___int__hash_ref__out(), setting element %d/%d = '%d', BARBAT\n", i, (my_size - 1), new_vec[i]); }  return(new_vec); }

//our void $typetest___string__hash_ref__in___void__out = sub { (my string__hash_ref $people) = @_;  for (my int $i = 0;  $i < @{$people};  $i++) { print "in Perl Hash::typetest___string__hash_ref__in___void__out(), have person $i = '" . $people->[$i] . "', FOOBAZ\n"; } };
//void typetest___string__hash_ref__in___void__out(string__hash_ref people) { int i;  for (i = 0;  i < people.size();  ++i) { printf("in C++ CPP_TYPES printf() Hash::typetest___string__hash_ref__in___void__out(), have person %d = '%s', FOOBAZ\n", i, people[i].c_str()); } }
void typetest___string__hash_ref__in___void__out(string__hash_ref people) { int i;  for (i = 0;  i < people.size();  ++i) { cout << "in C++ CPP_TYPES cout<< Hash::typetest___string__hash_ref__in___void__out(), have person " << i << " = '" << people[i] << "', FOOBAZ\n"; } }
string__hash_ref typetest___void__in___string__hash_ref__out()
{
	printf("in C++ Hash::typetest___void__in___string__hash_ref__out(), top of subroutine\n");

	string__hash_ref people;
	int i;
	const int num_people = 5;

	people.resize((size_t)num_people);

	for (i = 0;  i < num_people;  ++i)
	{
		people[i] = "Jeffy Ten! " + std::to_string(i) + "/" + std::to_string(num_people - 1);
		printf("in C++ Hash::typetest___void__in___string__hash_ref__out(), bottom of for() loop, have i = %d, just set another Jeffy!\n", i);
	}

	printf("in C++ Hash::typetest___void__in___string__hash_ref__out(), bottom of subroutine\n");

	return(people);
}

#endif
#define __CPP__INCLUDED__RPerl__DataStructure__Hash_cpp 1

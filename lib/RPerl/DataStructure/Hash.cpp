////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash_cpp
#define __CPP__INCLUDED__RPerl__DataStructure__Hash_cpp 1

#include <RPerl/DataStructure/Hash.h>		// -> NULL (relies on <unordered_map> being included via Inline::CPP's AUTO_INCLUDE config option)

// convert from (Perl SV containing reference to (Perl HV of (Perl SVs containing IVs))) to (C++ std::unordered_map of ints)
int__hash_ref XS_unpack_int__hash_ref(SV *input_hv_ref)
{
	printf("in XS_unpack_int__hash_ref(), top of subroutine\n");

    HV* input_hv;
    int input_hv_num_keys;
    int i;
    HE* input_hv_entry;
    SV* input_hv_key;
    SV* input_hv_value;
    int__hash_ref output_unordered_map;

	if (SvROK(input_hv_ref) && (SvTYPE(SvRV(input_hv_ref)) == SVt_PVHV)) { input_hv = (HV*)SvRV(input_hv_ref); }
	else { croak("in XS_unpack_int__hash_ref(), input_hv_ref was not an HV ref"); }

	input_hv_num_keys = hv_iterinit(input_hv);
	printf("in XS_unpack_int__hash_ref(), have input_hv_num_keys = %d\n", input_hv_num_keys);

	// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid resizing and rehashing in for() loop
	output_unordered_map.reserve((size_t)input_hv_num_keys);

	for (i = 0;  i < input_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
	{
		// does not utilize i in entry retrieval
		input_hv_entry = hv_iternext(input_hv);

		if (input_hv_entry != NULL)
		{
			input_hv_key = hv_iterkeysv(input_hv_entry);
			input_hv_value = hv_iterval(input_hv, input_hv_entry);

			// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize i in assignment
			if (SvIOKp(input_hv_value)) { output_unordered_map[SvPV_nolen(input_hv_key)] = SvIV(input_hv_value); }
			else { croak("in XS_unpack_int__hash_ref(), input_hv_value '%s' at key '%s' and index %d was not an int", SvPV_nolen(input_hv_value), SvPV_nolen(input_hv_key), i); }
		}
		else { croak("in XS_unpack_int__hash_ref(), input_hv_entry at index %d was undef and/or NULL", i); }
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
	int input_unordered_map_num_keys = input_unordered_map.size();
	int__hash_ref__const_iterator i;
	SV *temp_sv_pointer;

	printf("in XS_pack_int__hash_ref(), have input_unordered_map_num_keys = %d\n", input_unordered_map_num_keys);

	if (input_unordered_map_num_keys > 0)
	{
		for (i = input_unordered_map.begin();  i != input_unordered_map.end();  ++i)
			{ hv_store(output_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newSViv(i->second), (U32)0); }
	}
	else warn("in XS_pack_int__hash_ref(), hash was empty, returning empty hash via newHV()");

	temp_sv_pointer = newSVrv(output_hv_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointer);		 // discard temporary pointer
	SvRV(output_hv_ref) = (SV*)output_hv;	   // make output stack RV point at our output HV

	printf("in XS_pack_int__hash_ref(), bottom of subroutine\n");
}


// convert from (Perl SV containing reference to (Perl HV of (Perl SVs containing NVs))) to (C++ std::unordered_map of long doubles)
number__hash_ref XS_unpack_number__hash_ref(SV *input_hv_ref)
{
	printf("in XS_unpack_number__hash_ref(), top of subroutine\n");

    HV* input_hv;
    int input_hv_num_keys;
    int i;
    HE* input_hv_entry;
    SV* input_hv_key;
    SV* input_hv_value;
    number__hash_ref output_unordered_map;

	if (SvROK(input_hv_ref) && (SvTYPE(SvRV(input_hv_ref)) == SVt_PVHV)) { input_hv = (HV*)SvRV(input_hv_ref); }
	else { croak("in XS_unpack_number__hash_ref(), input_hv_ref was not an HV ref"); }

	input_hv_num_keys = hv_iterinit(input_hv);
	printf("in XS_unpack_number__hash_ref(), have input_hv_num_keys = %d\n", input_hv_num_keys);

	// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid resizing and rehashing in for() loop
	output_unordered_map.reserve((size_t)input_hv_num_keys);

	for (i = 0;  i < input_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
	{
		// does not utilize i in entry retrieval
		input_hv_entry = hv_iternext(input_hv);

		if (input_hv_entry != NULL)
		{
			input_hv_key = hv_iterkeysv(input_hv_entry);
			input_hv_value = hv_iterval(input_hv, input_hv_entry);

			// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize i in assignment
			if (SvNOKp(input_hv_value)) { output_unordered_map[SvPV_nolen(input_hv_key)] = SvNV(input_hv_value); }
			else { croak("in XS_unpack_number__hash_ref(), input_hv_value '%s' at key '%s' and index %d was not a number", SvPV_nolen(input_hv_value), SvPV_nolen(input_hv_key), i); }
		}
		else { croak("in XS_unpack_number__hash_ref(), input_hv_entry at index %d was undef and/or NULL", i); }
	}

	printf("in XS_unpack_number__hash_ref(), after for() loop, have output_unordered_map.size() = %d\n", output_unordered_map.size());
	printf("in XS_unpack_number__hash_ref(), bottom of subroutine\n");

	return(output_unordered_map);
}


// convert from (C++ std::unordered_map of long doubles) to (Perl SV containing reference to (Perl HV of (Perl SVs containing NVs)))
void XS_pack_number__hash_ref(SV *output_hv_ref, number__hash_ref input_unordered_map)
{
	printf("in XS_pack_number__hash_ref(), top of subroutine\n");

	HV *output_hv = newHV();  // initialize output hash to empty
	int input_unordered_map_num_keys = input_unordered_map.size();
	number__hash_ref__const_iterator i;
	SV *temp_sv_pointer;

	printf("in XS_pack_number__hash_ref(), have input_unordered_map_num_keys = %d\n", input_unordered_map_num_keys);

	if (input_unordered_map_num_keys > 0)
	{
		for (i = input_unordered_map.begin();  i != input_unordered_map.end();  ++i)
			{ hv_store(output_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newSVnv(i->second), (U32)0); }
	}
	else warn("in XS_pack_number__hash_ref(), hash was empty, returning empty hash via newHV()");

	temp_sv_pointer = newSVrv(output_hv_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointer);		 // discard temporary pointer
	SvRV(output_hv_ref) = (SV*)output_hv;	   // make output stack RV point at our output HV

	printf("in XS_pack_number__hash_ref(), bottom of subroutine\n");
}


// convert from (Perl SV containing reference to (Perl HV of (Perl SVs containing PVs))) to (C++ std::unordered_map of strings)
string__hash_ref XS_unpack_string__hash_ref(SV *input_hv_ref)
{
	printf("in XS_unpack_string__hash_ref(), top of subroutine\n");

    HV* input_hv;
    int input_hv_num_keys;
    int i;
    HE* input_hv_entry;
    SV* input_hv_key;
    SV* input_hv_value;
    string__hash_ref output_unordered_map;

	if (SvROK(input_hv_ref) && (SvTYPE(SvRV(input_hv_ref)) == SVt_PVHV)) { input_hv = (HV*)SvRV(input_hv_ref); }
	else { croak("in XS_unpack_string__hash_ref(), input_hv_ref was not an HV ref"); }

	input_hv_num_keys = hv_iterinit(input_hv);
	printf("in XS_unpack_string__hash_ref(), have input_hv_num_keys = %d\n", input_hv_num_keys);

	// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid resizing and rehashing in for() loop
	output_unordered_map.reserve((size_t)input_hv_num_keys);

	for (i = 0;  i < input_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
	{
		// does not utilize i in entry retrieval
		input_hv_entry = hv_iternext(input_hv);

		if (input_hv_entry != NULL)
		{
			input_hv_key = hv_iterkeysv(input_hv_entry);
			input_hv_value = hv_iterval(input_hv, input_hv_entry);

			// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize i in assignment
			if (SvPOKp(input_hv_value)) { output_unordered_map[SvPV_nolen(input_hv_key)] = SvPV_nolen(input_hv_value); }
			else { croak("in XS_unpack_string__hash_ref(), input_hv_value '%s' at key '%s' and index %d was not a string", SvPV_nolen(input_hv_value), SvPV_nolen(input_hv_key), i); }
		}
		else { croak("in XS_unpack_string__hash_ref(), input_hv_entry at index %d was undef and/or NULL", i); }
	}

	printf("in XS_unpack_string__hash_ref(), after for() loop, have output_unordered_map.size() = %d\n", output_unordered_map.size());
	printf("in XS_unpack_string__hash_ref(), bottom of subroutine\n");

	return(output_unordered_map);
}


// convert from (C++ std::unordered_map of strings) to (Perl SV containing reference to (Perl HV of (Perl SVs containing PVs)))
void XS_pack_string__hash_ref(SV *output_hv_ref, string__hash_ref input_unordered_map)
{
	printf("in XS_pack_string__hash_ref(), top of subroutine\n");

	HV *output_hv = newHV();  // initialize output hash to empty
	int input_unordered_map_num_keys = input_unordered_map.size();
	string__hash_ref__const_iterator i;
	SV *temp_sv_pointer;

	printf("in XS_pack_string__hash_ref(), have input_unordered_map_num_keys = %d\n", input_unordered_map_num_keys);

	if (input_unordered_map_num_keys > 0)
	{
		for (i = input_unordered_map.begin();  i != input_unordered_map.end();  ++i)
			{ hv_store(output_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newSVpv((i->second).c_str(), 0), (U32)0); }
	}
	else warn("in XS_pack_string__hash_ref(), hash was empty, returning empty hash via newHV()");

	temp_sv_pointer = newSVrv(output_hv_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointer);		 // discard temporary pointer
	SvRV(output_hv_ref) = (SV*)output_hv;	   // make output stack RV point at our output HV

	printf("in XS_pack_string__hash_ref(), bottom of subroutine\n");
}


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
void typetest___int__hash_ref__in___void__out(int__hash_ref lucky_numbers) { int__hash_ref__const_iterator i;  for (i = lucky_numbers.begin();  i != lucky_numbers.end();  ++i) { printf("in C++ Hash::typetest___int__hash_ref__in___void__out(), have lucky number '%s' => %d, BARSTOOL\n", (i->first).c_str(), i->second); } }
int__hash_ref typetest___int__in___int__hash_ref__out(int my_size) { int__hash_ref new_unordered_map(my_size);  int i;  string temp_key;  for (i = 0;  i < my_size;  ++i) { temp_key = "funkey" + std::to_string(i);  new_unordered_map[temp_key] = i * 5;  printf("in C++ Hash::typetest___int__in___int__hash_ref__out(), setting entry '%s' => %d, BARSTOOL\n", temp_key.c_str(), new_unordered_map[temp_key]); }  return(new_unordered_map); }
void typetest___number__hash_ref__in___void__out(number__hash_ref lucky_numbers) { number__hash_ref__const_iterator i;  for (i = lucky_numbers.begin();  i != lucky_numbers.end();  ++i) { printf("in C++ Hash::typetest___number__hash_ref__in___void__out(), have lucky number '%s' => %Lf, BARSTOOL\n", (i->first).c_str(), i->second); } }
number__hash_ref typetest___int__in___number__hash_ref__out(int my_size) { number__hash_ref new_unordered_map(my_size);  int i;  string temp_key;  for (i = 0;  i < my_size;  ++i) { temp_key = "funkey" + std::to_string(i);  new_unordered_map[temp_key] = i * 5.123456789;  printf("in C++ Hash::typetest___int__in___number__hash_ref__out(), setting entry '%s' => %Lf, BARSTOOL\n", temp_key.c_str(), new_unordered_map[temp_key]); }  return(new_unordered_map); }
void typetest___string__hash_ref__in___void__out(string__hash_ref people) { string__hash_ref__const_iterator i;  for (i = people.begin();  i != people.end();  ++i) { printf("in C++ Hash::typetest___string__hash_ref__in___void__out(), have person '%s' => '%s', STARBOOL\n", (i->first).c_str(), (i->second).c_str()); } }
string__hash_ref typetest___int__in___string__hash_ref__out(int my_size) { string__hash_ref people;  int i;  people.reserve((size_t)my_size);  for (i = 0;  i < my_size;  ++i) { people["Luker_key" + std::to_string(i)] = "Jeffy Ten! " + std::to_string(i) + "/" + std::to_string(my_size - 1); printf("in C++ Hash::typetest___int__in___string__hash_ref__out(), bottom of for() loop, have i = %d, just set another Jeffy!\n", i); }  return(people); }


#endif

////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash_cpp
#define __CPP__INCLUDED__RPerl__DataStructure__Hash_cpp 0.003000

#include <RPerl/DataStructure/Hash.h>		// -> NULL (relies on <unordered_map> being included via Inline::CPP's AUTO_INCLUDE config option)

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]

// convert from (Perl SV containing reference to (Perl HV of (Perl SVs containing IVs))) to (C++ std::unordered_map of integers)
integer__hash_ref XS_unpack_integer__hash_ref(SV* input_hv_ref)
{
	printf("in CPPOPS_CPPTYPES XS_unpack_integer__hash_ref(), top of subroutine\n");
//	hash_ref__CHECK(input_hv_ref);
	hash_ref__CHECKTRACE(input_hv_ref, "input_hv_ref", "XS_unpack_integer__hash_ref()");

    HV* input_hv;
    integer input_hv_num_keys;
    integer i;
    HE* input_hv_entry;
    SV* input_hv_entry_key;
    SV* input_hv_entry_value;
    integer__hash_ref output_unordered_map;

	input_hv = (HV*)SvRV(input_hv_ref);

	input_hv_num_keys = hv_iterinit(input_hv);
	printf("in CPPOPS_CPPTYPES XS_unpack_integer__hash_ref(), have input_hv_num_keys = %d\n", input_hv_num_keys);

	// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid resizing and rehashing in for() loop
	output_unordered_map.reserve((size_t)input_hv_num_keys);

	for (i = 0;  i < input_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
	{
		// does not utilize i in entry retrieval
		input_hv_entry = hv_iternext(input_hv);
//		hash_entry__CHECK(input_hv_entry);
		hash_entry__CHECKTRACE(input_hv_entry, "input_hv_entry", "XS_unpack_integer__hash_ref()");

		input_hv_entry_key = hv_iterkeysv(input_hv_entry);
		input_hv_entry_value = hv_iterval(input_hv, input_hv_entry);
//		integer__CHECK(input_hv_entry_value);
		integer__CHECKTRACE(input_hv_entry_value, (char*)((string)"input_hv_entry_value at key '" + (string)SvPV_nolen(input_hv_entry_key) + "'").c_str(), "XS_unpack_integer__hash_ref()");

		// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize i in assignment
		output_unordered_map[SvPV_nolen(input_hv_entry_key)] = SvIV(input_hv_entry_value);
	}

	printf("in CPPOPS_CPPTYPES XS_unpack_integer__hash_ref(), after for() loop, have output_unordered_map.size() = %d\n", output_unordered_map.size());
	printf("in CPPOPS_CPPTYPES XS_unpack_integer__hash_ref(), bottom of subroutine\n");

	return(output_unordered_map);
}


// convert from (C++ std::unordered_map of integers) to (Perl SV containing reference to (Perl HV of (Perl SVs containing IVs)))
void XS_pack_integer__hash_ref(SV* output_hv_ref, integer__hash_ref input_unordered_map)
{
	printf("in CPPOPS_CPPTYPES XS_pack_integer__hash_ref(), top of subroutine\n");

	HV* output_hv = newHV();  // initialize output hash to empty
	integer input_unordered_map_num_keys = input_unordered_map.size();
	integer__hash_ref__const_iterator i;
	SV* temp_sv_pointegerer;

	printf("in CPPOPS_CPPTYPES XS_pack_integer__hash_ref(), have input_unordered_map_num_keys = %d\n", input_unordered_map_num_keys);

	if (input_unordered_map_num_keys > 0)
	{
		for (i = input_unordered_map.begin();  i != input_unordered_map.end();  ++i)
			{ hv_store(output_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newSViv(i->second), (U32)0); }
	}
	else croak("in CPPOPS_CPPTYPES XS_pack_integer__hash_ref(), hash was empty, returning empty hash via newHV()");

	temp_sv_pointegerer = newSVrv(output_hv_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointegerer);		 // discard temporary pointegerer
	SvRV(output_hv_ref) = (SV*)output_hv;	   // make output stack RV pointeger at our output HV

	printf("in CPPOPS_CPPTYPES XS_pack_integer__hash_ref(), bottom of subroutine\n");
}


// convert from (Perl SV containing reference to (Perl HV of (Perl SVs containing NVs))) to (C++ std::unordered_map of long doubles)
number__hash_ref XS_unpack_number__hash_ref(SV* input_hv_ref)
{
	printf("in CPPOPS_CPPTYPES XS_unpack_number__hash_ref(), top of subroutine\n");
//	hash_ref__CHECK(input_hv_ref);
	hash_ref__CHECKTRACE(input_hv_ref, "input_hv_ref", "XS_unpack_number__hash_ref()");

    HV* input_hv;
    integer input_hv_num_keys;
    integer i;
    HE* input_hv_entry;
    SV* input_hv_entry_key;
    SV* input_hv_entry_value;
    number__hash_ref output_unordered_map;

	input_hv = (HV*)SvRV(input_hv_ref);

	input_hv_num_keys = hv_iterinit(input_hv);
	printf("in CPPOPS_CPPTYPES XS_unpack_number__hash_ref(), have input_hv_num_keys = %d\n", input_hv_num_keys);

	// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid resizing and rehashing in for() loop
	output_unordered_map.reserve((size_t)input_hv_num_keys);

	for (i = 0;  i < input_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
	{
		// does not utilize i in entry retrieval
		input_hv_entry = hv_iternext(input_hv);
//		hash_entry__CHECK(input_hv_entry);
		hash_entry__CHECKTRACE(input_hv_entry, "input_hv_entry", "XS_unpack_number__hash_ref()");

		input_hv_entry_key = hv_iterkeysv(input_hv_entry);
		input_hv_entry_value = hv_iterval(input_hv, input_hv_entry);
//		number__CHECK(input_hv_entry_value);
		number__CHECKTRACE(input_hv_entry_value, (char*)((string)"input_hv_entry_value at key '" + (string)SvPV_nolen(input_hv_entry_key) + "'").c_str(), "XS_unpack_number__hash_ref()");

		// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize i in assignment
		output_unordered_map[SvPV_nolen(input_hv_entry_key)] = SvNV(input_hv_entry_value);
	}

	printf("in CPPOPS_CPPTYPES XS_unpack_number__hash_ref(), after for() loop, have output_unordered_map.size() = %d\n", output_unordered_map.size());
	printf("in CPPOPS_CPPTYPES XS_unpack_number__hash_ref(), bottom of subroutine\n");

	return(output_unordered_map);
}


// convert from (C++ std::unordered_map of long doubles) to (Perl SV containing reference to (Perl HV of (Perl SVs containing NVs)))
void XS_pack_number__hash_ref(SV* output_hv_ref, number__hash_ref input_unordered_map)
{
	printf("in CPPOPS_CPPTYPES XS_pack_number__hash_ref(), top of subroutine\n");

	HV* output_hv = newHV();  // initialize output hash to empty
	integer input_unordered_map_num_keys = input_unordered_map.size();
	number__hash_ref__const_iterator i;
	SV* temp_sv_pointegerer;

	printf("in CPPOPS_CPPTYPES XS_pack_number__hash_ref(), have input_unordered_map_num_keys = %d\n", input_unordered_map_num_keys);

	if (input_unordered_map_num_keys > 0)
	{
		for (i = input_unordered_map.begin();  i != input_unordered_map.end();  ++i)
			{ hv_store(output_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newSVnv(i->second), (U32)0); }
	}
	else croak("in CPPOPS_CPPTYPES XS_pack_number__hash_ref(), hash was empty, returning empty hash via newHV()");

	temp_sv_pointegerer = newSVrv(output_hv_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointegerer);		 // discard temporary pointegerer
	SvRV(output_hv_ref) = (SV*)output_hv;	   // make output stack RV pointeger at our output HV

	printf("in CPPOPS_CPPTYPES XS_pack_number__hash_ref(), bottom of subroutine\n");
}


// convert from (Perl SV containing reference to (Perl HV of (Perl SVs containing PVs))) to (C++ std::unordered_map of strings)
string__hash_ref XS_unpack_string__hash_ref(SV* input_hv_ref)
{
	printf("in CPPOPS_CPPTYPES XS_unpack_string__hash_ref(), top of subroutine\n");
//	hash_ref__CHECK(input_hv_ref);
	hash_ref__CHECKTRACE(input_hv_ref, "input_hv_ref", "XS_unpack_string__hash_ref()");

    HV* input_hv;
    integer input_hv_num_keys;
    integer i;
    HE* input_hv_entry;
    SV* input_hv_entry_key;
    SV* input_hv_entry_value;
    string__hash_ref output_unordered_map;

	input_hv = (HV*)SvRV(input_hv_ref);

	input_hv_num_keys = hv_iterinit(input_hv);
	printf("in CPPOPS_CPPTYPES XS_unpack_string__hash_ref(), have input_hv_num_keys = %d\n", input_hv_num_keys);

	// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: unordered_map has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid resizing and rehashing in for() loop
	output_unordered_map.reserve((size_t)input_hv_num_keys);

	for (i = 0;  i < input_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
	{
		// does not utilize i in entry retrieval
		input_hv_entry = hv_iternext(input_hv);
//		hash_entry__CHECK(input_hv_entry);
		hash_entry__CHECKTRACE(input_hv_entry, "input_hv_entry", "XS_unpack_string__hash_ref()");

		input_hv_entry_key = hv_iterkeysv(input_hv_entry);
		input_hv_entry_value = hv_iterval(input_hv, input_hv_entry);
//		string__CHECK(input_hv_entry_value);
		string__CHECKTRACE(input_hv_entry_value, (char*)((string)"input_hv_entry_value at key '" + (string)SvPV_nolen(input_hv_entry_key) + "'").c_str(), "XS_unpack_string__hash_ref()");

		// UNORDERED MAP ENTRY ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further reserve(); does not utilize i in assignment
		output_unordered_map[SvPV_nolen(input_hv_entry_key)] = SvPV_nolen(input_hv_entry_value);
	}

	printf("in CPPOPS_CPPTYPES XS_unpack_string__hash_ref(), after for() loop, have output_unordered_map.size() = %d\n", output_unordered_map.size());
	printf("in CPPOPS_CPPTYPES XS_unpack_string__hash_ref(), bottom of subroutine\n");

	return(output_unordered_map);
}


// convert from (C++ std::unordered_map of strings) to (Perl SV containing reference to (Perl HV of (Perl SVs containing PVs)))
void XS_pack_string__hash_ref(SV* output_hv_ref, string__hash_ref input_unordered_map)
{
	printf("in CPPOPS_CPPTYPES XS_pack_string__hash_ref(), top of subroutine\n");

	HV* output_hv = newHV();  // initialize output hash to empty
	integer input_unordered_map_num_keys = input_unordered_map.size();
	string__hash_ref__const_iterator i;
	SV* temp_sv_pointegerer;

	printf("in CPPOPS_CPPTYPES XS_pack_string__hash_ref(), have input_unordered_map_num_keys = %d\n", input_unordered_map_num_keys);

	if (input_unordered_map_num_keys > 0)
	{
		for (i = input_unordered_map.begin();  i != input_unordered_map.end();  ++i)
			{ hv_store(output_hv, (const char*)((i->first).c_str()), (U32)((i->first).size()), newSVpv((i->second).c_str(), 0), (U32)0); }
	}
	else croak("in CPPOPS_CPPTYPES XS_pack_string__hash_ref(), hash was empty, returning empty hash via newHV()");

	temp_sv_pointegerer = newSVrv(output_hv_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointegerer);		 // discard temporary pointegerer
	SvRV(output_hv_ref) = (SV*)output_hv;	   // make output stack RV pointeger at our output HV

	printf("in CPPOPS_CPPTYPES XS_pack_string__hash_ref(), bottom of subroutine\n");
}


//# [[[ STRINGIFY ]]]
//# [[[ STRINGIFY ]]]
//# [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

// convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
SV* integer__hash_ref__stringify(SV* input_hv_ref)
{
	printf("in CPPOPS_PERLTYPES integer__hash_ref__stringify(), top of subroutine\n");
//	hash_ref__CHECK(input_hv_ref);
	hash_ref__CHECKTRACE(input_hv_ref, "input_hv_ref", "integer__hash_ref__stringify()");

    HV* input_hv;
    integer input_hv_num_keys;
    integer i;
    bool i_is_0 = 1;
    HE* input_hv_entry;
    SV* input_hv_entry_key;
    string input_hv_entry_key_string;
    size_t input_hv_entry_key_string_pos;
    SV* input_hv_entry_value;
    SV* output_sv = newSV(0);

	input_hv = (HV*)SvRV(input_hv_ref);
	input_hv_num_keys = hv_iterinit(input_hv);
	printf("in CPPOPS_PERLTYPES integer__hash_ref__stringify(), have input_hv_num_keys = %d\n", input_hv_num_keys);

	sv_setpvn(output_sv, "{", 1);

	for (i = 0;  i < input_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
	{
printf("in CPPOPS_PERLTYPES integer__hash_ref__stringify(), top of loop i = %d\n", i);

		// does not utilize i in entry retrieval
		input_hv_entry = hv_iternext(input_hv);
//		hash_entry__CHECK(input_hv_entry);
		hash_entry__CHECKTRACE(input_hv_entry, "input_hv_entry", "integer__hash_ref__stringify()");

		input_hv_entry_key = hv_iterkeysv(input_hv_entry);
		input_hv_entry_value = hv_iterval(input_hv, input_hv_entry);
//		integer__CHECK(input_hv_entry_value);
		integer__CHECKTRACE(input_hv_entry_value, (char*)((string)"input_hv_entry_value at key '" + (string)SvPV_nolen(input_hv_entry_key) + "'").c_str(), "integer__hash_ref__stringify()");

		if (i_is_0) { i_is_0 = 0; } else { sv_catpvn(output_sv, ", ", 2); }

		// escape all back-slash \ and single-quote ' characters with a back-slash \ character
		input_hv_entry_key_string = string(SvPV_nolen(input_hv_entry_key));
		input_hv_entry_key_string_pos = 0;
		while((input_hv_entry_key_string_pos = input_hv_entry_key_string.find("\\", input_hv_entry_key_string_pos)) != string::npos)
		{
			input_hv_entry_key_string.replace(input_hv_entry_key_string_pos, 1, "\\\\");
			input_hv_entry_key_string_pos += 2;
		}
		input_hv_entry_key_string_pos = 0;
		while((input_hv_entry_key_string_pos = input_hv_entry_key_string.find("'", input_hv_entry_key_string_pos)) != string::npos)
		{
			input_hv_entry_key_string.replace(input_hv_entry_key_string_pos, 1, "\\'");
			input_hv_entry_key_string_pos += 2;
		}

//		sv_catpvf(output_sv, "'%s' => %d", SvPV_nolen(input_hv_entry_key), (integer)SvIV(input_hv_entry_value));
		sv_catpvf(output_sv, "'%s' => %d", input_hv_entry_key_string.c_str(), (integer)SvIV(input_hv_entry_value));
	}

	sv_catpvn(output_sv, "}", 1);

	printf("in CPPOPS_PERLTYPES integer__hash_ref__stringify(), after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
	printf("in CPPOPS_PERLTYPES integer__hash_ref__stringify(), bottom of subroutine\n");

	return(output_sv);
}

// convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
SV* number__hash_ref__stringify(SV* input_hv_ref)
{
	printf("in CPPOPS_PERLTYPES number__hash_ref__stringify(), top of subroutine\n");
//	hash_ref__CHECK(input_hv_ref);
	hash_ref__CHECKTRACE(input_hv_ref, "input_hv_ref", "number__hash_ref__stringify()");

    HV* input_hv;
    integer input_hv_num_keys;
    integer i;
    bool i_is_0 = 1;
    HE* input_hv_entry;
    SV* input_hv_entry_key;
    string input_hv_entry_key_string;
    size_t input_hv_entry_key_string_pos;
    SV* input_hv_entry_value;
    SV* output_sv = newSV(0);
	ostringstream temp_stream;
	temp_stream.precision(std::numeric_limits<double>::digits10);

	input_hv = (HV*)SvRV(input_hv_ref);
	input_hv_num_keys = hv_iterinit(input_hv);
	printf("in CPPOPS_PERLTYPES number__hash_ref__stringify(), have input_hv_num_keys = %d\n", input_hv_num_keys);

	temp_stream << "{";

	for (i = 0;  i < input_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
	{
		// does not utilize i in entry retrieval
		input_hv_entry = hv_iternext(input_hv);
//		hash_entry__CHECK(input_hv_entry);
		hash_entry__CHECKTRACE(input_hv_entry, "input_hv_entry", "number__hash_ref__stringify()");

		input_hv_entry_key = hv_iterkeysv(input_hv_entry);
		input_hv_entry_value = hv_iterval(input_hv, input_hv_entry);
//		number__CHECK(input_hv_entry_value);
		number__CHECKTRACE(input_hv_entry_value, (char*)((string)"input_hv_entry_value at key '" + (string)SvPV_nolen(input_hv_entry_key) + "'").c_str(), "number__hash_ref__stringify()");

		if (i_is_0) { i_is_0 = 0; } else { temp_stream << ", "; }

		// escape all back-slash \ and single-quote ' characters with a back-slash \ character
		input_hv_entry_key_string = string(SvPV_nolen(input_hv_entry_key));
		input_hv_entry_key_string_pos = 0;
		while((input_hv_entry_key_string_pos = input_hv_entry_key_string.find("\\", input_hv_entry_key_string_pos)) != string::npos)
		{
			input_hv_entry_key_string.replace(input_hv_entry_key_string_pos, 1, "\\\\");
			input_hv_entry_key_string_pos += 2;
		}
		input_hv_entry_key_string_pos = 0;
		while((input_hv_entry_key_string_pos = input_hv_entry_key_string.find("'", input_hv_entry_key_string_pos)) != string::npos)
		{
			input_hv_entry_key_string.replace(input_hv_entry_key_string_pos, 1, "\\'");
			input_hv_entry_key_string_pos += 2;
		}

//		temp_stream << "'" << SvPV_nolen(input_hv_entry_key) << "' => " << (long double)SvNV(input_hv_entry_value);
		temp_stream << "'" << input_hv_entry_key_string << "' => " << (long double)SvNV(input_hv_entry_value);
	}

	temp_stream << "}";
	sv_setpv(output_sv, (char*)(temp_stream.str().c_str()));

	printf("in CPPOPS_PERLTYPES number__hash_ref__stringify(), after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
	printf("in CPPOPS_PERLTYPES number__hash_ref__stringify(), bottom of subroutine\n");

	return(output_sv);
}

// convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
SV* string__hash_ref__stringify(SV* input_hv_ref)
{
	printf("in CPPOPS_PERLTYPES string__hash_ref__stringify(), top of subroutine\n");
//	hash_ref__CHECK(input_hv_ref);
	hash_ref__CHECKTRACE(input_hv_ref, "input_hv_ref", "string__hash_ref__stringify()");

    HV* input_hv;
    integer input_hv_num_keys;
    integer i;
    bool i_is_0 = 1;
    HE* input_hv_entry;
    SV* input_hv_entry_key;
    string input_hv_entry_key_string;
    size_t input_hv_entry_key_string_pos;
    SV* input_hv_entry_value;
    string input_hv_entry_value_string;
    size_t input_hv_entry_value_string_pos;
    SV* output_sv = newSV(0);

	input_hv = (HV*)SvRV(input_hv_ref);
	input_hv_num_keys = hv_iterinit(input_hv);
	printf("in CPPOPS_PERLTYPES string__hash_ref__stringify(), have input_hv_num_keys = %d\n", input_hv_num_keys);

	sv_setpvn(output_sv, "{", 1);

	for (i = 0;  i < input_hv_num_keys;  ++i)  // incrementing iteration, iterator i not actually used in loop body
	{
		// does not utilize i in entry retrieval
		input_hv_entry = hv_iternext(input_hv);
//		hash_entry__CHECK(input_hv_entry);
		hash_entry__CHECKTRACE(input_hv_entry, "input_hv_entry", "string__hash_ref__stringify()");

		input_hv_entry_key = hv_iterkeysv(input_hv_entry);
		input_hv_entry_value = hv_iterval(input_hv, input_hv_entry);
//		string__CHECK(input_hv_entry_value);
		string__CHECKTRACE(input_hv_entry_value, (char*)((string)"input_hv_entry_value at key '" + (string)SvPV_nolen(input_hv_entry_key) + "'").c_str(), "string__hash_ref__stringify()");

		if (i_is_0) { i_is_0 = 0; } else { sv_catpvn(output_sv, ", ", 2); }

		// escape all back-slash \ and single-quote ' characters with a back-slash \ character
		input_hv_entry_key_string = string(SvPV_nolen(input_hv_entry_key));
		input_hv_entry_key_string_pos = 0;
		while((input_hv_entry_key_string_pos = input_hv_entry_key_string.find("\\", input_hv_entry_key_string_pos)) != string::npos)
		{
			input_hv_entry_key_string.replace(input_hv_entry_key_string_pos, 1, "\\\\");
			input_hv_entry_key_string_pos += 2;
		}
		input_hv_entry_key_string_pos = 0;
		while((input_hv_entry_key_string_pos = input_hv_entry_key_string.find("'", input_hv_entry_key_string_pos)) != string::npos)
		{
			input_hv_entry_key_string.replace(input_hv_entry_key_string_pos, 1, "\\'");
			input_hv_entry_key_string_pos += 2;
		}

		// and again
		input_hv_entry_value_string = string(SvPV_nolen(input_hv_entry_value));
		input_hv_entry_value_string_pos = 0;
		while((input_hv_entry_value_string_pos = input_hv_entry_value_string.find("\\", input_hv_entry_value_string_pos)) != string::npos)
		{
			input_hv_entry_value_string.replace(input_hv_entry_value_string_pos, 1, "\\\\");
			input_hv_entry_value_string_pos += 2;
		}
		input_hv_entry_value_string_pos = 0;
		while((input_hv_entry_value_string_pos = input_hv_entry_value_string.find("'", input_hv_entry_value_string_pos)) != string::npos)
		{
			input_hv_entry_value_string.replace(input_hv_entry_value_string_pos, 1, "\\'");
			input_hv_entry_value_string_pos += 2;
		}

//		sv_catpvf(output_sv, "'%s' => '%s'", SvPV_nolen(input_hv_entry_key), SvPV_nolen(input_hv_entry_value));
		sv_catpvf(output_sv, "'%s' => '%s'", input_hv_entry_key_string.c_str(), input_hv_entry_value_string.c_str());
	}

	sv_catpvn(output_sv, "}", 1);

	printf("in CPPOPS_PERLTYPES string__hash_ref__stringify(), after for() loop, have output_sv =\n%s\n", SvPV_nolen(output_sv));
	printf("in CPPOPS_PERLTYPES string__hash_ref__stringify(), bottom of subroutine\n");

	return(output_sv);
}

# elif defined __CPP__TYPES

// convert from (C++ std::unordered_map of integers) to Perl-parsable (C++ std::string)
string integer__hash_ref__stringify(integer__hash_ref input_unordered_map)
{
	printf("in CPPOPS_CPPTYPES integer__hash_ref__stringify(), top of subroutine\n");

	ostringstream output_stream;
	integer__hash_ref__const_iterator i;
    bool i_is_0 = 1;
    string key_string;
    size_t key_string_pos;

	output_stream << '{';

	for (i = input_unordered_map.begin();  i != input_unordered_map.end();  ++i)
	{
		if (i_is_0) { i_is_0 = 0; } else { output_stream << ", "; }

		// escape all back-slash \ and single-quote ' characters with a back-slash \ character
		key_string = i->first;
		key_string_pos = 0;
		while((key_string_pos = key_string.find("\\", key_string_pos)) != string::npos)
		{
			key_string.replace(key_string_pos, 1, "\\\\");
			key_string_pos += 2;
		}
		key_string_pos = 0;
		while((key_string_pos = key_string.find("'", key_string_pos)) != string::npos)
		{
			key_string.replace(key_string_pos, 1, "\\'");
			key_string_pos += 2;
		}

//		output_stream << "'" << (i->first).c_str() << "' => " << i->second;
		output_stream << "'" << key_string.c_str() << "' => " << i->second;
	}

	output_stream << '}';

	printf("in CPPOPS_CPPTYPES integer__hash_ref__stringify(), after for() loop, have output_stream =\n%s\n", (char*)(output_stream.str().c_str()));
	printf("in CPPOPS_CPPTYPES integer__hash_ref__stringify(), bottom of subroutine\n");

	return(output_stream.str());
}


// convert from (C++ std::unordered_map of long doubles) to Perl-parsable (C++ std::string)
string number__hash_ref__stringify(number__hash_ref input_unordered_map)
{
	printf("in CPPOPS_CPPTYPES number__hash_ref__stringify(), top of subroutine\n");

	ostringstream output_stream;
	number__hash_ref__const_iterator i;
    bool i_is_0 = 1;
    string key_string;
    size_t key_string_pos;

	output_stream.precision(std::numeric_limits<double>::digits10);
	output_stream << '{';

	for (i = input_unordered_map.begin();  i != input_unordered_map.end();  ++i)
	{
		if (i_is_0) { i_is_0 = 0; } else { output_stream << ", "; }

		// escape all back-slash \ and single-quote ' characters with a back-slash \ character
		key_string = i->first;
		key_string_pos = 0;
		while((key_string_pos = key_string.find("\\", key_string_pos)) != string::npos)
		{
			key_string.replace(key_string_pos, 1, "\\\\");
			key_string_pos += 2;
		}
		key_string_pos = 0;
		while((key_string_pos = key_string.find("'", key_string_pos)) != string::npos)
		{
			key_string.replace(key_string_pos, 1, "\\'");
			key_string_pos += 2;
		}

//		output_stream << "'" << (i->first).c_str() << "' => " << i->second;
		output_stream << "'" << key_string.c_str() << "' => " << i->second;
	}

	output_stream << '}';

	printf("in CPPOPS_CPPTYPES number__hash_ref__stringify(), after for() loop, have output_stream =\n%s\n", (char*)(output_stream.str().c_str()));
	printf("in CPPOPS_CPPTYPES number__hash_ref__stringify(), bottom of subroutine\n");

	return(output_stream.str());
}


// convert from (C++ std::unordered_map of std::strings) to Perl-parsable (C++ std::string)
string string__hash_ref__stringify(string__hash_ref input_unordered_map)
{
	printf("in CPPOPS_CPPTYPES string__hash_ref__stringify(), top of subroutine\n");

	string output_string;
	string__hash_ref__const_iterator i;
    bool i_is_0 = 1;
    string key_string;
    size_t key_string_pos;
    string value_string;
    size_t value_string_pos;

	output_string = "{";

	for (i = input_unordered_map.begin();  i != input_unordered_map.end();  ++i)
	{
		if (i_is_0) { i_is_0 = 0; } else { output_string += ", "; }

		// escape all back-slash \ and single-quote ' characters with a back-slash \ character
		key_string = i->first;
		key_string_pos = 0;
		while((key_string_pos = key_string.find("\\", key_string_pos)) != string::npos)
		{
			key_string.replace(key_string_pos, 1, "\\\\");
			key_string_pos += 2;
		}
		key_string_pos = 0;
		while((key_string_pos = key_string.find("'", key_string_pos)) != string::npos)
		{
			key_string.replace(key_string_pos, 1, "\\'");
			key_string_pos += 2;
		}

		// and again
		value_string = i->second;
		value_string_pos = 0;
		while((value_string_pos = value_string.find("\\", value_string_pos)) != string::npos)
		{
			value_string.replace(value_string_pos, 1, "\\\\");
			value_string_pos += 2;
		}
		value_string_pos = 0;
		while((value_string_pos = value_string.find("'", value_string_pos)) != string::npos)
		{
			value_string.replace(value_string_pos, 1, "\\'");
			value_string_pos += 2;
		}

//		output_string += "'" + (string)(i->first).c_str() + "' => '" + (string)(i->second) + "'";
		output_string += "'" + key_string + "' => '" + value_string + "'";
	}

	output_string += "}";

	printf("in CPPOPS_CPPTYPES string__hash_ref__stringify(), after for() loop, have output_string =\n%s\n", output_string.c_str());
	printf("in CPPOPS_CPPTYPES string__hash_ref__stringify(), bottom of subroutine\n");

	return(output_string);
}

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* integer__hash_ref__typetest0(SV* lucky_integers)
{
//	hash_ref__CHECK(lucky_integers);
	hash_ref__CHECKTRACE(lucky_integers, "lucky_integers", "integer__hash_ref__typetest0()");
	HV* lucky_integers_deref = (HV*)SvRV(lucky_integers);
	integer how_lucky = hv_iterinit(lucky_integers_deref);
	integer i;

	for (i = 0;  i < how_lucky;  ++i)
	{
		HE* lucky_integer_entry = hv_iternext(lucky_integers_deref);
//		hash_entry__CHECK(lucky_integer_entry);
		hash_entry__CHECKTRACE(lucky_integer_entry, "lucky_integer_entry", "integer__hash_ref__typetest0()");

		// DEV NOTE: not using lucky_number variable as in Hash.pm
//		integer__CHECK(hv_iterval(lucky_integers_deref, lucky_integer_entry));
		integer__CHECKTRACE(hv_iterval(lucky_integers_deref, lucky_integer_entry), (char*)((string)"hv_iterval(lucky_integers_deref, lucky_integer_entry) at key '" + (string)SvPV_nolen(hv_iterkeysv(lucky_integer_entry)) + "'").c_str(), "integer__hash_ref__typetest0()");

		printf("in CPPOPS_PERLTYPES integer__hash_ref__typetest0(), have lucky integer '%s' => %d, BARSTOOL\n",
			SvPV_nolen(hv_iterkeysv(lucky_integer_entry)), (integer)SvIV(hv_iterval(lucky_integers_deref, lucky_integer_entry)));
	}

	return(newSVpvf("%s%s", SvPV_nolen(integer__hash_ref__stringify(lucky_integers)), "CPPOPS_PERLTYPES"));
}


SV* integer__hash_ref__typetest1(SV* my_size)
{
//	integer__CHECK(my_size);
	integer__CHECKTRACE(my_size, "my_size", "integer__hash_ref__typetest1()");
	HV* output_hv = newHV();
	integer i;
	char temp_key[30];

	for (i = 0;  i < SvIV(my_size);  ++i)
	{
		sprintf(temp_key, "CPPOPS_PERLTYPES_funkey%d", i);
		hv_store(output_hv, (const char*)temp_key, (U32)strlen(temp_key), newSViv(i * 5), (U32)0);
		printf("in CPPOPS_PERLTYPES integer__hash_ref__typetest1(), setting entry '%s' => %d, BARBAT\n",
				temp_key, (integer)SvIV(*hv_fetch(output_hv, (const char*)temp_key, (U32)strlen(temp_key), (I32)0)));
	}

	return(newRV_noinc((SV*) output_hv));
}


SV* number__hash_ref__typetest0(SV* lucky_numbers)
{
//	hash_ref__CHECK(lucky_numbers);
	hash_ref__CHECKTRACE(lucky_numbers, "lucky_numbers", "number__hash_ref__typetest0()");
	HV* lucky_numbers_deref = (HV*)SvRV(lucky_numbers);
	integer how_lucky = hv_iterinit(lucky_numbers_deref);
	integer i;

	for (i = 0;  i < how_lucky;  ++i)
	{
		HE* lucky_number_entry = hv_iternext(lucky_numbers_deref);
//		hash_entry__CHECK(lucky_number_entry);
		hash_entry__CHECKTRACE(lucky_number_entry, "lucky_number_entry", "number__hash_ref__typetest0()");

//		number__CHECK(hv_iterval(lucky_numbers_deref, lucky_number_entry));
		number__CHECKTRACE(hv_iterval(lucky_numbers_deref, lucky_number_entry), (char*)((string)"hv_iterval(lucky_numbers_deref, lucky_number_entry) at key '" + (string)SvPV_nolen(hv_iterkeysv(lucky_number_entry)) + "'").c_str(), "number__hash_ref__typetest0()");

		printf("in CPPOPS_PERLTYPES number__hash_ref__typetest0(), have lucky number '%s' => %Lf, BARSTOOP\n",
			SvPV_nolen(hv_iterkeysv(lucky_number_entry)), (long double)SvNV(hv_iterval(lucky_numbers_deref, lucky_number_entry)));
	}

	return(newSVpvf("%s%s", SvPV_nolen(number__hash_ref__stringify(lucky_numbers)), "CPPOPS_PERLTYPES"));
}


SV* number__hash_ref__typetest1(SV* my_size)
{
//	integer__CHECK(my_size);
	integer__CHECKTRACE(my_size, "my_size", "number__hash_ref__typetest1()");
	HV* output_hv = newHV();
	integer i;
	char temp_key[30];

	for (i = 0;  i < SvIV(my_size);  ++i)
	{
		sprintf(temp_key, "CPPOPS_PERLTYPES_funkey%d", i);
		hv_store(output_hv, (const char*)temp_key, (U32)strlen(temp_key), newSVnv(i * 5.123456789), (U32)0);
		printf("in CPPOPS_PERLTYPES number__hash_ref__typetest1(), setting entry '%s' => %Lf, BARTAB\n",
				temp_key, (long double)SvNV(*hv_fetch(output_hv, (const char*)temp_key, (U32)strlen(temp_key), (I32)0)));
	}

	return(newRV_noinc((SV*) output_hv));
}


SV* string__hash_ref__typetest0(SV* people)
{
//	hash_ref__CHECK(people);
	hash_ref__CHECKTRACE(people, "people", "string__hash_ref__typetest0()");
	HV* people_deref = (HV*)SvRV(people);
	integer how_crowded = hv_iterinit(people_deref);
	integer i;

	for (i = 0;  i < how_crowded;  ++i)
	{
		HE* person_entry = hv_iternext(people_deref);
//		hash_entry__CHECK(person_entry);
		hash_entry__CHECKTRACE(person_entry, "person_entry", "string__hash_ref__typetest0()");

//		string__CHECK(hv_iterval(people_deref, person_entry));
		string__CHECKTRACE(hv_iterval(people_deref, person_entry), (char*)((string)"hv_iterval(people_deref, person_entry) at key '" + (string)SvPV_nolen(hv_iterkeysv(person_entry)) + "'").c_str(), "string__hash_ref__typetest0()");

		printf("in CPPOPS_PERLTYPES string__hash_ref__typetest0(), have person '%s' => '%s', BARSPOON\n",
			(char*)SvPV_nolen(hv_iterkeysv(person_entry)), (char*)SvPV_nolen(hv_iterval(people_deref, person_entry)));
	}

	return(newSVpvf("%s%s", SvPV_nolen(string__hash_ref__stringify(people)), "CPPOPS_PERLTYPES"));
}


SV* string__hash_ref__typetest1(SV* my_size)
{
//	integer__CHECK(my_size);
	integer__CHECKTRACE(my_size, "my_size", "string__hash_ref__typetest1()");
	HV* people = newHV();
	integer i;
	char temp_key[30];

	for (i = 0;  i < SvIV(my_size);  ++i)
	{
		sprintf(temp_key, "CPPOPS_PERLTYPES_Luker_key%d", i);
		hv_store(people, (const char*)temp_key, (U32)strlen(temp_key), newSVpvf("Jeffy Ten! %d/%d", i, (int)(SvIV(my_size) - 1)), (U32)0);
		printf("in CPPOPS_PERLTYPES string__hash_ref__typetest1(), have temp_key = '%s', just set another Jeffy, BARTAT\n", temp_key);
	}

	return(newRV_noinc((SV*) people));
}

# elif defined __CPP__TYPES

string integer__hash_ref__typetest0(integer__hash_ref lucky_integers) { integer__hash_ref__const_iterator i;  for (i = lucky_integers.begin();  i != lucky_integers.end();  ++i) { printf("in CPPOPS_CPPTYPES integer__hash_ref__typetest0(), have lucky integer '%s' => %d, BARSTOOL\n", (i->first).c_str(), i->second); }  return(integer__hash_ref__stringify(lucky_integers) + "CPPOPS_CPPTYPES"); }
integer__hash_ref integer__hash_ref__typetest1(integer my_size) { integer__hash_ref new_unordered_map(my_size);  integer i;  string temp_key;  for (i = 0;  i < my_size;  ++i) { temp_key = "CPPOPS_CPPTYPES_funkey" + std::to_string(i);  new_unordered_map[temp_key] = i * 5;  printf("in CPPOPS_CPPTYPES integer__hash_ref__typetest1(), setting entry '%s' => %d, BARSTOOL\n", temp_key.c_str(), new_unordered_map[temp_key]); }  return(new_unordered_map); }

string number__hash_ref__typetest0(number__hash_ref lucky_numbers) { number__hash_ref__const_iterator i;  for (i = lucky_numbers.begin();  i != lucky_numbers.end();  ++i) { printf("in CPPOPS_CPPTYPES number__hash_ref__typetest0(), have lucky number '%s' => %Lf, BARSTOOL\n", (i->first).c_str(), i->second); }  return(number__hash_ref__stringify(lucky_numbers) + "CPPOPS_CPPTYPES"); }
number__hash_ref number__hash_ref__typetest1(integer my_size) { number__hash_ref new_unordered_map(my_size);  integer i;  string temp_key;  for (i = 0;  i < my_size;  ++i) { temp_key = "CPPOPS_CPPTYPES_funkey" + std::to_string(i);  new_unordered_map[temp_key] = i * 5.123456789;  printf("in CPPOPS_CPPTYPES number__hash_ref__typetest1(), setting entry '%s' => %Lf, BARSTOOL\n", temp_key.c_str(), new_unordered_map[temp_key]); }  return(new_unordered_map); }

string string__hash_ref__typetest0(string__hash_ref people) { string__hash_ref__const_iterator i;  for (i = people.begin();  i != people.end();  ++i) { printf("in CPPOPS_CPPTYPES string__hash_ref__typetest0(), have person '%s' => '%s', STARBOOL\n", (i->first).c_str(), (i->second).c_str()); }  return(string__hash_ref__stringify(people) + "CPPOPS_CPPTYPES"); }
string__hash_ref string__hash_ref__typetest1(integer my_size) { string__hash_ref people;  integer i;  people.reserve((size_t)my_size);  for (i = 0;  i < my_size;  ++i) { people["CPPOPS_CPPTYPES_Luker_key" + std::to_string(i)] = "Jeffy Ten! " + std::to_string(i) + "/" + std::to_string(my_size - 1); printf("in CPPOPS_CPPTYPES string__hash_ref__typetest1(), bottom of for() loop, have i = %d, just set another Jeffy!\n", i); }  return(people); }

# endif

#endif

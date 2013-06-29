////use strict;  use warnings;

#include "/tmp/RPerl-latest/lib/RPerl/DataStructure/Array.h"		// -> ???
//	#include <RPerl/DataStructure/Array.h>

using std::cout;  using std::endl;

/*
 * NEED FIX, CORRELATION #02: bug, possibly in Inline, causing inability to declare 3rd count_FOO argument to T_PACKEDARRAY;
 * temporarily fixed by changing typemap to set char** to T_PACKED;
 * may need Inline to add declaration of count_FOO to PREINIT section of auto-generated XS code
 *
 * eval_469_2d18.c: In function ‘void XS_main_XS_unpack_charPtrPtr(PerlInterpreter*, CV*)’:
 * eval_469_2d18.c:1322:36: error: ‘count_charPtrPtr’ was not declared in this scope
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
	printf("in XS_unpack_int__array_ref(), have input_av_index_max = '%d'\n", input_av_index_max);

	// DEV NOTE: VECTOR ELEMENT ASSIGNMENT OPTION information is not specific to this subroutine or packing/unpacking

	// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// resize() ahead of time to allow l-value subscript notation
	output_vector.resize((size_t)(input_av_index_max + 1));

	// VECTOR ELEMENT ASSIGNMENT, OPTION C, PUSH, KNOWN SIZE: vector has programmer-provided const size or compiler-guessable size,
	// reserve() ahead of time to avoid memory reallocation(s) (aka change in vector capacity) during element copying in for() loop
//	output_vector.reserve((size_t)(input_av_index_max + 1));

	// VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE: no calls to resize() means we can save output_vector.begin() for re-use in the for() loop
//	output_vector.reserve((size_t)(input_av_index_max + 1));
//	int__array_ref__iterator output_vector_begin = output_vector.begin();

	for (i = 0;  i <= input_av_index_max;  ++i)
	{
		// utilizes i in element retrieval
		input_av_element = av_fetch(input_av, i, 0);

		if (input_av_element != NULL)
		{
			// VECTOR ELEMENT ASSIGNMENT, OPTION A, SUBSCRIPT, KNOWN SIZE: l-value subscript notation with no further resize(); utilizes i in assignment
			if (SvIOKp(*input_av_element)) { output_vector[i] = SvIV(*input_av_element); }

			// VECTOR ELEMENT ASSIGNMENT, OPTION B, SUBSCRIPT, UNKNOWN SIZE: unpredictable value of i and thus unpredictable vector size,
			// call resize() every time we use l-value subscript; utilizes i in assignment
//			if (SvIOKp(*input_av_element)) { output_vector.resize((size_t)(i + 1));  output_vector[i] = SvIV(*input_av_element); }

			// VECTOR ELEMENT ASSIGNMENT, OPTIONS C & D, PUSH, KNOWN & UNKNOWN SIZE: push_back() calls resize(); does not utilize i in assignment
//			if (SvIOKp(*input_av_element)) { output_vector.push_back(SvIV(*input_av_element)); }

			// VECTOR ELEMENT ASSIGNMENT, OPTION E, ITERATOR, KNOWN SIZE: insert() with no further resize(); utilizes i in assignment
//			if (SvIOKp(*input_av_element)) { output_vector.insert((i + output_vector_begin), SvIV(*input_av_element)); }

			// VECTOR ELEMENT ASSIGNMENT, OPTION F, ITERATOR, UNKNOWN SIZE: unpredictable value of i and thus unpredictable vector size,
			// call resize() every time we use insert(); utilizes i in assignment
//			if (SvIOKp(*input_av_element)) { output_vector.resize((size_t)i);  output_vector.insert((i + output_vector.begin()), SvIV(*input_av_element)); }

			else { croak("in XS_unpack_int__array_ref(), input_av_element %d was not an int", i); }
		}
		else { croak("in XS_unpack_int__array_ref(), input_av_element %d was undef and/or NULL", i); }
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

	printf("in XS_pack_int__array_ref(), have input_vector_length = '%d'\n", input_vector_length);

	if (input_vector_length > 0) { for (i = 0;  i < input_vector_length;  ++i) { av_push(output_av, newSViv(input_vector[i])); } }
	else warn("in XS_pack_int__array_ref(), array was empty, returning empty array via newAV()");

	temp_sv_pointer = newSVrv(output_av_ref, NULL);	  // upgrade output stack SV to an RV
	SvREFCNT_dec(temp_sv_pointer);		 // discard temporary pointer
	SvRV(output_av_ref) = (SV*)output_av;	   // make output stack RV point at our output AV

	printf("in XS_pack_int__array_ref(), bottom of subroutine\n");
}


// CODE FROM: Dean Roehrich's Perl API Cookbook A
// LICENSE: none???
// http://search.cpan.org/~dmr/CookBookA-19960430/
// http://cpansearch.perl.org/src/DMR/CookBookA-19960430/Ex8/Av_CharPtrPtr.c
// ALL CODE COPIED VERBATIM EXCEPT WHERE NOTED

// [[[ BEGIN ORIGINAL CODE droehrich ]]]
// [[[ BEGIN ORIGINAL CODE droehrich ]]]
// [[[ BEGIN ORIGINAL CODE droehrich ]]]

// Used by the INPUT typemap for char**.
// Will convert a Perl AV* (containing strings) to a C char**.
//char ** XS_unpack_charPtrPtr( rv ) SV *rv;  // ORIGINAL CODE droehrich
//char **XS_unpack_charPtrPtr(SV *rv)  // MODIFIED CODE
string__array_ref XS_unpack_string__array_ref ( SV *rv )  // MODIFIED CODE
{
	printf("in XS_unpack_charPtrPtr(), top of subroutine\n");

	AV *av;
	SV **ssv;
//	char **s;
	string__array_ref s;
	int avlen;
	int x;

	if( SvROK( rv ) && (SvTYPE(SvRV(rv)) == SVt_PVAV) )
		av = (AV*)SvRV(rv);
	else {
		warn("XS_unpack_charPtrPtr: rv was not an AV ref");
//		return( (char**)NULL );
		return( (string__array_ref)NULL );
	}

	// is it empty?
	avlen = av_len(av);
	if( avlen < 0 ){
		warn("XS_unpack_charPtrPtr: array was empty");
//		return( (char**)NULL );
		return( (string__array_ref)NULL );
	}

	// av_len+2 == number of strings, plus 1 for an end-of-array sentinel.
//	s = (char **)safemalloc( sizeof(char*) * (avlen + 2) );
	s = (string__array_ref)safemalloc( sizeof(char*) * (avlen + 2) );
	if( s == NULL ){
		warn("XS_unpack_charPtrPtr: unable to malloc char**");
//		return( (char**)NULL );
		return( (string__array_ref)NULL );
	}
	for( x = 0; x <= avlen; ++x ){
		ssv = av_fetch( av, x, 0 );
		if( ssv != NULL ){
			if( SvPOK( *ssv ) ){
				s[x] = (char *)safemalloc( SvCUR(*ssv) + 1 );
				if( s[x] == NULL )
					warn("XS_unpack_charPtrPtr: unable to malloc char*");
				else
//					strcpy( s[x], SvPV( *ssv, na ) );  // ORIGINAL CODE droehrich
					strcpy( s[x], SvPV( *ssv, PL_na ) );  // MODIFIED CODE
			}
			else
				warn("XS_unpack_charPtrPtr: array elem %d was not a string.", x );
		}
		else
			s[x] = (char*)NULL;
	}
	s[x] = (char*)NULL; // sentinel

	printf("in XS_unpack_charPtrPtr(), bottom of subroutine\n");

	return( s );
}

// [[[ END ORIGINAL CODE droehrich ]]]
// [[[ END ORIGINAL CODE droehrich ]]]
// [[[ END ORIGINAL CODE droehrich ]]]


// CODE FROM: Foswiki
// LICENSE: GPL
// http://foswiki.org/
// ALL CODE COPIED VERBATIM EXCEPT WHERE NOTED

// [[[ BEGIN ORIGINAL CODE foswiki ]]]
// [[[ BEGIN ORIGINAL CODE foswiki ]]]
// [[[ BEGIN ORIGINAL CODE foswiki ]]]

// Convert a char** to a Perl AV*, freeing the char** and the strings
// stored in it.  The function name is dictated by the mapping in the
// default typemap i.e. (char** -> T_PACKEDARRAY -> XS_pack_charPtrPtr
//void XS_pack_charPtrPtr(SV* st, char **s, int n)  // ORIGINAL CODE foswiki
//void XS_pack_charPtrPtr(SV* st, char **s, int count_charPtrPtr)  // MODIFIED CODE
//void XS_pack_charPtrPtr(SV* st, char **s)  // MODIFIED CODE
void XS_pack_string__array_ref(SV* st, string__array_ref s)  // MODIFIED CODE
//static void XS_pack_charPtrPtr(st, s, count_charPtrPtr) SV *st;  char **s;  UV count_charPtrPtr;  // MODIFIED CODE
//static void XS_pack_charPtrPtr(SV *st, char **s, UV count_charPtrPtr)  // MODIFIED CODE
{
	printf("in XS_pack_charPtrPtr(), top of subroutine\n");

	AV *av = newAV();
//	UV count_charPtrPtr = 99;  // MODIFIED CODE

	if (s) {
//		char **c;
		string__array_ref c;
		for (c = s; *c; c++) {
			SV * sv = newSVpv(*c, 0);
			av_push(av, sv);
			free(*c);
		}
		free(s);
	}

	SV * sv = newSVrv(st, NULL);	  // upgrade stack SV to an RV
	SvREFCNT_dec(sv);		 // discard
	SvRV(st) = (SV*)av;	   // make stack RV point at our AV

	printf("in XS_pack_charPtrPtr(), bottom of subroutine\n");
}

// [[[ END ORIGINAL CODE foswiki ]]]
// [[[ END ORIGINAL CODE foswiki ]]]
// [[[ END ORIGINAL CODE foswiki ]]]


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
void typetest___int__in___void__out(int fuzznum) { printf("in C CPP_TYPES Array::typetest___int__in___void__out(), have fuzznum '%d', BOOFAZ\n", fuzznum); }  // CPP_TYPES
void typetest___int__array_ref__in___void__out(int__array_ref lucky_numbers) { int how_lucky = lucky_numbers.size();  int i;  for (i = 0;  i < how_lucky;  i++) { printf("in C CPP_TYPES Array::typetest___int__array_ref__in___void__out(), have lucky number %d/%d = '%d', BARBAT\n", i, (how_lucky - 1), lucky_numbers[i]); } }  // CPP_TYPES
int__array_ref typetest___int__in___int__array_ref__out(int my_size) { int__array_ref new_vec(my_size);  int i;  for (i = 0;  i < my_size;  i++) { new_vec[i] = i * 5;  printf("in C CPP_TYPES Array::typetest___int__in___int__array_ref__out(), setting element %d/%d = '%d', BARBAT\n", i, (my_size - 1), new_vec[i]); }  return(new_vec); }  // CPP_TYPES

void typetest___string__in___void__out(char* fuzzword) { printf("in C CPP_TYPES Array::typetest___string__in___void__out(), have fuzzword '%s', BAZBOT\n", fuzzword); }  // CPP_TYPES
//our void $typetest___string__array_ref__in___void__out = sub { (my string__array_ref $people) = @_;  for (my int $i = 0;  $i < @{$people};  $i++) { print "in Perl Inefficient::typetest___string__array_ref__in___void__out(), have person $i = '" . $people->[$i] . "', FOOBAZ\n"; } };  // PERL_TYPES
void typetest___string__array_ref__in___void__out(string__array_ref people) { char **person;  int i = 0;  for (person = people;  *person;  person++ ) { printf("in C CPP_TYPES Array::typetest___string__array_ref__in___void__out(), have person %d = '%s', FOOBAZ\n", i, *person);  i++; } }  // CPP_TYPES

string__array_ref typetest___void__in___string__array_ref__out()
{
	char **people;
	int i;
	const int num_people = 5;
	const int num_person = 10;

	people = (char **)safemalloc( sizeof(char*) * (num_people + 1) );

	if (people == NULL) { croak("in C Inefficient::typetest___void__in___string__array_ref__out(), unable to malloc char**"); }

	for (i = 0;  i < num_people;  i++)
	{
		people[i] = (char *)safemalloc( num_person + 1 );
		if( people[i] == NULL ) { croak("in C Inefficient::typetest___void__in___string__array_ref__out(), unable to malloc char*"); }

		// NEED ANSWER: why must we do a strcpy() here instead of just setting the element directly?
//		people[i] = (char *)"Jeffy Ten!";
		strcpy( people[i], (char *)"Jeffy " );
		people[i][6] = (char)(i + 48);
		people[i][7] = '/';
		people[i][8] = (char)((num_people - 1) + 48);
		people[i][9] = (char)NULL;

		printf("in C Inefficient::typetest___void__in___string__array_ref__out(), bottom of for() loop, have i = %d, just set another Jeffy!\n", i);
	}

	// DEV NOTE: all arrays must end in NULL sentinel as currently implemented by the pack and unpack subroutines
	people[i] = (char *)NULL;

	printf("in C Inefficient::typetest___void__in___string__array_ref__out(), bottom of subroutine\n");

	return(people);

} // CPP_TYPES

#endif
#define __CPP__INCLUDED__RPerl__DataStructure__Array_cpp 1

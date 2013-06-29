using std::cout;  using std::endl;

// TYPEDEFS
typedef std::vector<int> int__array_ref;
typedef std::vector<int>::iterator int__array_ref__iterator;
typedef std::vector<int>::const_iterator int__array_ref__const_iterator;

// PROTOTYPE DECLARATIONS
int__array_ref XS_unpack_int__array_ref(SV *input_av_ref);
void XS_pack_int__array_ref(SV *output, int__array_ref input);

// TESTING
void print___int__array_ref(int__array_ref input);
int__array_ref generate___int__array_ref(int generate_length);


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


// TESTING
void print___int__array_ref(int__array_ref input)
{
	printf("in print___int__array_ref(), top of subroutine\n");

	int j;
	int input_index_max = input.size() - 1;

	printf("[");

	for (j = 0;  j <= input_index_max;  ++j)
	{
//		printf("in print___int__array_ref(), have input[%d] = '%d'\n", j, input[j]);
		printf("%d", input[j]);
		if (j < input_index_max) { printf(", "); }
	}

	printf("]\n");

	printf("in print___int__array_ref(), bottom of subroutine\n");
}


// TESTING
int__array_ref generate__int__array_ref(int generate_length)
{
	printf("in generate__int__array_ref(), top of subroutine\n");

	int__array_ref generated_vector;
	int i;

	generated_vector.reserve(generate_length);

	for (i = 0;  i < generate_length;  ++i)
	{
		generated_vector.push_back(i * 5);
	}

	printf("in generate__int__array_ref(), bottom of subroutine\n");

	return(generated_vector);
}

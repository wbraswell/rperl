#include <vector>
using std::cout;  using std::endl;
typedef std::vector<int> int__array_ref;

// PROTOTYPE DECLARATIONS
int__array_ref XS_unpack_int__array_ref(SV *input_av_ref);
void XS_pack_int__array_ref(SV *output, int__array_ref input);


void print___int__array_ref(int__array_ref input);


// START HERE: work out arg naming convention in general, and vector init code below


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

//    int__array_ref output_vector((size_t)(input_av_index_max + 1));
    output_vector.reserve((size_t)(input_av_index_max + 1));

	for (i = 0;  i <= input_av_index_max;  i++)
	{
		input_av_element = av_fetch(input_av, i, 0);
		if (input_av_element != NULL)
		{
			// NEED ANSWER: is it correct to use SvIOKp() here instead of just SvIOK()?
//			if (SvIOKp(*input_av_element)) { output_vector[i] = SvIV(*input_av_element); }
			if (SvIOKp(*input_av_element)) { output_vector.push_back(SvIV(*input_av_element)); }
			else { croak("in XS_unpack_int__array_ref(), input_av_element %d was not an int", i); }
		}
		else { croak("in XS_unpack_int__array_ref(), input_av_element %d was undef and/or NULL", i); }
	}

	return(output_vector);
}

void XS_pack_int__array_ref(SV *output, int__array_ref input)
{
	croak("in XS_pack_int__array_ref(), I AM A STUB!!!\n");
}



void print___int__array_ref(int__array_ref input)
{
//	printf("in print___int__array_ref(), top of subroutine\n");
	int j;
	int input_index_max = input.size() - 1;

	printf("[");

	for (j = 0;  j <= input_index_max;  j++)
	{
//		printf("in print___int__array_ref(), have input[%d] = '%d'\n", j, input[j]);
		printf("%d", input[j]);
		if (j < input_index_max) { printf(", "); }
	}

	printf("]");
}




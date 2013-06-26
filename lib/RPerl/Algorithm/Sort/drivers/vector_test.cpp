#include <vector>
using std::cout;  using std::endl;


// START HERE: try to hide typedefs in vector_test.h, which would NOT be found by Inline::CPP as long as preprocessing is turned off, then try typemap again



// PROTOTYPE DECLARATIONS
void int_AV_to_int_vector(SV *input_av_ref);
void unbound_print_int_vector(std::vector<int> input_vector);


void int_AV_to_int_vector(SV *input_av_ref)
{
	printf("in int_AV_to_int_vector(), top of subroutine\n");
    AV* input_av;
    int input_av_length;
    int i;
    SV** input_av_element;
//    std::vector<int> output_vector;

	if (SvROK(input_av_ref) && (SvTYPE(SvRV(input_av_ref)) == SVt_PVAV)) { input_av = (AV*)SvRV(input_av_ref); }
	else { croak("in int_AV_to_int_vector(), input_av_ref was not an AV ref"); }

	input_av_length = av_len(input_av);
	printf("in int_AV_to_int_vector(), have input_av_length = '%d'\n", input_av_length);

    std::vector<int> output_vector((size_t)(input_av_length + 1));

	for (i = 0;  i <= input_av_length;  i++)
	{
		input_av_element = av_fetch(input_av, i, 0);
		if (input_av_element != NULL)
		{
			// NEED ANSWER: is it correct to use SvIOKp() here instead of just SvIOK()?
//			if (SvIOK(*input_av_element)) { output_vector[i] = SvIV(*input_av_element); }
			if (SvIOKp(*input_av_element)) { output_vector[i] = SvIV(*input_av_element); }
			else { croak("in int_AV_to_int_vector(), input_av_element %d was not an int", i); }
		}
		else { croak("in int_AV_to_int_vector(), input_av_element %d was undef and/or NULL", i); }
	}

	unbound_print_int_vector(output_vector);

	int j;
	int j_max;
	j_max = output_vector.size();
	printf("in int_AV_to_int_vector(), have j_max '%d'\n", j_max);

	for (j = 0;  j < j_max;  j++)
	{
		printf("in int_AV_to_int_vector(), have output_vector[%d] = '%d'\n", j, output_vector[j]);
	}

	printf("in int_AV_to_int_vector(), bottom of subroutine\n");
}


void unbound_print_int_vector(std::vector<int> input_vector)
{
	int j;

	for (j = 0;  j < input_vector.size();  j++)
	{
		printf("in unbound_print_int_vector(), have input_vector[%d] = '%d'\n", j, input_vector[j]);
	}
}

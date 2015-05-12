////# [[[ HEADER ]]]
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_cpp
#define __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_cpp 0.004_020

////# [[[ INCLUDES ]]]
#include <RPerl/Algorithm/Sort/Bubble.h>  // -> HelperFunctions.cpp && Sort.cpp && NOT Inefficient.cpp (NEED UPGRADE: multiple inheritance not currently supported by Inline::CPP)

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

////# [[[ OO METHODS ]]]

////# call out to sort integer_data, return nothing
////our void_method $integer_sort = sub {(my object $self) = @_;
void RPerl__Algorithm__Sort__Bubble::integer_sort()
////;
{
	if (RPERL_DEBUG2) { fprintf(stderr, "in integer_sort(), top of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(this->integer_data) = %u\n", SV_REFERENCE_COUNT(this->integer_data));  fprintf(stderr, "in integer_sort(), top of subroutine, have this->integer_data = %s", RPerl_DUMPER__perl_from_c(this->integer_data));  fprintf(stderr, "in integer_sort(), top of subroutine, have post-DUMPER SV_REFERENCE_COUNT(this->integer_data) = %u\n\n", SV_REFERENCE_COUNT(this->integer_data));  }

////	$self->{integer_data} = integer_bubblesort($self->{integer_data});
	this->integer_data = integer_bubblesort(this->integer_data);

	if (RPERL_DEBUG2) { fprintf(stderr, "in integer_sort(), bottom of subroutine, have pre-SvREFCNT_dec pre-DUMPER SV_REFERENCE_COUNT(this->integer_data) = %u\n", SV_REFERENCE_COUNT(this->integer_data));  fprintf(stderr, "in integer_sort(), bottom of subroutine, have pre-SvREFCNT_dec this->integer_data = %s", RPerl_DUMPER__perl_from_c(this->integer_data));  fprintf(stderr, "in integer_sort(), bottom of subroutine, have pre-SvREFCNT_dec post-DUMPER SV_REFERENCE_COUNT(this->integer_data) = %u\n\n", SV_REFERENCE_COUNT(this->integer_data));  }
	SvREFCNT_dec(this->integer_data);
	if (RPERL_DEBUG2) { fprintf(stderr, "in integer_sort(), bottom of subroutine, have post-SvREFCNT_dec pre-DUMPER SV_REFERENCE_COUNT(this->integer_data) = %u\n", SV_REFERENCE_COUNT(this->integer_data));  fprintf(stderr, "in integer_sort(), bottom of subroutine, have post-SvREFCNT_dec this->integer_data = %s", RPerl_DUMPER__perl_from_c(this->integer_data));  fprintf(stderr, "in integer_sort(), bottom of subroutine, have post-SvREFCNT_dec post-DUMPER SV_REFERENCE_COUNT(this->integer_data) = %u\n\n", SV_REFERENCE_COUNT(this->integer_data));  }
	if (RPERL_DEBUG2) { fprintf(stderr, "in integer_sort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(this->integer_data) = %u\n", SV_REFERENCE_COUNT(this->integer_data));  fprintf(stderr, "in integer_sort(), bottom of subroutine, have this->integer_data = %s", RPerl_DUMPER__perl_from_c(this->integer_data));  fprintf(stderr, "in integer_sort(), bottom of subroutine, post-DUMPER SV_REFERENCE_COUNT(this->integer_data) = %u\n\n", SV_REFERENCE_COUNT(this->integer_data));  }
////};
}

void RPerl__Algorithm__Sort__Bubble::number_sort()
{
	this->number_data = number_bubblesort(this->number_data);
	SvREFCNT_dec(this->number_data);
}

// OO INHERITANCE TESTING

////our void_method $inherited__Bubble = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Bubble->inherited__Bubble(), received \$self = '$self' and \$person = '$person', FRIED\n"; };
void RPerl__Algorithm__Sort__Bubble::inherited__Bubble(SV* person) { cout << "in CPPOPS_PERLTYPES Bubble->inherited__Bubble(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', FRIED\n"; }

////our void_method $inherited = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Bubble->inherited(), received \$self = '$self' and \$person = '$person', ILLOGICAL\n"; };
void RPerl__Algorithm__Sort__Bubble::inherited(SV* person) { cout << "in CPPOPS_PERLTYPES Bubble->inherited(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', ILLOGICAL\n"; }

////# [[[ SUBROUTINES ]]]

////# original algorithm: comparison-based and stable [O(n**2) average time, O(1) worst-case extra space]
////# sort data, return sorted data
////our integer_arrayref $integer_bubblesort = sub {(my integer_arrayref $data) = @_;
SV* integer_bubblesort(SV* integer_data)  // DEV NOTE: properly creates local-to-function SV* integer_data here, does not get confused with this->integer_data object property, even though they share a name
//void integer_bubblesort(SV* integer_data)  // TEMPORARY DEBUGGING
////;
{
//	dSP;
//	dSP;  PUSHMARK(SP);
//	dSP;  ENTER;  SAVETMPS;  PUSHMARK(SP);
//	Inline_Stack_Vars;

	RPerl_object_property_init(integer_data); // NEED ANSWER: why do we need to do property init?
	SvREFCNT_inc(integer_data);
//	fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of subroutine...\n");

//	integer_arrayref_CHECK(integer_data);
	integer_arrayref_CHECKTRACE(integer_data, "integer_data", "integer_bubblesort()");

//	if (RPERL_DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n", SV_REFERENCE_COUNT(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of subroutine, have integer_data = %s", RPerl_DUMPER__perl_from_c(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of subroutine, have post-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n\n", SV_REFERENCE_COUNT(integer_data)); }
////	my integer $is_sorted = 0;
	integer is_sorted = 0;
////	my integer $i;
	integer i;
////	my integer $integer_data_length = scalar(@{$integer_data});  # CONSTANT
//	integer integer_data_length = av_len((AV*) SvRV(integer_data)) + 1;  // DE-OPTIMIZE, SHORT-HAND
	AV* integer_data_av = (AV*) SvRV(integer_data);  // OPTIMIZE, LONG-HAND: integer_data dereferenced to integer_data_av more than once, declare integer_data_av and re-use, MUST REFRESH integer_data_av for every assignment directly to integer_data (none in this algorithm)
	integer integer_data_length = av_len(integer_data_av) + 1;  // OPTIMIZE, LONG-HAND: use integer_data_av
	SV* integer_data_i = newSV(0);  // OPTIMIZE, LONG-HAND: integer_data element i accessed more than once, declare integer_data_i and re-use;  all new SV*'s given initial undef newSV(0) value to avoid fprintf(stderr, ) errors during debugging
	SV* integer_data_i_plus_1 = newSV(0);  // OPTIMIZE, LONG-HAND

////	my scalartype $swap;
	SV* swap = newSV(0);

//	if (RPERL_DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(integer_data_i) = %u\n", SV_REFERENCE_COUNT(integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), after variable init, have integer_data_i = %s", RPerl_DUMPER__perl_from_c(integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(integer_data_i) = %u\n\n", SV_REFERENCE_COUNT(integer_data_i)); }
//	if (RPERL_DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n", SV_REFERENCE_COUNT(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), after variable init, have integer_data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n\n", SV_REFERENCE_COUNT(integer_data_i_plus_1)); }
//	if (RPERL_DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %u\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), after variable init, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(swap) = %u\n\n", SV_REFERENCE_COUNT(swap)); }

////#	RPerl::diag "in CPPOPS_PERLTYPES integer_bubblesort(), have \$integer_data_length = $integer_data_length\n";
//	 if (RPERL_DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), after variable init, have integer_data_length = %d\n", integer_data_length); }

////	# iterate through the length-n list up to n times (n * n == n**2), larger elements "bubble to the top" (end) of the list
////	while (not($is_sorted))
	while (not(is_sorted))
////	{
	{
////#		RPerl::diag "in CPPOPS_PERLTYPES integer_bubblesort(), top of while loop\n";
//		if (RPERL_DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop\n"); }
//		if (RPERL_DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n", SV_REFERENCE_COUNT(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have integer_data = %s", RPerl_DUMPER__perl_from_c(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n\n", SV_REFERENCE_COUNT(integer_data)); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_integer_data_i) = %u\n", SV_REFERENCE_COUNT(integer_integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have integer_integer_data_i = %s", RPerl_DUMPER__perl_from_c(integer_integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_integer_data_i) = %u\n\n", SV_REFERENCE_COUNT(integer_integer_data_i)); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n", SV_REFERENCE_COUNT(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have integer_data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n\n", SV_REFERENCE_COUNT(integer_data_i_plus_1)); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %u\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %u\n\n", SV_REFERENCE_COUNT(swap)); }

////		$is_sorted = 1;
		is_sorted = 1;
////		for ($i = 0; $i < ($integer_data_length - 1); $i++)
		for (i = 0; i < (integer_data_length - 1); i++)
////		{
		{
////#			RPerl::diag "in CPPOPS_PERLTYPES integer_bubblesort(), inside for() loop, have \$i = $i\n";
//			if (RPERL_DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have i = %d\n", i); }
////#			RPerl::diag "in CPPOPS_PERLTYPES integer_bubblesort(), inside for() loop, have \$integer_data\n" . RPerl::DUMPER($integer_data) . "\n";
//			if (RPERL_DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n", SV_REFERENCE_COUNT(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have integer_data = %s", RPerl_DUMPER__perl_from_c(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n\n", SV_REFERENCE_COUNT(integer_data)); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_data_i) = %u\n", SV_REFERENCE_COUNT(integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have integer_data_i = %s", RPerl_DUMPER__perl_from_c(integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_data_i) = %u\n\n", SV_REFERENCE_COUNT(integer_data_i)); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n", SV_REFERENCE_COUNT(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have integer_data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n\n", SV_REFERENCE_COUNT(integer_data_i_plus_1)); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %u\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %u\n\n", SV_REFERENCE_COUNT(swap)); }

////			# compare elements and swap if out-of-order, this is the core sort comparison
////			if ($integer_data->[$i] > $integer_data->[($i + 1)])
//			if (SvIV(AV_ELEMENT((AV*) SvRV(integer_data), i)) > SvIV(AV_ELEMENT((AV*) SvRV(integer_data), (i + 1))))  // DE-OPTIMIZE, SHORT-HAND
			integer_data_i = AV_ELEMENT(integer_data_av, i);  // OPTIMIZE, LONG-HAND: use integer_data_i and integer_data_av
			integer_data_i_plus_1 = AV_ELEMENT(integer_data_av, (i + 1));  // OPTIMIZE, LONG-HAND: use integer_data_i_plus_1 and integer_data_av

			// DEV NOTE: using C++ numeric greater-than comparator operator as direct replacement for equivalent Perl builtin operator
			if (SvIV(integer_data_i) > SvIV(integer_data_i_plus_1))  // OPTIMIZE, LONG-HAND: use integer_data_i and integer_data_i_plus_1
////			{
			{
////#				RPerl::diag "in CPPOPS_PERLTYPES integer_bubblesort(), inside for() loop, SWAPPED\n";
//				if (RPERL_DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), inside for() loop, SWAPPED\n"); }
////				$is_sorted = 0;
				is_sorted = 0;
////				$swap = $integer_data->[$i];
//				swap = AV_ELEMENT((AV*) SvRV(integer_data), i);  // DE-OPTIMIZE, SHORT-HAND
				integer_data_i = AV_ELEMENT(integer_data_av, i);  // OPTIMIZE, LONG-HAND: use integer_data_i and integer_data_av
				swap = integer_data_i;  // OPTIMIZE, LONG-HAND: use integer_data_i
////				$integer_data->[$i] = $integer_data->[($i + 1)];
//				av_store((AV*) SvRV(integer_data), i, SvREFCNT_inc(AV_ELEMENT((AV*) SvRV(integer_data), (i + 1))));  // DE-OPTIMIZE, SHORT-HAND
				integer_data_i_plus_1 = AV_ELEMENT(integer_data_av, (i + 1));  // OPTIMIZE, LONG-HAND: use integer_data_i_plus_1 and integer_data_av
				av_store(integer_data_av, i, SvREFCNT_inc(integer_data_i_plus_1));  // OPTIMIZE, LONG-HAND: use integer_data_av and integer_data_i_plus_1
////				$integer_data->[($i + 1)] = $swap;
//				av_store((AV*) SvRV(integer_data), (i + 1), SvREFCNT_inc(swap));  // DE-OPTIMIZE, SHORT-HAND
				av_store(integer_data_av, (i + 1), SvREFCNT_inc(swap));  // OPTIMIZE, LONG-HAND: use integer_data_av
////			}
			}
//			if (RPERL_DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n", SV_REFERENCE_COUNT(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have integer_data = %s", RPerl_DUMPER__perl_from_c(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n\n", SV_REFERENCE_COUNT(integer_data)); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_data_i) = %u\n", SV_REFERENCE_COUNT(integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have integer_data_i = %s", RPerl_DUMPER__perl_from_c(integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_data_i) = %u\n\n", SV_REFERENCE_COUNT(integer_data_i)); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n", SV_REFERENCE_COUNT(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have integer_data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n\n", SV_REFERENCE_COUNT(integer_data_i_plus_1)); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %u\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %u\n\n", SV_REFERENCE_COUNT(swap)); }
////		}
		}
//		if (RPERL_DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n", SV_REFERENCE_COUNT(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have integer_data = %s", RPerl_DUMPER__perl_from_c(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n\n", SV_REFERENCE_COUNT(integer_data)); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_data_i) = %u\n", SV_REFERENCE_COUNT(integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have integer_data_i = %s", RPerl_DUMPER__perl_from_c(integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_data_i) = %u\n\n", SV_REFERENCE_COUNT(integer_data_i)); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n", SV_REFERENCE_COUNT(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have integer_data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n\n", SV_REFERENCE_COUNT(integer_data_i_plus_1)); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %u\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %u\n\n", SV_REFERENCE_COUNT(swap)); }
////	}
	}

//	SvREFCNT_inc(integer_data);
//	if (RPERL_DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n", SV_REFERENCE_COUNT(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have integer_data = %s", RPerl_DUMPER__perl_from_c(integer_data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(integer_data) = %u\n\n", SV_REFERENCE_COUNT(integer_data)); }
//	if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(integer_data_i) = %u\n", SV_REFERENCE_COUNT(integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have integer_data_i = %s", RPerl_DUMPER__perl_from_c(integer_data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(integer_data_i) = %u\n\n", SV_REFERENCE_COUNT(integer_data_i)); }
//	if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n", SV_REFERENCE_COUNT(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have integer_data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer_data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(integer_data_i_plus_1) = %u\n\n", SV_REFERENCE_COUNT(integer_data_i_plus_1)); }
//	if (RPERL_DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %u\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(swap) = %u\n\n", SV_REFERENCE_COUNT(swap)); }

////	# integer_data is now sorted via top-level nested iteration [O(n**2) total time, O(1) total extra space]
////	return $integer_data;
//	SvREFCNT_dec(integer_data);

//	Inline_Stack_Vars;
//	Inline_Stack_Reset;
//	Inline_Stack_Push(integer_data);
//	Inline_Stack_Done;

//	PUTBACK;
//	PUTBACK;  FREETMPS;  LEAVE;
	return(integer_data);
////};
}

SV* number_bubblesort(SV* number_data)
{
	RPerl_object_property_init(number_data);
	SvREFCNT_inc(number_data);
//	fprintf(stderr, "in CPPOPS_PERLTYPES number_bubblesort(), top of subroutine...\n");

//	number_arrayref_CHECK(number_data);
	number_arrayref_CHECKTRACE(number_data, "number_data", "number_bubblesort()");

	integer is_sorted = 0;
	integer i;
	AV* number_data_av = (AV*) SvRV(number_data);
	integer number_data_length = av_len(number_data_av) + 1;
	SV* number_data_i = newSV(0);
	SV* number_data_i_plus_1 = newSV(0);

	SV* swap = newSV(0);
	while (not(is_sorted))
	{
		is_sorted = 1;
		for (i = 0; i < (number_data_length - 1); i++)
		{
			number_data_i = AV_ELEMENT(number_data_av, i);
			number_data_i_plus_1 = AV_ELEMENT(number_data_av, (i + 1));

			if (SvNV(number_data_i) > SvNV(number_data_i_plus_1))
			{
				is_sorted = 0;
				number_data_i = AV_ELEMENT(number_data_av, i);
				swap = number_data_i;
				number_data_i_plus_1 = AV_ELEMENT(number_data_av, (i + 1));
				av_store(number_data_av, i, SvREFCNT_inc(number_data_i_plus_1));
				av_store(number_data_av, (i + 1), SvREFCNT_inc(swap));
			}
		}
	}
	return(number_data);
}

// OO INHERITANCE TESTING, CONTINUED

////our string $uninherited__Bubble = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Bubble::uninherited__Bubble(), received \$person = '$person', MITOCHONDRIAL\n"; return ('Bubble::uninherited__Bubble() RULES! PERLOPS_PERLTYPES'); };
SV* uninherited__Bubble(SV* person) { cout << "in CPPOPS_PERLTYPES Bubble::uninherited__Bubble(), received person = '" << SvPV_nolen(person) << "', MITOCHONDRIAL\n"; return(newSVpv("Bubble::uninherited__Bubble() RULES! CPPOPS_PERLTYPES", 0)); }

// DEV NOTE, CORRELATION #04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
////our string $uninherited = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Bubble::uninherited(), received \$person = '$person', TETRAHEDRON\n"; return ('Bubble::uninherited() ROCKS! PERLOPS_PERLTYPES'); };
SV* uninherited(SV* person) { cout << "in CPPOPS_PERLTYPES Bubble::uninherited(), received person = '" << SvPV_nolen(person) << "', TETRAHEDRON\n"; return(newSVpv("Bubble::uninherited() ROCKS! CPPOPS_PERLTYPES", 0)); }

// TYPE TESTING

SV* integer_bubblesort__typetest0(SV* lucky_integers)
{
//	dSP;  PUSHMARK(SP);  // DEV NOTE: necessary to avoid "panic: memory wrap" or messing up Perl stack in some cases, but not here!
//	integer_arrayref_CHECK(lucky_integers);
	integer_arrayref_CHECKTRACE(lucky_integers, "lucky_integers", "integer_bubblesort__typetest0()");
	/*
	AV* lucky_integers_deref = (AV*)SvRV(lucky_integers);
	integer how_lucky = av_len(lucky_integers_deref) + 1;
	integer i;
	for (i = 0;  i < how_lucky;  ++i)
	{
		fprintf(stderr, "in CPPOPS_PERLTYPES integer_bubblesort__typetest0(), have lucky_integer %d/%d = %d, BATBAR\n", i, (how_lucky - 1), (integer)SvIV(*av_fetch(lucky_integers_deref, i, 0)));
	}
	*/

//	SV* retval_integer_bubblesort = integer_bubblesort(lucky_integers);
//	SV* retval_integer_arrayref_to_string = integer_arrayref_to_string(retval_integer_bubblesort);
//	SV* retval_string = newSVpvf("%s%s", SvPV_nolen(retval_integer_arrayref_to_string), "CPPOPS_PERLTYPES");
//	return(retval_string);
//	return(newSVpvf("%s%s", SvPV_nolen(retval_integer_arrayref_to_string), "CPPOPS_PERLTYPES"));
//	return(newSVpvf("%s%s", SvPV_nolen(integer_arrayref_to_string(retval_integer_bubblesort)), "CPPOPS_PERLTYPES"));
	return(newSVpvf("%s%s", SvPV_nolen(integer_arrayref_to_string(integer_bubblesort(lucky_integers))), "CPPOPS_PERLTYPES"));
}

SV* number_bubblesort__typetest0(SV* lucky_numbers)
{
//	number_arrayref_CHECK(lucky_numbers);
	number_arrayref_CHECKTRACE(lucky_numbers, "lucky_numbers", "number_bubblesort__typetest0()");
	/*
	AV* lucky_numbers_deref = (AV*)SvRV(lucky_numbers);
	integer how_lucky = av_len(lucky_numbers_deref) + 1;
	integer i;
	for (i = 0;  i < how_lucky;  ++i)
	{
		fprintf(stderr, "in CPPOPS_PERLTYPES number_bubblesort__typetest0(), have lucky_number %d/%d = %Lf, BATBAR\n", i, (how_lucky - 1), (number)SvNV(*av_fetch(lucky_numbers_deref, i, 0)));
	}
	*/

	return(newSVpvf("%s%s", SvPV_nolen(number_arrayref_to_string(number_bubblesort(lucky_numbers))), "CPPOPS_PERLTYPES"));
}

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

////# [[[ OO METHODS ]]]

////# call out to sort integer_data, return nothing
////our void_method $integer_sort = sub {(my object $self) = @_;
void RPerl__Algorithm__Sort__Bubble::integer_sort()
////;
{
	if (RPERL_DEBUG2) { fprintf(stderr, "in integer_sort(), top of subroutine, have this->integer_data = %s\n", integer_arrayref_to_string(this->integer_data).c_str()); }

////	$self->{integer_data} = integer_bubblesort($self->{integer_data});
	this->integer_data = integer_bubblesort(this->integer_data);

	if (RPERL_DEBUG2) { fprintf(stderr, "in integer_sort(), bottom of subroutine, have this->integer_data = %s\n", integer_arrayref_to_string(this->integer_data).c_str()); }
////};
}

void RPerl__Algorithm__Sort__Bubble::number_sort()
{
	this->number_data = number_bubblesort(this->number_data);
}

// OO INHERITANCE TESTING

////our void_method $inherited__Bubble = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Bubble->inherited__Bubble(), received \$self = '$self' and \$person = '$person', FRIED\n"; };
void RPerl__Algorithm__Sort__Bubble::inherited__Bubble(string person) { cout << "in CPPOPS_CPPTYPES Bubble->inherited__Bubble(), received this = '" << this << "' and person = '" << person << "', FRIED\n"; }

////our void_method $inherited = sub { ( my object $self, my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Bubble->inherited(), received \$self = '$self' and \$person = '$person', ILLOGICAL\n"; };
void RPerl__Algorithm__Sort__Bubble::inherited(string person) { cout << "in CPPOPS_CPPTYPES Bubble->inherited(), received this = '" << this << "' and person = '" << person << "', ILLOGICAL\n"; }

////# [[[ SUBROUTINES ]]]

////# original algorithm: comparison-based and stable [O(n**2) average time, O(1) worst-case extra space]
////# sort integer_data, return sorted integer_data
////our integer_arrayref $integer_bubblesort = sub {(my integer_arrayref $integer_data) = @_;
integer_arrayref integer_bubblesort(integer_arrayref integer_data)  // DEV NOTE: properly creates local-to-function integer_arrayref integer_data here, does not get confused with this->integer_data object property, even though they share a name
////;
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES integer_bubblesort, top of subroutine...\n");
//	if (RPERL_DEBUG3) { fprintf(stderr, "in integer_bubblesort, top of subroutine, have integer_data = %d", integer_data); }
////	my integer $is_sorted = 0;
	integer is_sorted = 0;
////	my integer $i;
	integer i;
////	my integer $integer_data_length = scalar(@{$integer_data});  # CONSTANT
	integer integer_data_length = integer_data.size();
	integer integer_data_i = -9999;  // OPTIMIZE, LONG-HAND: integer_data element i accessed more than once, declare integer_data_i and re-use;  all new integer's given initial -9999 value to avoid fprintf(stderr, ) errors during debugging
	integer integer_data_i_plus_1 = -9999;  // OPTIMIZE, LONG-HAND

////	my integer $swap;
	integer swap = -9999;

//	if (RPERL_DEBUG2) { fprintf(stderr, "in integer_bubblesort, after variable init, have integer_data_i = %d\n", integer_data_i); }
//	if (RPERL_DEBUG2) { fprintf(stderr, "in integer_bubblesort, after variable init, have integer_data_i_plus_1 = %d\n", integer_data_i_plus_1); }
//	if (RPERL_DEBUG2) { fprintf(stderr, "in integer_bubblesort, after variable init, have swap = %d\n", swap); }

////#	RPerl::diag "in integer_bubblesort, have \$integer_data_length = $integer_data_length\n";
//	 if (RPERL_DEBUG2) { fprintf(stderr, "in integer_bubblesort, after variable init, have integer_data_length = %d\n", integer_data_length); }

////	# iterate through the length-n list up to n times (n * n == n**2), larger elements "bubble to the top" (end) of the list
////	while (not($is_sorted))
	while (not(is_sorted))
////	{
	{
////#		RPerl::diag "in integer_bubblesort, top of while loop\n";
//		if (RPERL_DEBUG2) { fprintf(stderr, "in integer_bubblesort, top of while() loop\n"); }
//		if (RPERL_DEBUG3) { fprintf(stderr, "in integer_bubblesort, top of while() loop, have integer_data = %d\n", integer_data); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, top of while() loop, have integer_data_i = %d\n", integer_data_i); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, top of while() loop, have integer_data_i_plus_1 = %d\n", integer_data_i_plus_1); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, top of while() loop, have swap = %d\n", swap); }

////		$is_sorted = 1;
		is_sorted = 1;
////		for ($i = 0; $i < ($integer_data_length - 1); $i++)
		for (i = 0; i < (integer_data_length - 1); i++)
////		{
		{
////#			RPerl::diag "in integer_bubblesort, inside for() loop, have \$i = $i\n";
//			if (RPERL_DEBUG2) { fprintf(stderr, "in integer_bubblesort, top of for() loop, have i = %d\n", i); }
////#			RPerl::diag "in integer_bubblesort, inside for() loop, have \$integer_data\n" . RPerl::DUMPER($integer_data) . "\n";
//			if (RPERL_DEBUG3) { fprintf(stderr, "in integer_bubblesort, top of for() loop, have integer_data = %d\n", integer_data); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, top of for() loop, have integer_data_i = %d\n", integer_data_i); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, top of for() loop, have integer_data_i_plus_1 = %d\n", integer_data_i_plus_1); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, top of for() loop, have swap = %d\n", swap); }

////			# compare elements and swap if out-of-order, this is the core sort comparison
////			if ($integer_data->[$i] > $integer_data->[($i + 1)])
//			if (integer_data[i] > integer_data[(i + 1)])  // DE-OPTIMIZE, SHORT-HAND
			integer_data_i = integer_data[i];  // OPTIMIZE, LONG-HAND: use integer_data_i
			integer_data_i_plus_1 = integer_data[(i + 1)];  // OPTIMIZE, LONG-HAND: use integer_data_i_plus_1

			// DEV NOTE: integer_data is of type integer_arrayref, assuming numeric values for integer_data elements and using C++ numeric comparator
			if (integer_data_i > integer_data_i_plus_1)  // OPTIMIZE, LONG-HAND: use integer_data_i and integer_data_i_plus_1
////			{
			{
////#				RPerl::diag "in integer_bubblesort, inside for() loop, SWAPPED\n";
//				if (RPERL_DEBUG2) { fprintf(stderr, "in integer_bubblesort, inside for() loop, SWAPPED\n"); }
////				$is_sorted = 0;
				is_sorted = 0;
////				$swap = $integer_data->[$i];
//				swap = integer_data[i];  // DE-OPTIMIZE, SHORT-HAND
				swap = integer_data_i;  // OPTIMIZE, LONG-HAND: use integer_data_i
////				$integer_data->[$i] = $integer_data->[($i + 1)];
//				integer_data[i] = integer_data[(i + 1)];  // DE-OPTIMIZE, SHORT-HAND
				integer_data[i] = integer_data_i_plus_1;  // OPTIMIZE, LONG-HAND: use integer_data_i_plus_1
////				$integer_data->[($i + 1)] = $swap;
				integer_data[(i + 1)] = swap;
////			}
			}
//			if (RPERL_DEBUG3) { fprintf(stderr, "in integer_bubblesort, bottom of for() loop, have integer_data = %d\n", integer_data); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, bottom of for() loop, have integer_data_i = %d\n", integer_data_i); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, bottom of for() loop, have integer_data_i_plus_1 = %d\n", integer_data_i_plus_1); }
//			if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, bottom of for() loop, have swap = %d\n", swap); }
////		}
		}
//		if (RPERL_DEBUG3) { fprintf(stderr, "in integer_bubblesort, bottom of while() loop, have integer_data = %d\n", integer_data); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, bottom of while() loop, have integer_data_i = %d\n", integer_data_i); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, bottom of while() loop, have integer_data_i_plus_1 = %d\n", integer_data_i_plus_1); }
//		if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, bottom of while() loop, have swap = %d\n", swap); }
////	}
	}

//	if (RPERL_DEBUG3) { fprintf(stderr, "in integer_bubblesort, bottom of subroutine, have integer_data = %d\n", integer_data); }
//	if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, bottom of subroutine, have integer_data_i = %d\n", integer_data_i); }
//	if (RPERL_DEBUG) { fprintf(stderr, "in integer_bubblesort, bottom of subroutine, have integer_data_i_plus_1 = %d\n", integer_data_i_plus_1); }
//	if (RPERL_DEBUG) {  fprintf(stderr, "in integer_bubblesort, bottom of subroutine, have swap = %d\n", swap); }

////	# integer_data is now sorted via top-level nested iteration [O(n**2) total time, O(1) total extra space]
////	return $integer_data;
	return(integer_data);
////};
}

number_arrayref number_bubblesort(number_arrayref number_data)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES number_bubblesort, top of subroutine...\n");
	integer is_sorted = 0;
	integer i;
	integer number_data_length = number_data.size();
	number number_data_i = -9999;
	number number_data_i_plus_1 = -9999;
	number swap = -9999;
	while (not(is_sorted))
	{
		is_sorted = 1;
		for (i = 0; i < (number_data_length - 1); i++)
		{
			number_data_i = number_data[i];
			number_data_i_plus_1 = number_data[(i + 1)];
			if (number_data_i > number_data_i_plus_1)
			{
				is_sorted = 0;
				swap = number_data_i;
				number_data[i] = number_data_i_plus_1;
				number_data[(i + 1)] = swap;
			}
		}
	}
	return(number_data);
}

// OO INHERITANCE TESTING, CONTINUED

////our string $uninherited__Bubble = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Bubble::uninherited__Bubble(), received \$person = '$person', MITOCHONDRIAL\n"; return ('Bubble::uninherited__Bubble() RULES! PERLOPS_PERLTYPES'); };
string uninherited__Bubble(string person) { cout << "in CPPOPS_CPPTYPES Bubble::uninherited__Bubble(), received person = '" << person << "', MITOCHONDRIAL\n"; return((string)"Bubble::uninherited__Bubble() RULES! CPPOPS_CPPTYPES"); }

// DEV NOTE, CORRELATION #04: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
////our string $uninherited = sub { ( my string $person) = @_; RPerl::diag "in PERLOPS_PERLTYPES Bubble::uninherited(), received \$person = '$person', TETRAHEDRON\n"; return ('Bubble::uninherited() ROCKS! PERLOPS_PERLTYPES'); };
string uninherited(string person) { cout << "in CPPOPS_CPPTYPES Bubble::uninherited(), received person = '" << person << "', TETRAHEDRON\n"; return((string)"Bubble::uninherited() ROCKS! CPPOPS_CPPTYPES"); }

// TYPE TESTING

string integer_bubblesort__typetest0(integer_arrayref lucky_integers)
{
    /*
    integer how_lucky = lucky_integers.size();
    integer i;
    for (i = 0;  i < how_lucky;  ++i)
    {
        fprintf(stderr, "in CPPOPS_CPPTYPES integer_bubblesort__typetest0(), have lucky_integer %d/%d = %d, BATBAR\n", i, (how_lucky - 1), lucky_integers[i]);
    }
    */
    return(integer_arrayref_to_string(integer_bubblesort(lucky_integers)) + "CPPOPS_CPPTYPES");
}

string number_bubblesort__typetest0(number_arrayref lucky_numbers)
{
    /*
    integer how_lucky = lucky_numbers.size();
    integer i;
    for (i = 0;  i < how_lucky;  ++i)
    {
        fprintf(stderr, "in CPPOPS_CPPTYPES number_bubblesort__typetest0(), have lucky_number %d/%d = %Lf, BATBAR\n", i, (how_lucky - 1), lucky_numbers[i]);
    }
    */
    return(number_arrayref_to_string(number_bubblesort(lucky_numbers)) + "CPPOPS_CPPTYPES");
}

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

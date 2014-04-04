////use strict;  use warnings;
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_cpp
#define __CPP__INCLUDED__RPerl__Algorithm__Sort__Bubble_cpp 0.003_016

#include <RPerl/Algorithm/Sort/Bubble.h>  // -> HelperFunctions.cpp && Sort.cpp && Inefficient.cpp

# ifdef __PERL__TYPES

// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]
// [[[<<< BEGIN PERL TYPES >>>]]]

////# [[[ OO METHODS ]]]
////# [[[ OO METHODS ]]]
////# [[[ OO METHODS ]]]

////# call out to sort integer__data, return nothing
////our void__method $integer__sort = sub {(my object $self) = @_;
void CPP__RPerl__Algorithm__Sort__Bubble::integer__sort()
////;
{
//	if (RPerl__DEBUG2) { fprintf(stderr, "in integer__sort(), top of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(this->integer__data) = %lu\n", SV_REFERENCE_COUNT(this->integer__data));  fprintf(stderr, "in integer__sort(), top of subroutine, have this->integer__data = %s", RPerl_DUMPER__perl_from_c(this->integer__data));  fprintf(stderr, "in integer__sort(), top of subroutine, have post-DUMPER SV_REFERENCE_COUNT(this->integer__data) = %lu\n\n", SV_REFERENCE_COUNT(this->integer__data));  }

////	$self->{integer__data} = integer__bubblesort($self->{integer__data});
	this->integer__data = integer__bubblesort(this->integer__data);

//	if (RPerl__DEBUG2) { fprintf(stderr, "in integer__sort(), bottom of subroutine, have pre-SvREFCNT_dec pre-DUMPER SV_REFERENCE_COUNT(this->integer__data) = %lu\n", SV_REFERENCE_COUNT(this->integer__data));  fprintf(stderr, "in integer__sort(), bottom of subroutine, have pre-SvREFCNT_dec this->integer__data = %s", RPerl_DUMPER__perl_from_c(this->integer__data));  fprintf(stderr, "in integer__sort(), bottom of subroutine, have pre-SvREFCNT_dec post-DUMPER SV_REFERENCE_COUNT(this->integer__data) = %lu\n\n", SV_REFERENCE_COUNT(this->integer__data));  }
	SvREFCNT_dec(this->integer__data);
//	if (RPerl__DEBUG2) { fprintf(stderr, "in integer__sort(), bottom of subroutine, have post-SvREFCNT_dec pre-DUMPER SV_REFERENCE_COUNT(this->integer__data) = %lu\n", SV_REFERENCE_COUNT(this->integer__data));  fprintf(stderr, "in integer__sort(), bottom of subroutine, have post-SvREFCNT_dec this->integer__data = %s", RPerl_DUMPER__perl_from_c(this->integer__data));  fprintf(stderr, "in integer__sort(), bottom of subroutine, have post-SvREFCNT_dec post-DUMPER SV_REFERENCE_COUNT(this->integer__data) = %lu\n\n", SV_REFERENCE_COUNT(this->integer__data));  }
//	if (RPerl__DEBUG2) { fprintf(stderr, "in integer__sort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(this->integer__data) = %lu\n", SV_REFERENCE_COUNT(this->integer__data));  fprintf(stderr, "in integer__sort(), bottom of subroutine, have this->integer__data = %s", RPerl_DUMPER__perl_from_c(this->integer__data));  fprintf(stderr, "in integer__sort(), bottom of subroutine, post-DUMPER SV_REFERENCE_COUNT(this->integer__data) = %lu\n\n", SV_REFERENCE_COUNT(this->integer__data));  }
////};
}

void CPP__RPerl__Algorithm__Sort__Bubble::number__sort()
{
	this->number__data = number__bubblesort(this->number__data);
	SvREFCNT_dec(this->number__data);
}

////# [[[ PROCEDURAL SUBROUTINES ]]]
////# [[[ PROCEDURAL SUBROUTINES ]]]
////# [[[ PROCEDURAL SUBROUTINES ]]]

////# original algorithm: comparison-based and stable [O(n**2) average time, O(1) worst-case extra space]
////# sort data, return sorted data
////our integer__array_ref $integer__bubblesort = sub {(my integer__array_ref $data) = @_;
SV* integer__bubblesort(SV* integer__data)  // DEV NOTE: properly creates local-to-function SV* integer__data here, does not get confused with this->integer__data object property, even though they share a name
//void integer__bubblesort(SV* integer__data)  // TEMPORARY DEBUGGING
////;
{
//	dSP;
//	dSP;  PUSHMARK(SP);
//	dSP;  ENTER;  SAVETMPS;  PUSHMARK(SP);
//	Inline_Stack_Vars;

	RPerl_object_property_init(integer__data); // NEED ANSWER: why do we need to do property init?
	SvREFCNT_inc(integer__data);
//	fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of subroutine...\n");

//	integer__array_ref__CHECK(integer__data);
	integer__array_ref__CHECKTRACE(integer__data, "integer__data", "integer__bubblesort()");

//	if (RPerl__DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n", SV_REFERENCE_COUNT(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of subroutine, have integer__data = %s", RPerl_DUMPER__perl_from_c(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of subroutine, have post-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n\n", SV_REFERENCE_COUNT(integer__data)); }
////	my integer $is_sorted = 0;
	integer is_sorted = 0;
////	my integer $i;
	integer i;
////	my const_integer $integer__data_length = scalar(@{$integer__data});
//	const integer integer__data_length = av_len((AV*) SvRV(integer__data)) + 1;  // DE-OPTIMIZE, SHORT-HAND
	AV* integer__data_av = (AV*) SvRV(integer__data);  // OPTIMIZE, LONG-HAND: integer__data dereferenced to integer__data_av more than once, declare integer__data_av and re-use, MUST REFRESH integer__data_av for every assignment directly to integer__data (none in this algorithm)
	const integer integer__data_length = av_len(integer__data_av) + 1;  // OPTIMIZE, LONG-HAND: use integer__data_av
	SV* integer__data_i = newSV(0);  // OPTIMIZE, LONG-HAND: integer__data element i accessed more than once, declare integer__data_i and re-use;  all new SV*'s given initial undef newSV(0) value to avoid fprintf(stderr, ) errors during debugging
	SV* integer__data_i_plus_1 = newSV(0);  // OPTIMIZE, LONG-HAND

////	my scalar $swap;
	SV* swap = newSV(0);

//	if (RPerl__DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(integer__data_i) = %lu\n", SV_REFERENCE_COUNT(integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), after variable init, have integer__data_i = %s", RPerl_DUMPER__perl_from_c(integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(integer__data_i) = %lu\n\n", SV_REFERENCE_COUNT(integer__data_i)); }
//	if (RPerl__DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), after variable init, have integer__data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(integer__data_i_plus_1)); }
//	if (RPerl__DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), after variable init, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

////#	print "in CPPOPS_PERLTYPES integer__bubblesort(), have \$integer__data_length = $integer__data_length\n" if $RPerl::DEBUG;
//	 if (RPerl__DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), after variable init, have integer__data_length = %d\n", integer__data_length); }

////	# iterate through the length-n list up to n times (n * n == n**2), larger elements "bubble to the top" (end) of the list
////	while (not($is_sorted))
	while (not(is_sorted))
////	{
	{
////#		print "in CPPOPS_PERLTYPES integer__bubblesort(), top of while loop\n" if $RPerl::DEBUG;
//		if (RPerl__DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop\n"); }
//		if (RPerl__DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n", SV_REFERENCE_COUNT(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have integer__data = %s", RPerl_DUMPER__perl_from_c(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n\n", SV_REFERENCE_COUNT(integer__data)); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__integer__data_i) = %lu\n", SV_REFERENCE_COUNT(integer__integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have integer__integer__data_i = %s", RPerl_DUMPER__perl_from_c(integer__integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__integer__data_i) = %lu\n\n", SV_REFERENCE_COUNT(integer__integer__data_i)); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have integer__data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(integer__data_i_plus_1)); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

////		$is_sorted = 1;
		is_sorted = 1;
////		for ($i = 0; $i < ($integer__data_length - 1); $i++)
		for (i = 0; i < (integer__data_length - 1); i++)
////		{
		{
////#			print "in CPPOPS_PERLTYPES integer__bubblesort(), inside for() loop, have \$i = $i\n" if $RPerl::DEBUG;
//			if (RPerl__DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have i = %d\n", i); }
////#			print "in CPPOPS_PERLTYPES integer__bubblesort(), inside for() loop, have \$integer__data\n" . RPerl::DUMPER($integer__data) . "\n" if $RPerl::DEBUG;
//			if (RPerl__DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n", SV_REFERENCE_COUNT(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have integer__data = %s", RPerl_DUMPER__perl_from_c(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n\n", SV_REFERENCE_COUNT(integer__data)); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__data_i) = %lu\n", SV_REFERENCE_COUNT(integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have integer__data_i = %s", RPerl_DUMPER__perl_from_c(integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__data_i) = %lu\n\n", SV_REFERENCE_COUNT(integer__data_i)); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have integer__data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(integer__data_i_plus_1)); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

////			# compare elements and swap if out-of-order, this is the core sort comparison
////			if ($integer__data->[$i] > $integer__data->[($i + 1)])
//			if (SvIV(AV_ELEMENT((AV*) SvRV(integer__data), i)) > SvIV(AV_ELEMENT((AV*) SvRV(integer__data), (i + 1))))  // DE-OPTIMIZE, SHORT-HAND
			integer__data_i = AV_ELEMENT(integer__data_av, i);  // OPTIMIZE, LONG-HAND: use integer__data_i and integer__data_av
			integer__data_i_plus_1 = AV_ELEMENT(integer__data_av, (i + 1));  // OPTIMIZE, LONG-HAND: use integer__data_i_plus_1 and integer__data_av

			// DEV NOTE: using C++ numeric greater-than comparator operator as direct replacement for equivalent Perl builtin operator
			if (SvIV(integer__data_i) > SvIV(integer__data_i_plus_1))  // OPTIMIZE, LONG-HAND: use integer__data_i and integer__data_i_plus_1
////			{
			{
////#				print "in CPPOPS_PERLTYPES integer__bubblesort(), inside for() loop, SWAPPED\n" if $RPerl::DEBUG;
//				if (RPerl__DEBUG2) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), inside for() loop, SWAPPED\n"); }
////				$is_sorted = 0;
				is_sorted = 0;
////				$swap = $integer__data->[$i];
//				swap = AV_ELEMENT((AV*) SvRV(integer__data), i);  // DE-OPTIMIZE, SHORT-HAND
				integer__data_i = AV_ELEMENT(integer__data_av, i);  // OPTIMIZE, LONG-HAND: use integer__data_i and integer__data_av
				swap = integer__data_i;  // OPTIMIZE, LONG-HAND: use integer__data_i
////				$integer__data->[$i] = $integer__data->[($i + 1)];
//				av_store((AV*) SvRV(integer__data), i, SvREFCNT_inc(AV_ELEMENT((AV*) SvRV(integer__data), (i + 1))));  // DE-OPTIMIZE, SHORT-HAND
				integer__data_i_plus_1 = AV_ELEMENT(integer__data_av, (i + 1));  // OPTIMIZE, LONG-HAND: use integer__data_i_plus_1 and integer__data_av
				av_store(integer__data_av, i, SvREFCNT_inc(integer__data_i_plus_1));  // OPTIMIZE, LONG-HAND: use integer__data_av and integer__data_i_plus_1
////				$integer__data->[($i + 1)] = $swap;
//				av_store((AV*) SvRV(integer__data), (i + 1), SvREFCNT_inc(swap));  // DE-OPTIMIZE, SHORT-HAND
				av_store(integer__data_av, (i + 1), SvREFCNT_inc(swap));  // OPTIMIZE, LONG-HAND: use integer__data_av
////			}
			}
//			if (RPerl__DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n", SV_REFERENCE_COUNT(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have integer__data = %s", RPerl_DUMPER__perl_from_c(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n\n", SV_REFERENCE_COUNT(integer__data)); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__data_i) = %lu\n", SV_REFERENCE_COUNT(integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have integer__data_i = %s", RPerl_DUMPER__perl_from_c(integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__data_i) = %lu\n\n", SV_REFERENCE_COUNT(integer__data_i)); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have integer__data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(integer__data_i_plus_1)); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }
////		}
		}
//		if (RPerl__DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n", SV_REFERENCE_COUNT(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have integer__data = %s", RPerl_DUMPER__perl_from_c(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n\n", SV_REFERENCE_COUNT(integer__data)); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__data_i) = %lu\n", SV_REFERENCE_COUNT(integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have integer__data_i = %s", RPerl_DUMPER__perl_from_c(integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__data_i) = %lu\n\n", SV_REFERENCE_COUNT(integer__data_i)); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have integer__data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(integer__data_i_plus_1)); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }
////	}
	}

//	SvREFCNT_inc(integer__data);
//	if (RPerl__DEBUG3) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n", SV_REFERENCE_COUNT(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have integer__data = %s", RPerl_DUMPER__perl_from_c(integer__data));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(integer__data) = %lu\n\n", SV_REFERENCE_COUNT(integer__data)); }
//	if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(integer__data_i) = %lu\n", SV_REFERENCE_COUNT(integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have integer__data_i = %s", RPerl_DUMPER__perl_from_c(integer__data_i));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(integer__data_i) = %lu\n\n", SV_REFERENCE_COUNT(integer__data_i)); }
//	if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have integer__data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(integer__data_i_plus_1));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(integer__data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(integer__data_i_plus_1)); }
//	if (RPerl__DEBUG) { fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

////	# integer__data is now sorted via top-level nested iteration [O(n**2) total time, O(1) total extra space]
////	return $integer__data;
//	SvREFCNT_dec(integer__data);

//	Inline_Stack_Vars;
//	Inline_Stack_Reset;
//	Inline_Stack_Push(integer__data);
//	Inline_Stack_Done;

//	PUTBACK;
//	PUTBACK;  FREETMPS;  LEAVE;
	return(integer__data);
////};
}

SV* number__bubblesort(SV* number__data)
{
	RPerl_object_property_init(number__data);
	SvREFCNT_inc(number__data);
//	fprintf(stderr, "in CPPOPS_PERLTYPES number__bubblesort(), top of subroutine...\n");

//	number__array_ref__CHECK(number__data);
	number__array_ref__CHECKTRACE(number__data, "number__data", "number__bubblesort()");

	integer is_sorted = 0;
	integer i;
	AV* number__data_av = (AV*) SvRV(number__data);
	const integer number__data_length = av_len(number__data_av) + 1;
	SV* number__data_i = newSV(0);
	SV* number__data_i_plus_1 = newSV(0);

	SV* swap = newSV(0);
	while (not(is_sorted))
	{
		is_sorted = 1;
		for (i = 0; i < (number__data_length - 1); i++)
		{
			number__data_i = AV_ELEMENT(number__data_av, i);
			number__data_i_plus_1 = AV_ELEMENT(number__data_av, (i + 1));

			if (SvNV(number__data_i) > SvNV(number__data_i_plus_1))
			{
				is_sorted = 0;
				number__data_i = AV_ELEMENT(number__data_av, i);
				swap = number__data_i;
				number__data_i_plus_1 = AV_ELEMENT(number__data_av, (i + 1));
				av_store(number__data_av, i, SvREFCNT_inc(number__data_i_plus_1));
				av_store(number__data_av, (i + 1), SvREFCNT_inc(swap));
			}
		}
	}
	return(number__data);
}

// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

SV* integer__bubblesort__typetest0(SV* lucky_integers)
{
//	dSP;  PUSHMARK(SP);  // DEV NOTE: necessary to avoid "panic: memory wrap" or messing up Perl stack in some cases, but not here!
//	integer__array_ref__CHECK(lucky_integers);
	integer__array_ref__CHECKTRACE(lucky_integers, "lucky_integers", "integer__bubblesort__typetest0()");
	/*
	AV* lucky_integers_deref = (AV*)SvRV(lucky_integers);
	integer how_lucky = av_len(lucky_integers_deref) + 1;
	integer i;
	for (i = 0;  i < how_lucky;  ++i)
	{
		fprintf(stderr, "in CPPOPS_PERLTYPES integer__bubblesort__typetest0(), have lucky_integer %d/%d = %d, BATBAR\n", i, (how_lucky - 1), (integer)SvIV(*av_fetch(lucky_integers_deref, i, 0)));
	}
	*/

//	SV* retval__integer__bubblesort = integer__bubblesort(lucky_integers);
//	SV* retval__integer__array_ref__stringify = integer__array_ref__stringify(retval__integer__bubblesort);
//	SV* retval__string = newSVpvf("%s%s", SvPV_nolen(retval__integer__array_ref__stringify), "CPPOPS_PERLTYPES");
//	return(retval__string);
//	return(newSVpvf("%s%s", SvPV_nolen(retval__integer__array_ref__stringify), "CPPOPS_PERLTYPES"));
//	return(newSVpvf("%s%s", SvPV_nolen(integer__array_ref__stringify(retval__integer__bubblesort)), "CPPOPS_PERLTYPES"));
	return(newSVpvf("%s%s", SvPV_nolen(integer__array_ref__stringify(integer__bubblesort(lucky_integers))), "CPPOPS_PERLTYPES"));
}

SV* number__bubblesort__typetest0(SV* lucky_numbers)
{
//	number__array_ref__CHECK(lucky_numbers);
	number__array_ref__CHECKTRACE(lucky_numbers, "lucky_numbers", "number__bubblesort__typetest0()");
	/*
	AV* lucky_numbers_deref = (AV*)SvRV(lucky_numbers);
	integer how_lucky = av_len(lucky_numbers_deref) + 1;
	integer i;
	for (i = 0;  i < how_lucky;  ++i)
	{
		fprintf(stderr, "in CPPOPS_PERLTYPES number__bubblesort__typetest0(), have lucky_number %d/%d = %Lf, BATBAR\n", i, (how_lucky - 1), (number)SvNV(*av_fetch(lucky_numbers_deref, i, 0)));
	}
	*/

	return(newSVpvf("%s%s", SvPV_nolen(number__array_ref__stringify(number__bubblesort(lucky_numbers))), "CPPOPS_PERLTYPES"));
}

// [[[ INHERITANCE TESTING ]]]
// [[[ INHERITANCE TESTING ]]]
// [[[ INHERITANCE TESTING ]]]

void CPP__RPerl__Algorithm__Sort__Bubble::inherited__Bubble(SV* person)
{
	cout << "in CPPOPS_PERLTYPES Bubble->inherited__Bubble(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', FRIED\n";
}

void CPP__RPerl__Algorithm__Sort__Bubble::inherited(SV* person)
{
	cout << "in CPPOPS_PERLTYPES Bubble->inherited(), received this = '" << this << "' and person = '" << SvPV_nolen(person) << "', ILLOGICAL\n";
}

SV* uninherited__Bubble(SV* person)
{
	cout << "in CPPOPS_PERLTYPES Bubble::uninherited__Bubble(), received person = '" << SvPV_nolen(person) << "', MITOCHONDRIAL\n";
	return(newSVpv("Bubble::uninherited__Bubble() RULES! CPPOPS_PERLTYPES", 0));
}

SV* uninherited(SV* person)
{
	cout << "in CPPOPS_PERLTYPES Bubble::uninherited(), received person = '" << SvPV_nolen(person) << "', TETRAHEDRON\n";
	return(newSVpv("Bubble::uninherited() RULES! CPPOPS_PERLTYPES", 0));
}

// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]
// [[[<<< END PERL TYPES >>>]]]

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

////# [[[ OO METHODS ]]]
////# [[[ OO METHODS ]]]
////# [[[ OO METHODS ]]]

////# call out to sort integer__data, return nothing
////our void__method $integer__sort = sub {(my object $self) = @_;
void CPP__RPerl__Algorithm__Sort__Bubble::integer__sort()
////;
{
//	if (RPerl__DEBUG2) { fprintf(stderr, "in integer__sort(), top of subroutine, have this->integer__data = %d\n", this->integer__data); }

////	$self->{integer__data} = integer__bubblesort($self->{integer__data});
	this->integer__data = integer__bubblesort(this->integer__data);

//	if (RPerl__DEBUG2) { fprintf(stderr, "in integer__sort(), bottom of subroutine, have this->integer__data = %d\n", this->integer__data); }
////};
}

void CPP__RPerl__Algorithm__Sort__Bubble::number__sort()
{
	this->number__data = number__bubblesort(this->number__data);
}

////# [[[ PROCEDURAL SUBROUTINES ]]]
////# [[[ PROCEDURAL SUBROUTINES ]]]
////# [[[ PROCEDURAL SUBROUTINES ]]]

////# original algorithm: comparison-based and stable [O(n**2) average time, O(1) worst-case extra space]
////# sort integer__data, return sorted integer__data
////our integer__array_ref $integer__bubblesort = sub {(my integer__array_ref $integer__data) = @_;
integer__array_ref integer__bubblesort(integer__array_ref integer__data)  // DEV NOTE: properly creates local-to-function integer__array_ref integer__data here, does not get confused with this->integer__data object property, even though they share a name
////;
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES integer__bubblesort, top of subroutine...\n");
//	if (RPerl__DEBUG3) { fprintf(stderr, "in integer__bubblesort, top of subroutine, have integer__data = %d", integer__data); }
////	my integer $is_sorted = 0;
	integer is_sorted = 0;
////	my integer $i;
	integer i;
////	my const_integer $integer__data_length = scalar(@{$integer__data});
	const integer integer__data_length = integer__data.size();
	integer integer__data_i = -9999;  // OPTIMIZE, LONG-HAND: integer__data element i accessed more than once, declare integer__data_i and re-use;  all new integer's given initial -9999 value to avoid fprintf(stderr, ) errors during debugging
	integer integer__data_i_plus_1 = -9999;  // OPTIMIZE, LONG-HAND

////	my integer $swap;
	integer swap = -9999;

//	if (RPerl__DEBUG2) { fprintf(stderr, "in integer__bubblesort, after variable init, have integer__data_i = %d\n", integer__data_i); }
//	if (RPerl__DEBUG2) { fprintf(stderr, "in integer__bubblesort, after variable init, have integer__data_i_plus_1 = %d\n", integer__data_i_plus_1); }
//	if (RPerl__DEBUG2) { fprintf(stderr, "in integer__bubblesort, after variable init, have swap = %d\n", swap); }

////#	print "in integer__bubblesort, have \$integer__data_length = $integer__data_length\n" if $RPerl::DEBUG;
//	 if (RPerl__DEBUG2) { fprintf(stderr, "in integer__bubblesort, after variable init, have integer__data_length = %d\n", integer__data_length); }

////	# iterate through the length-n list up to n times (n * n == n**2), larger elements "bubble to the top" (end) of the list
////	while (not($is_sorted))
	while (not(is_sorted))
////	{
	{
////#		print "in integer__bubblesort, top of while loop\n" if $RPerl::DEBUG;
//		if (RPerl__DEBUG2) { fprintf(stderr, "in integer__bubblesort, top of while() loop\n"); }
//		if (RPerl__DEBUG3) { fprintf(stderr, "in integer__bubblesort, top of while() loop, have integer__data = %d\n", integer__data); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, top of while() loop, have integer__data_i = %d\n", integer__data_i); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, top of while() loop, have integer__data_i_plus_1 = %d\n", integer__data_i_plus_1); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, top of while() loop, have swap = %d\n", swap); }

////		$is_sorted = 1;
		is_sorted = 1;
////		for ($i = 0; $i < ($integer__data_length - 1); $i++)
		for (i = 0; i < (integer__data_length - 1); i++)
////		{
		{
////#			print "in integer__bubblesort, inside for() loop, have \$i = $i\n" if $RPerl::DEBUG;
//			if (RPerl__DEBUG2) { fprintf(stderr, "in integer__bubblesort, top of for() loop, have i = %d\n", i); }
////#			print "in integer__bubblesort, inside for() loop, have \$integer__data\n" . RPerl::DUMPER($integer__data) . "\n" if $RPerl::DEBUG;
//			if (RPerl__DEBUG3) { fprintf(stderr, "in integer__bubblesort, top of for() loop, have integer__data = %d\n", integer__data); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, top of for() loop, have integer__data_i = %d\n", integer__data_i); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, top of for() loop, have integer__data_i_plus_1 = %d\n", integer__data_i_plus_1); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, top of for() loop, have swap = %d\n", swap); }

////			# compare elements and swap if out-of-order, this is the core sort comparison
////			if ($integer__data->[$i] > $integer__data->[($i + 1)])
//			if (integer__data[i] > integer__data[(i + 1)])  // DE-OPTIMIZE, SHORT-HAND
			integer__data_i = integer__data[i];  // OPTIMIZE, LONG-HAND: use integer__data_i
			integer__data_i_plus_1 = integer__data[(i + 1)];  // OPTIMIZE, LONG-HAND: use integer__data_i_plus_1

			// DEV NOTE: integer__data is of type integer__array_ref, assuming numeric values for integer__data elements and using C++ numeric comparator
			if (integer__data_i > integer__data_i_plus_1)  // OPTIMIZE, LONG-HAND: use integer__data_i and integer__data_i_plus_1
////			{
			{
////#				print "in integer__bubblesort, inside for() loop, SWAPPED\n" if $RPerl::DEBUG;
//				if (RPerl__DEBUG2) { fprintf(stderr, "in integer__bubblesort, inside for() loop, SWAPPED\n"); }
////				$is_sorted = 0;
				is_sorted = 0;
////				$swap = $integer__data->[$i];
//				swap = integer__data[i];  // DE-OPTIMIZE, SHORT-HAND
				swap = integer__data_i;  // OPTIMIZE, LONG-HAND: use integer__data_i
////				$integer__data->[$i] = $integer__data->[($i + 1)];
//				integer__data[i] = integer__data[(i + 1)];  // DE-OPTIMIZE, SHORT-HAND
				integer__data[i] = integer__data_i_plus_1;  // OPTIMIZE, LONG-HAND: use integer__data_i_plus_1
////				$integer__data->[($i + 1)] = $swap;
				integer__data[(i + 1)] = swap;
////			}
			}
//			if (RPerl__DEBUG3) { fprintf(stderr, "in integer__bubblesort, bottom of for() loop, have integer__data = %d\n", integer__data); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, bottom of for() loop, have integer__data_i = %d\n", integer__data_i); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, bottom of for() loop, have integer__data_i_plus_1 = %d\n", integer__data_i_plus_1); }
//			if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, bottom of for() loop, have swap = %d\n", swap); }
////		}
		}
//		if (RPerl__DEBUG3) { fprintf(stderr, "in integer__bubblesort, bottom of while() loop, have integer__data = %d\n", integer__data); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, bottom of while() loop, have integer__data_i = %d\n", integer__data_i); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, bottom of while() loop, have integer__data_i_plus_1 = %d\n", integer__data_i_plus_1); }
//		if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, bottom of while() loop, have swap = %d\n", swap); }
////	}
	}

//	if (RPerl__DEBUG3) { fprintf(stderr, "in integer__bubblesort, bottom of subroutine, have integer__data = %d\n", integer__data); }
//	if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, bottom of subroutine, have integer__data_i = %d\n", integer__data_i); }
//	if (RPerl__DEBUG) { fprintf(stderr, "in integer__bubblesort, bottom of subroutine, have integer__data_i_plus_1 = %d\n", integer__data_i_plus_1); }
//	if (RPerl__DEBUG) {  fprintf(stderr, "in integer__bubblesort, bottom of subroutine, have swap = %d\n", swap); }

////	# integer__data is now sorted via top-level nested iteration [O(n**2) total time, O(1) total extra space]
////	return $integer__data;
	return(integer__data);
////};
}





number__array_ref number__bubblesort(number__array_ref number__data)
{
//	fprintf(stderr, "in CPPOPS_CPPTYPES number__bubblesort, top of subroutine...\n");
	integer is_sorted = 0;
	integer i;
	const integer number__data_length = number__data.size();
	number number__data_i = -9999;
	number number__data_i_plus_1 = -9999;
	number swap = -9999;
	while (not(is_sorted))
	{
		is_sorted = 1;
		for (i = 0; i < (number__data_length - 1); i++)
		{
			number__data_i = number__data[i];
			number__data_i_plus_1 = number__data[(i + 1)];
			if (number__data_i > number__data_i_plus_1)
			{
				is_sorted = 0;
				swap = number__data_i;
				number__data[i] = number__data_i_plus_1;
				number__data[(i + 1)] = swap;
			}
		}
	}
	return(number__data);
}







// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]
// [[[ TYPE TESTING ]]]

string integer__bubblesort__typetest0(integer__array_ref lucky_integers)
{
	/*
	integer how_lucky = lucky_integers.size();
	integer i;
	for (i = 0;  i < how_lucky;  ++i)
	{
		fprintf(stderr, "in CPPOPS_CPPTYPES integer__bubblesort__typetest0(), have lucky_integer %d/%d = %d, BATBAR\n", i, (how_lucky - 1), lucky_integers[i]);
	}
	*/
	return(integer__array_ref__stringify(integer__bubblesort(lucky_integers)) + "CPPOPS_CPPTYPES");
}

string number__bubblesort__typetest0(number__array_ref lucky_numbers)
{
	/*
	integer how_lucky = lucky_numbers.size();
	integer i;
	for (i = 0;  i < how_lucky;  ++i)
	{
		fprintf(stderr, "in CPPOPS_CPPTYPES number__bubblesort__typetest0(), have lucky_number %d/%d = %Lf, BATBAR\n", i, (how_lucky - 1), lucky_numbers[i]);
	}
	*/
	return(number__array_ref__stringify(number__bubblesort(lucky_numbers)) + "CPPOPS_CPPTYPES");
}

// [[[ INHERITANCE TESTING ]]]
// [[[ INHERITANCE TESTING ]]]
// [[[ INHERITANCE TESTING ]]]

void CPP__RPerl__Algorithm__Sort__Bubble::inherited__Bubble(string person)
{
	cout << "in CPPOPS_CPPTYPES Bubble->inherited__Bubble(), received this = '" << this << "' and person = '" << person << "', FRIED\n";
}

void CPP__RPerl__Algorithm__Sort__Bubble::inherited(string person)
{
	cout << "in CPPOPS_CPPTYPES Bubble->inherited(), received this = '" << this << "' and person = '" << person << "', ILLOGICAL\n";
}

string uninherited__Bubble(string person) {
	cout << "in CPPOPS_CPPTYPES Bubble::uninherited__Bubble(), received person = '" << person << "', MITOCHONDRIAL\n";
	return((string)"Bubble::uninherited__Bubble() RULES! CPPOPS_CPPTYPES");
}

string uninherited(string person)
{
	cout << "in CPPOPS_CPPTYPES Bubble::uninherited(), received person = '" << person << "', TETRAHEDRON\n";
	return((string)"Bubble::uninherited() RULES! CPPOPS_CPPTYPES");
}

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!

# endif

#endif

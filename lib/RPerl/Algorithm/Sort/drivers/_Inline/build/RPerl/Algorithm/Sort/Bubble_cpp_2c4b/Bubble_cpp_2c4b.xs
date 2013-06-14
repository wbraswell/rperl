
#define __INLINE_CPP_STANDARD_HEADERS 1
#define __INLINE_CPP_NAMESPACE_STD 1

#define __INLINE_CPP 1
#ifndef bool
#include <iostream>
#endif
extern "C" {
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "INLINE.h"
}
#ifdef bool
#undef bool
#include <iostream>
#endif

#define RPerl__DEBUG 1  // NEED FIX: access actual inherited debug flag somehow?

////package RPerl::Algorithm::Sort::Bubble;
////use strict;  use warnings;
class RPerl__Algorithm__Sort__Bubble__cpp
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void sort_method__cpp();  // NEED ANSWER: no named argument required for $self object?

	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
////our %properties =
////(
////	data => my scalar_array_ref $KEY_data,
////);
	RV *data;  // DEV NOTE: no accessors (get) or mutators (set) for light-weight RPerl objects, %properties data members made public in C++

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS >>>
	RPerl__Algorithm__Sort__Bubble__cpp();
	~RPerl__Algorithm__Sort__Bubble__cpp();

private:
	// <<< TRANSLATED INHERITANCE DECLARATION & DEFINITION >>>
////our @ISA = ('RPerl::Algorithm::Sort');
////use RPerl::Algorithm::Sort;
	AV *ISA = newAV();  // DEV NOTE: no programmatic or run-time modification of inheritance, @ISA made private in C++
//	av_push(ISA, SvREFCNT_inc(newSVpv("SOME::RPERL::PACKAGE::INDICATING::TRANSLATED::FROM::PERL::TO::CPP", 2112)));  // NEED ADD: actual package
	av_push(ISA, SvREFCNT_inc(newSVpv("RPerl::Algorithm::Sort", 22)));  // NEED ANSWER: does this have to go inside the constructor?  if so, how to check class (not object) inheritance?
};

// <<< CONSTRUCTOR & DESTRUCTOR DEFINITIONS >>>
RPerl__Algorithm__Sort__Bubble__cpp::RPerl__Algorithm__Sort__Bubble__cpp(){}  // NEED ANSWER: need init() functionality?  need move @ISA definition here?
RPerl__Algorithm__Sort__Bubble__cpp::~RPerl__Algorithm__Sort__Bubble__cpp(){}  // NEED ANSWER: need av_undef() functionality?


////# [object-oriented programming interface]
////# call out to sort data, return nothing
////our void $sort_method = sub {(my object $self) = @_;
void RPerl__Algorithm__Sort__Bubble__cpp::sort_method__cpp()
////;
{
////	$self->{data} = bubblesort($self->{data});
	data = bubblesort__cpp(data);
////};
}

////# [procedural programming interface]
////# original algorithm: comparison-based and stable [O(n**2) average time, O(1) worst-case extra space]
////# sort data, return sorted data
////our scalar_array_ref $bubblesort = sub {(my scalar_array_ref $data) = @_;
RV *bubblesort__cpp(RV *data)  // NEED ANSWER: is this properly grabbing argument named 'data', or improperly grabbing object property 'data'?
////;
{
////	my int $is_sorted = 0;
	int is_sorted = 0;
////	my int $i;
	int i;
////	my const_int $data_length = scalar(@{$data});
//	const int data_length = av_len((AV*) SvRV(data)) + 1;  // NEED ENABLE: short-hand
	const int data_length;  // NEED DISABLE: long-hand
	AV* data_deref = (AV*) SvRV(data);  // NEED DISABLE: long-hand
	data_length = av_len(data_deref) + 1;  // NEED DISABLE: long-hand
	SV *data_i;  // NEED DISABLE: long-hand
	SV *data_i_plus_1;  // NEED DISABLE: long-hand

////	my scalar $swap;
	SV *swap;
	
////#	print "in bubblesort(), have \$data_length = $data_length\n" if $RPerl::DEBUG;
	printf("in bubblesort__cpp(), have data_length = %d\n", data_length) if RPerl__DEBUG;  // NEED ADD: create new DEBUG flag?

////	# iterate through the length-n list up to n times (n * n == n**2), larger elements "bubble to the top" (end) of the list
////	while (not($is_sorted))
	while (not(is_sorted))
////	{
	{
////#		print "in bubblesort(), top of WHILE loop\n" if $RPerl::DEBUG;
		printf("in bubblesort__cpp(), top of WHILE loop\n") if RPerl__DEBUG;
////		$is_sorted = 1;
		is_sorted = 1;
////		for ($i = 0; $i < ($data_length - 1); $i++)
		for (i = 0; i < (data_length - 1); i++)
////		{
		{
////#			print "in bubblesort(), inside for() loop, have \$i = $i\n" if $RPerl::DEBUG;
			printf("in bubblesort__cpp(), inside for() loop, have i = %d\n", i) if RPerl__DEBUG;
////#			print "in bubblesort(), inside for() loop, have \$data\n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
			printf("in bubblesort__cpp(), inside for() loop, have data = %s\n", RPerl__DUMPER(data)) if RPerl__DEBUG;  // NEED ADD: some way to actually access RPerl::DUMPER

////			# compare elements and swap if out-of-order, this is the core sort comparison
////			if ($data->[$i] > $data->[($i + 1)])
//			if (SvNV(AV_FETCH_SAFE((AV*) SvRV(data), i, 0)) > SvNV(AV_FETCH_SAFE((AV*) SvRV(data), (i + 1), 0)))  // NEED ENABLE: short-hand
			data_i = AV_FETCH_SAFE(data_deref, i, 0);  // NEED DISABLE: long-hand
			data_i_plus_1 = AV_FETCH_SAFE(data_deref, (i + 1), 0);  // NEED DISABLE: long-hand
			if (SvNV(data_i) > SvNV(data_i_plus_1))  // NEED ANSWER: assuming numeric value and using C++ numeric comparator, is this appropriate?  NEED DISABLE: long-hand
////			{
			{
////#				print "in bubblesort(), inside for() loop, SWAPPED\n" if $RPerl::DEBUG;
				prinf("in bubblesort__cpp(), inside for() loop, SWAPPED\n") if RPerl__DEBUG;
////				$is_sorted = 0;
				is_sorted = 0;
////				$swap = $data->[$i];
//				swap = AV_FETCH_SAFE((AV*) SvRV(data), i, 0);  // NEED ENABLE: short-hand
				data_i = AV_FETCH_SAFE(data_deref, i, 0);  // NEED DISABLE: long-hand
				swap = data_i;  // NEED DISABLE: long-hand
////				$data->[$i] = $data->[($i + 1)];
//				av_store((AV*) SvRV(data), i, AV_FETCH_SAFE((AV*) SvRV(data), (i + 1), 0));  // NEED ENABLE: short-hand
				data_i_plus_1 = AV_FETCH_SAFE(data_deref, (i + 1), 0);  // NEED DISABLE: long-hand
				av_store(data_deref, i, data_i_plus_1);  // NEED DISABLE: long-hand
////				$data->[($i + 1)] = $swap;
//				av_store((AV*) SvRV(data), (i + 1), swap);  // NEED ENABLE: short-hand
				av_store(data_deref, (i + 1), swap);  // NEED DISABLE: long-hand
////			}
			}
////		}
		}
////	}
	}
	
////	# data is now sorted via top-level nested iteration [O(n**2) total time, O(1) total extra space]
////	return $data;
	return data;
////};
}
MODULE = RPerl::Algorithm::Sort::Bubble_cpp_2c4b        PACKAGE = RPerl::Algorithm::Sort::Bubble_cpp  

PROTOTYPES: DISABLE

void
sort_method__cpp()
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	sort_method__cpp();
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */


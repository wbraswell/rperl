
#define __INLINE_CPP_STANDARD_HEADERS 1
#define __INLINE_CPP_NAMESPACE_STD 1


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

// <<< HELPER DEFINES >>>
#define RPerl__DEBUG 1  // NEED FIX: access actual inherited debug flag somehow?
#define AV_ELEMENT(av,index) ((av_fetch(av,index,0)!=NULL)?*av_fetch(av,index,0):newSV(0))

// <<< HELPER FUNCTIONS >>
char* RPerl_DUMPER__perl_from_c(SV* dumpee);
char* RPerl_DUMPER__perl_from_c(SV* dumpee)
{
        dSP;
        int retcnt;
        char* retval;

//      ENTER;  SAVETMPS;
        PUSHMARK(SP); XPUSHs(dumpee); PUTBACK;
        retcnt = call_pv("RPerl::DUMPER", G_SCALAR);
        SPAGAIN;
        if (retcnt != 1) { croak("RPerl::DUMPER(dumpee) return count is %d, expected 1, croaking", retcnt); }
        retval = POPp; PUTBACK;
//      FREETMPS;  LEAVE;

        return retval;
}

// <<< TRANSLATED FUNCTION DECLARATIONS >>>
SV *bubblesort(SV *data);

////package RPerl::Algorithm::Sort::Bubble;
////use strict;  use warnings;
class Bubble
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void sort_method();  // NEED ANSWER: no named argument required for $self object?

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS
	// DEV NOTE: require accessors (get) and mutators (set) for RPerl objects because Inline::CPP does not allow direct access to public C++ data members, only public C++ methods
//	SV *data_get() { return SvREFCNT_inc(this->data); }
	SV *data_get() { printf("in data_get(), have initial SvREFCNT(this->data) = %lu\n", SvREFCNT(this->data));  SvREFCNT_inc(this->data);  printf("in data_get(), have incremented SvREFCNT(this->data) = %lu\n", SvREFCNT(this->data));  return this->data;}
//	SV *data_get() { return this->data; }
//	void data_set(SV* data_new) { this->data = SvREFCNT_inc(data_new); }
	void data_set(SV* data_new) { printf("in data_set(), have initial SvREFCNT(this->data) = %lu\n", SvREFCNT(this->data));  this->data = SvREFCNT_inc(data_new);  printf("in data_set(), have incremented SvREFCNT(this->data) = %lu\n", SvREFCNT(this->data)); }
//	void data_set(SV* data_new) { this->data = data_new; }

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	Bubble(){}  // NEED ANSWER: need init() functionality?  need move @ISA definition here?
//	~Bubble(){ printf("in ~Bubble(), have initial SvREFCNT(this->data) = %lu\n", SvREFCNT(this->data));  SvREFCNT_dec(this->data);  printf("in ~Bubble(), have decremented SvREFCNT(this->data) = %lu\n", SvREFCNT(this->data)); }  // NEED ANSWER: need av_undef() functionality?
	~Bubble(){ SvREFCNT_dec(this->data); }

private:
	// <<< TRANSLATED INHERITANCE DECLARATION & DEFINITION >>>
	// NEED ANSWER: use C++ single inheritance?  need to fix Inline::CPP to get multiple inheritance working?
////our @ISA = ('RPerl::Algorithm::Sort');
////use RPerl::Algorithm::Sort;
//	AV *ISA = newAV();  // DEV NOTE: no programmatic or run-time modification of inheritance, @ISA made private in C++
//	av_push(ISA, SvREFCNT_inc(newSVpv("SOME::RPERL::PACKAGE::INDICATING::TRANSLATED::FROM::PERL::TO::CPP", 2112)));  // NEED ADD: actual package
//	av_push(ISA, SvREFCNT_inc(newSVpv("RPerl::Algorithm::Sort", 22)));  // NEED ANSWER: does this have to go inside the constructor?  if so, how to check class (not object) inheritance?

	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
////our %properties =
////(
////	data => my scalar_array_ref $KEY_data,
////);
	SV *data;
};

////# [object-oriented programming interface]
////# call out to sort data, return nothing
////our void $sort_method = sub {(my object $self) = @_;
void Bubble::sort_method()
////;
{
	if (RPerl__DEBUG) { printf("in sort_method(), have pre-DUMPER SvREFCNT(this->data) = %lu\n", SvREFCNT(this->data));  printf("in sort_method(), have this->data = %s\n", RPerl_DUMPER__perl_from_c(this->data));  printf("in sort_method(), have post-DUMPER SvREFCNT(this->data) = %lu\n", SvREFCNT(this->data));  }

////	$self->{data} = bubblesort($self->{data});
	this->data = bubblesort(this->data);
////};
}

////# [procedural programming interface]
////# original algorithm: comparison-based and stable [O(n**2) average time, O(1) worst-case extra space]
////# sort data, return sorted data
////our scalar_array_ref $bubblesort = sub {(my scalar_array_ref $data) = @_;
SV *bubblesort(SV *my_data)  // NEED ANSWER: is this properly grabbing argument named 'data', or improperly grabbing object property 'data'?
////;
{
	if (RPerl__DEBUG) { printf("in bubblesort(), top of subroutine, have pre-DUMPER SvREFCNT(my_data) = %lu\n", SvREFCNT(my_data));  printf("in bubblesort(), top of subroutine, have my_data = %s\n", RPerl_DUMPER__perl_from_c(my_data));  printf("in bubblesort(), top of subroutine, have post-DUMPER SvREFCNT(my_data) = %lu\n", SvREFCNT(my_data)); }

////	my int $is_sorted = 0;
	int is_sorted = 0;
////	my int $i;
	int i;
////	my const_int $data_length = scalar(@{$data});
//	const int data_length = av_len((AV*) SvRV(data)) + 1;  // NEED ENABLE: short-hand
	int data_length;  // NEED DISABLE: long-hand;  can't use const when modifying via long-hand below
	AV* data_av = (AV*) SvRV(my_data);  // NEED DISABLE: long-hand
	data_length = av_len(data_av) + 1;  // NEED DISABLE: long-hand
	SV *data_i;  // NEED DISABLE: long-hand
	SV *data_i_plus_1;  // NEED DISABLE: long-hand
//	SvREFCNT_inc(data_i_plus_1);

////	my scalar $swap;
	SV *swap;
//	SvREFCNT_inc(swap);
	
////#	print "in bubblesort(), have \$data_length = $data_length\n" if $RPerl::DEBUG;
	 if (RPerl__DEBUG) { printf("in bubblesort(), have data_length = %d\n", data_length); }  // NEED ADD: create new DEBUG flag?

////	# iterate through the length-n list up to n times (n * n == n**2), larger elements "bubble to the top" (end) of the list
////	while (not($is_sorted))
	while (not(is_sorted))
////	{
	{
////#		print "in bubblesort(), top of WHILE loop\n" if $RPerl::DEBUG;
	 if (RPerl__DEBUG) { printf("in bubblesort(), top of WHILE loop\n"); }
////		$is_sorted = 1;
		is_sorted = 1;
////		for ($i = 0; $i < ($data_length - 1); $i++)
		for (i = 0; i < (data_length - 1); i++)
////		{
		{
////#			print "in bubblesort(), inside for() loop, have \$i = $i\n" if $RPerl::DEBUG;
			if (RPerl__DEBUG) { printf("in bubblesort(), inside for() loop, have i = %d\n", i); }
////#			print "in bubblesort(), inside for() loop, have \$data\n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
			if (RPerl__DEBUG) { printf("in bubblesort(), inside for() loop, have pre-DUMPER SvREFCNT(my_data) = %lu\n", SvREFCNT(my_data));  printf("in bubblesort(), inside for() loop, have my_data = %s\n", RPerl_DUMPER__perl_from_c(my_data));  printf("in bubblesort(), inside for() loop, have post-DUMPER SvREFCNT(data) = %lu\n", SvREFCNT(my_data)); }  // NEED ADD: some way to actually access RPerl::DUMPER

////			# compare elements and swap if out-of-order, this is the core sort comparison
////			if ($data->[$i] > $data->[($i + 1)])
//			if (SvNV(AV_ELEMENT((AV*) SvRV(data), i)) > SvNV(AV_ELEMENT((AV*) SvRV(data), (i + 1))))  // NEED ENABLE: short-hand
			data_i = AV_ELEMENT(data_av, i);  // NEED DISABLE: long-hand
			data_i_plus_1 = AV_ELEMENT(data_av, (i + 1));  // NEED DISABLE: long-hand
			if (SvNV(data_i) > SvNV(data_i_plus_1))  // NEED ANSWER: assuming numeric value and using C++ numeric comparator, is this appropriate?  NEED DISABLE: long-hand
////			{
			{
////#				print "in bubblesort(), inside for() loop, SWAPPED\n" if $RPerl::DEBUG;
				if (RPerl__DEBUG) { printf("in bubblesort(), inside for() loop, SWAPPED\n"); }
////				$is_sorted = 0;
				is_sorted = 0;
////				$swap = $data->[$i];
//				swap = AV_ELEMENT((AV*) SvRV(data), i);  // NEED ENABLE: short-hand
				data_i = AV_ELEMENT(data_av, i);  // NEED DISABLE: long-hand
				swap = data_i;  // NEED DISABLE: long-hand
////				$data->[$i] = $data->[($i + 1)];
//				av_store((AV*) SvRV(data), i, AV_ELEMENT((AV*) SvRV(data), (i + 1)));  // NEED ENABLE: short-hand
				data_i_plus_1 = AV_ELEMENT(data_av, (i + 1));  // NEED DISABLE: long-hand
				av_store(data_av, i, SvREFCNT_inc(data_i_plus_1));  // NEED DISABLE: long-hand
//				av_store(data_av, i, data_i_plus_1);  // NEED DISABLE: long-hand
////				$data->[($i + 1)] = $swap;
//				av_store((AV*) SvRV(data), (i + 1), swap);  // NEED ENABLE: short-hand
				av_store(data_av, (i + 1), SvREFCNT_inc(swap));  // NEED DISABLE: long-hand
//				av_store(data_av, (i + 1), swap);  // NEED DISABLE: long-hand
////			}


				// START HERE: decrease ref count of swap and data_i_plus_1 from 33 down to 1


			}
////		}
		}
////	}
	}
	
	if (RPerl__DEBUG) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SvREFCNT(data_i_plus_1) = %lu\n", SvREFCNT(data_i_plus_1));  printf("in bubblesort(), bottom of subroutine, have data_i_plus_1 = %s\n", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), bottom of subroutine, have post-DUMPER SvREFCNT(data_i_plus_1) = %lu\n", SvREFCNT(data_i_plus_1)); }
	if (RPerl__DEBUG) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SvREFCNT(swap) = %lu\n", SvREFCNT(swap));  printf("in bubblesort(), bottom of subroutine, have swap = %s\n", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), bottom of subroutine, have post-DUMPER SvREFCNT(swap) = %lu\n", SvREFCNT(swap)); }
	if (RPerl__DEBUG) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SvREFCNT(my_data) = %lu\n", SvREFCNT(my_data));  printf("in bubblesort(), bottom of subroutine, have my_data = %s\n", RPerl_DUMPER__perl_from_c(my_data));  printf("in bubblesort(), bottom of subroutine, have post-DUMPER SvREFCNT(data) = %lu\n", SvREFCNT(my_data)); }

////	# data is now sorted via top-level nested iteration [O(n**2) total time, O(1) total extra space]
////	return $data;
	 return my_data;
////};
}

MODULE = RPerl::Algorithm::Sort_0e79        PACKAGE = RPerl::Algorithm::Sort::Bubble

PROTOTYPES: DISABLE

void
Bubble::sort_method()
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->sort_method();
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

SV *
Bubble::data_get()
    
void
Bubble::data_set(data_new)
	SV *	data_new
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->data_set(data_new);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

Bubble *
Bubble::new()
    
void
Bubble::DESTROY()
    
MODULE = RPerl::Algorithm::Sort_0e79        PACKAGE = RPerl::Algorithm::Sort  

PROTOTYPES: DISABLE

char *
RPerl_DUMPER__perl_from_c(dumpee)
	SV *	dumpee
    
SV *
bubblesort(data)
	SV *	data
    

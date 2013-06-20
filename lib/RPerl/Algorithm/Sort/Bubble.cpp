////use strict;  use warnings;
using std::cout;  using std::endl;

// NEED FIX: Bubble.cpp should not load HelperFunctions.cpp, only HelperFunctions.h?  where then would we load HelperFunctions.cpp?
//#include "/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/HelperFunctions.h"
#include "/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/HelperFunctions.cpp"
//#include <RPerl/HelperFunctions.cpp>

/*
// <<< TRANSLATED FUNCTION DECLARATIONS >>>
void not_inherited(SV *person);

////package RPerl::Algorithm::Sort;
////our @ISA = ('RPerl::Algorithm');
//class Sort : public Algorithm
class Sort
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void inherited(SV *person);

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS
	// NONE

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	Sort() {}
	~Sort() {}
//	AV *ISA = newAV();  // DEV NOTE: no programmatic or run-time modification of inheritance, @ISA made private in C++
//	av_push(ISA, SvREFCNT_inc(newSVpv("SOME::RPERL::PACKAGE::INDICATING::TRANSLATED::FROM::PERL::TO::CPP", 2112)));  // NEED ADD: actual package
//	av_push(ISA, SvREFCNT_inc(newSVpv("RPerl::Algorithm", 22)));  // NEED ANSWER: does this have to go inside the constructor?  if so, how to check class (not object) inheritance?

//private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
	// NONE
};

////our void__method $inherited = sub { (my object $self, my string $person) = @_;  print "[[[ HOWDY \$self $self \$person $person FROM INSIDE inherited()!!! ]]]\n"; };
//void Sort::inherited(SV *person) { printf("[[[ C++ HOWDY $self %d $person %s FROM INSIDE inherited()!!! ]]]\n", 2112, SvPV_nolen(person)); }
void Sort::inherited(SV *person) { cout << "[[[ C++ HOWDY $self " << this << " $person " << SvPV_nolen(person) << " FROM INSIDE inherited()!!! ]]]\n"; }

////our void $not_inherited = sub { (my string $person) = @_;  print "[[[ HOW DO YOU DO \$person $person FROM INSIDE not_inherited()... ]]]\n"; };
void not_inherited(SV *person) { printf("[[[ C++ HOW DO YOU DO $person %s FROM INSIDE not_inherited()... ]]]\n", SvPV_nolen(person)); }
*/


// NEED ANSWER: include through C++ and/or Perl because of namespace hack?
////use RPerl::Algorithm::Sort;
#include "/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm/Sort.cpp"
//#include <RPerl/Algorithm/Sort.cpp>

// <<< TRANSLATED FUNCTION DECLARATIONS >>>
SV *bubblesort(SV *data);

// DEV NOTE: currently using C++ single inheritance;  is it worth the bother fixing Inline::CPP to get multiple inheritance working?
// DEV NOTE: setting @ISA is handled in Bubble_cpp.pm
////package RPerl::Algorithm::Sort::Bubble;
////our @ISA = ('RPerl::Algorithm::Sort');
//	AV *ISA = newAV();  // DEV NOTE: no programmatic or run-time modification of inheritance, @ISA made private in C++
//	av_push(ISA, SvREFCNT_inc(newSVpv("SOME::RPERL::PACKAGE::INDICATING::TRANSLATED::FROM::PERL::TO::CPP", 2112)));  // NEED ADD: actual package
//	av_push(ISA, SvREFCNT_inc(newSVpv("RPerl::Algorithm::Sort", 22)));  // NEED ANSWER: does this need to go inside the constructor?  if so, how to check class (not object) inheritance?

//class Bubble : public Sort
class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort
{
public:
	// <<< TRANSLATED METHOD DECLARATIONS >>>
	void sort();  // NEED ANSWER: no named argument required for $self object?

	// <<< ACCESSOR & MUTATOR DECLARATIONS/DEFINITIONS >>>
	SV *get_data() { return SvREFCNT_inc(this->data); }
	void set_data(SV* data_new) { this->data = data_new; }

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
//	Bubble() {} // NEED ANSWER: need init() functionality?  need move @ISA definition here?
//	~Bubble() {}
	CPP__RPerl__Algorithm__Sort__Bubble() {} // NEED ANSWER: need init() functionality?  need move @ISA definition here?
	~CPP__RPerl__Algorithm__Sort__Bubble() {}

private:
	// <<< TRANSLATED PROPERTY DECLARATIONS >>>
////our %properties =
////(
////	data => my scalar_array_ref $KEY_data,
////);
	SV *data;
};

////# [object-oriented programming interface]
////# call out to sort data, return nothing
////our void__method $sort = sub {(my object $self) = @_;
//void Bubble::sort()
void CPP__RPerl__Algorithm__Sort__Bubble::sort()
////;
{
	if (RPerl__DEBUG2) { printf("in sort(), top of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n", SV_REFERENCE_COUNT(this->data));  printf("in sort(), top of subroutine, have this->data = %s", RPerl_DUMPER__perl_from_c(this->data));  printf("in sort(), top of subroutine, have post-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n\n", SV_REFERENCE_COUNT(this->data));  }

////	$self->{data} = bubblesort($self->{data});
	this->data = bubblesort(this->data);

	if (RPerl__DEBUG2) { printf("in sort(), bottom of subroutine, have pre-SvREFCNT_dec pre-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n", SV_REFERENCE_COUNT(this->data));  printf("in sort(), bottom of subroutine, have pre-SvREFCNT_dec this->data = %s", RPerl_DUMPER__perl_from_c(this->data));  printf("in sort(), bottom of subroutine, have pre-SvREFCNT_dec post-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n\n", SV_REFERENCE_COUNT(this->data));  }
	SvREFCNT_dec(this->data);
	if (RPerl__DEBUG2) { printf("in sort(), bottom of subroutine, have post-SvREFCNT_dec pre-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n", SV_REFERENCE_COUNT(this->data));  printf("in sort(), bottom of subroutine, have post-SvREFCNT_dec this->data = %s", RPerl_DUMPER__perl_from_c(this->data));  printf("in sort(), bottom of subroutine, have post-SvREFCNT_dec post-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n\n", SV_REFERENCE_COUNT(this->data));  }
//	if (RPerl__DEBUG2) { printf("in sort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n", SV_REFERENCE_COUNT(this->data));  printf("in sort(), bottom of subroutine, have this->data = %s", RPerl_DUMPER__perl_from_c(this->data));  printf("in sort(), bottom of subroutine, post-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n\n", SV_REFERENCE_COUNT(this->data));  }
////};
}

////# [procedural programming interface]
////# original algorithm: comparison-based and stable [O(n**2) average time, O(1) worst-case extra space]
////# sort data, return sorted data
////our scalar_array_ref $bubblesort = sub {(my scalar_array_ref $data) = @_;
SV *bubblesort(SV *data)  // DEV NOTE: properly creates local-to-function SV* data here, does not get confused with this->data object property, even though they share a name
////;
{
	RPerl_object_property_init(data); // NEED ANSWER: why do we need to do property init?
	SvREFCNT_inc(data);

	if (RPerl__DEBUG3) { printf("in bubblesort(), top of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), top of subroutine, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), top of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
////	my int $is_sorted = 0;
	int is_sorted = 0;
////	my int $i;
	int i;
////	my const_int $data_length = scalar(@{$data});
//	const int data_length = av_len((AV*) SvRV(data)) + 1;  // DE-OPTIMIZE, SHORT-HAND
	AV* data_av = (AV*) SvRV(data);  // OPTIMIZE, LONG-HAND: data dereferenced to data_av more than once, declare data_av and re-use, MUST REFRESH data_av for every assignment directly to data (none in this algorithm)
	const int data_length = av_len(data_av) + 1;  // OPTIMIZE, LONG-HAND: use data_av
	SV *data_i = newSV(0);  // OPTIMIZE, LONG-HAND: data element i accessed more than once, declare data_i and re-use;  all new SV*'s given initial undef newSV(0) value to avoid printf() errors during debugging
	SV *data_i_plus_1 = newSV(0);  // OPTIMIZE, LONG-HAND

////	my scalar $swap;
	SV *swap = newSV(0);

	if (RPerl__DEBUG2) { printf("in bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), after variable init, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
	if (RPerl__DEBUG2) { printf("in bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), after variable init, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
	if (RPerl__DEBUG2) { printf("in bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), after variable init, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

////#	print "in bubblesort(), have \$data_length = $data_length\n" if $RPerl::DEBUG;
	 if (RPerl__DEBUG2) { printf("in bubblesort(), after variable init, have data_length = %d\n", data_length); }

////	# iterate through the length-n list up to n times (n * n == n**2), larger elements "bubble to the top" (end) of the list
////	while (not($is_sorted))
	while (not(is_sorted))
////	{
	{
////#		print "in bubblesort(), top of while loop\n" if $RPerl::DEBUG;
		if (RPerl__DEBUG2) { printf("in bubblesort(), top of while() loop\n"); }
		if (RPerl__DEBUG3) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), top of while() loop, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
		if (RPerl__DEBUG) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), top of while() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
		if (RPerl__DEBUG) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), top of while() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
		if (RPerl__DEBUG) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), top of while() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

////		$is_sorted = 1;
		is_sorted = 1;
////		for ($i = 0; $i < ($data_length - 1); $i++)
		for (i = 0; i < (data_length - 1); i++)
////		{
		{
////#			print "in bubblesort(), inside for() loop, have \$i = $i\n" if $RPerl::DEBUG;
			if (RPerl__DEBUG2) { printf("in bubblesort(), top of for() loop, have i = %d\n", i); }
////#			print "in bubblesort(), inside for() loop, have \$data\n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
			if (RPerl__DEBUG3) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), top of for() loop, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
			if (RPerl__DEBUG) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), top of for() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
			if (RPerl__DEBUG) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), top of for() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
			if (RPerl__DEBUG) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), top of for() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

////			# compare elements and swap if out-of-order, this is the core sort comparison
////			if ($data->[$i] > $data->[($i + 1)])
//			if (SvNV(AV_ELEMENT((AV*) SvRV(data), i)) > SvNV(AV_ELEMENT((AV*) SvRV(data), (i + 1))))  // DE-OPTIMIZE, SHORT-HAND
			data_i = AV_ELEMENT(data_av, i);  // OPTIMIZE, LONG-HAND: use data_i and data_av
			data_i_plus_1 = AV_ELEMENT(data_av, (i + 1));  // OPTIMIZE, LONG-HAND: use data_i_plus_1 and data_av
			// NEED ANSWER: assuming numeric value and using C++ numeric comparator, is this appropriate?
			if (SvNV(data_i) > SvNV(data_i_plus_1))  // OPTIMIZE, LONG-HAND: use data_i and data_i_plus_1
////			{
			{
////#				print "in bubblesort(), inside for() loop, SWAPPED\n" if $RPerl::DEBUG;
				if (RPerl__DEBUG2) { printf("in bubblesort(), inside for() loop, SWAPPED\n"); }
////				$is_sorted = 0;
				is_sorted = 0;
////				$swap = $data->[$i];
//				swap = AV_ELEMENT((AV*) SvRV(data), i);  // DE-OPTIMIZE, SHORT-HAND
				data_i = AV_ELEMENT(data_av, i);  // OPTIMIZE, LONG-HAND: use data_i and data_av
				swap = data_i;  // OPTIMIZE, LONG-HAND: use data_i
////				$data->[$i] = $data->[($i + 1)];
//				av_store((AV*) SvRV(data), i, SvREFCNT_inc(AV_ELEMENT((AV*) SvRV(data), (i + 1))));  // DE-OPTIMIZE, SHORT-HAND
				data_i_plus_1 = AV_ELEMENT(data_av, (i + 1));  // OPTIMIZE, LONG-HAND: use data_i_plus_1 and data_av
				av_store(data_av, i, SvREFCNT_inc(data_i_plus_1));  // OPTIMIZE, LONG-HAND: use data_av and data_i_plus_1
////				$data->[($i + 1)] = $swap;
//				av_store((AV*) SvRV(data), (i + 1), SvREFCNT_inc(swap));  // DE-OPTIMIZE, SHORT-HAND
				av_store(data_av, (i + 1), SvREFCNT_inc(swap));  // OPTIMIZE, LONG-HAND: use data_av
////			}
			}
			if (RPerl__DEBUG3) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), bottom of for() loop, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
			if (RPerl__DEBUG) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), bottom of for() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
			if (RPerl__DEBUG) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), bottom of for() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
			if (RPerl__DEBUG) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), bottom of for() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }
////		}
		}
		if (RPerl__DEBUG3) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), bottom of while() loop, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
		if (RPerl__DEBUG) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), bottom of while() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
		if (RPerl__DEBUG) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), bottom of while() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
		if (RPerl__DEBUG) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), bottom of while() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }
////	}
	}

//	SvREFCNT_inc(data);
	if (RPerl__DEBUG3) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), bottom of subroutine, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
	if (RPerl__DEBUG) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), bottom of subroutine, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
	if (RPerl__DEBUG) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), bottom of subroutine, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
	if (RPerl__DEBUG) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), bottom of subroutine, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

////	# data is now sorted via top-level nested iteration [O(n**2) total time, O(1) total extra space]
////	return $data;
//	SvREFCNT_dec(data);
	return data;
////};
}

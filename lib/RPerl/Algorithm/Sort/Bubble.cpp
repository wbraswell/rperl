// <<< HELPER DEFINES >>>
#define RPerl__DEBUG 0  // NEED FIX: access actual inherited debug flag somehow?
#define RPerl__DEBUG2 0
#define RPerl__DEBUG3 0
#define AV_ELEMENT(av,index) ((av_fetch(av,index,0)!=NULL)?*av_fetch(av,index,0):newSV(0))
#define SV_REFERENCE_COUNT(sv) (SvREFCNT(sv))

// <<< HELPER FUNCTIONS >>
// NEED ANSWER: what in the hades does this property init function even do?  why do we need it???
void RPerl_object_property_init(SV* initee) { dSP; XPUSHs(initee); PUTBACK; call_pv("Dumper", G_SCALAR); }
char* RPerl_DUMPER__perl_from_c(SV* dumpee)
{
        dSP;
        int retcnt;
        char* retval;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP); XPUSHs(dumpee); PUTBACK;
        retcnt = call_pv("RPerl::DUMPER", G_SCALAR);
        SPAGAIN;
        if (retcnt != 1) { croak("RPerl::DUMPER(dumpee) return count is %d, expected 1, croaking", retcnt); }
        retval = POPp; PUTBACK;
//        FREETMPS;
        LEAVE;

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
	// DEV NOTE: require ac
//	SV *data_get() { return SvREFCNT_inc(this->data); }
	SV *data_get()
	{
		// these printf() statements DO NOT increase the refcounts of data_i, data_i_plus_1, and swap
		//if (RPerl__DEBUG2) { printf("in data_get(), have initial SV_REFERENCE_COUNT(this->data) = %lu\n", SV_REFERENCE_COUNT(this->data)); }
		SvREFCNT_inc(this->data);
		//if (RPerl__DEBUG2) { printf("in data_get(), have incremented SV_REFERENCE_COUNT(this->data) = %lu\n\n", SV_REFERENCE_COUNT(this->data)); }
		return this->data;
	}
//	SV *data_get() { return this->data; }
//	void data_set(SV* data_new) { this->data = SvREFCNT_inc(data_new); }
	void data_set(SV* data_new)
	{
		// these printf() statements DO NOT increase the refcounts of data_i, data_i_plus_1, and swap
		//if (RPerl__DEBUG2) { printf("in data_set(), have initial SV_REFERENCE_COUNT(this->data) = %lu\n", SV_REFERENCE_COUNT(this->data)); }
		this->data = SvREFCNT_inc(data_new);
		//if (RPerl__DEBUG2) { printf("in data_set(), have incremented SV_REFERENCE_COUNT(this->data) = %lu\n\n", SV_REFERENCE_COUNT(this->data)); }
	}
//	void data_set(SV* data_new) { this->data = data_new; }

	// <<< CONSTRUCTOR & DESTRUCTOR DECLARATIONS/DEFINITIONS >>>
	Bubble()
	{
		// these printf() statements DO NOT increase the refcounts of data_i, data_i_plus_1, and swap
		//if (RPerl__DEBUG2) { printf("in Bubble(), have initial SV_REFERENCE_COUNT(this->data) = %lu\n", SV_REFERENCE_COUNT(this->data)); }
		this->data = newSV(0);
		//if (RPerl__DEBUG2) { printf("in Bubble(), have post-newSV(0) SV_REFERENCE_COUNT(this->data) = %lu\n", SV_REFERENCE_COUNT(this->data)); }
	}  // NEED ANSWER: need init() functionality?  need move @ISA definition here?
	~Bubble()
	{
		// these printf() statements DO NOT increase the refcounts of data_i, data_i_plus_1, and swap
		//if (RPerl__DEBUG2) { printf("in ~Bubble(), have initial SV_REFERENCE_COUNT(this->data) = %lu\n", SV_REFERENCE_COUNT(this->data)); }
		SvREFCNT_dec(this->data);
		//if (RPerl__DEBUG2) { printf("in ~Bubble(), have decremented SV_REFERENCE_COUNT(this->data) = %lu\n\n", SV_REFERENCE_COUNT(this->data)); }
	}
//	~Bubble(){ SvREFCNT_dec(this->data); }

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
	// NEED ANSWER: should property init go here or in bubblesort()?  why do we even need it???
	RPerl_object_property_init(this->data);

	// this printf() statement increases the refcounts of data_i, data_i_plus_1, and swap
	//if (RPerl__DEBUG3) { printf("in sort_method(), top of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n", SV_REFERENCE_COUNT(this->data));  printf("in sort_method(), top of subroutine, have this->data = %s", RPerl_DUMPER__perl_from_c(this->data));  printf("in sort_method(), top of subroutine, have post-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n\n", SV_REFERENCE_COUNT(this->data));  }

////	$self->{data} = bubblesort($self->{data});
	this->data = bubblesort(this->data);

	// this printf() statement DOES NOT increase the refcounts of data_i, data_i_plus_1, and swap
	//if (RPerl__DEBUG2) { printf("in sort_method(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n", SV_REFERENCE_COUNT(this->data));  printf("in sort_method(), bottom of subroutine, have this->data = %s", RPerl_DUMPER__perl_from_c(this->data));  printf("in sort_method(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n\n", SV_REFERENCE_COUNT(this->data));  }
////};
}

////# [procedural programming interface]
////# original algorithm: comparison-based and stable [O(n**2) average time, O(1) worst-case extra space]
////# sort data, return sorted data
////our scalar_array_ref $bubblesort = sub {(my scalar_array_ref $data) = @_;
SV *bubblesort(SV *data)  // NEED ANSWER: is this properly grabbing argument named 'data', or improperly grabbing object property 'data'?
////;
{
	// this printf() statements increases the refcounts of data_i, data_i_plus_1, and swap
	//if (RPerl__DEBUG3) { printf("in bubblesort(), top of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), top of subroutine, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), top of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
////	my int $is_sorted = 0;
	int is_sorted = 0;
////	my int $i;
	int i;
////	my const_int $data_length = scalar(@{$data});
//	const int data_length = av_len((AV*) SvRV(data)) + 1;  // NEED ENABLE: short-hand
	int data_length;  // NEED DISABLE: long-hand;  can't use const when modifying via long-hand below
	AV* data_av = (AV*) SvRV(data);  // NEED DISABLE: long-hand
	data_length = av_len(data_av) + 1;  // NEED DISABLE: long-hand
	SV *data_i = newSV(0);  // NEED DISABLE: long-hand
	SV *data_i_plus_1 = newSV(0);  // NEED DISABLE: long-hand

////	my scalar $swap;
	SV *swap = newSV(0);
	
	// these printf() statements DO NOT increase the refcounts of data_i, data_i_plus_1, and swap
	//if (RPerl__DEBUG2) { printf("in bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), after variable init, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
	//if (RPerl__DEBUG2) { printf("in bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), after variable init, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
	//if (RPerl__DEBUG2) { printf("in bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), after variable init, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

////#	print "in bubblesort(), have \$data_length = $data_length\n" if $RPerl::DEBUG;
	// this printf() statement DOES NOT increase the refcounts of data_i, data_i_plus_1, and swap
	 //if (RPerl__DEBUG2) { printf("in bubblesort(), after variable init, have data_length = %d\n", data_length); }

////	# iterate through the length-n list up to n times (n * n == n**2), larger elements "bubble to the top" (end) of the list
////	while (not($is_sorted))
	while (not(is_sorted))
////	{
	{
////#		print "in bubblesort(), top of while loop\n" if $RPerl::DEBUG;
		// this printf() statement DOES NOT increase the refcounts of data_i, data_i_plus_1, and swap
		//if (RPerl__DEBUG2) { printf("in bubblesort(), top of while() loop\n"); }
		// this printf() statement increases the refcounts of data_i, data_i_plus_1, and swap
		//if (RPerl__DEBUG3) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), top of while() loop, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
		// these printf() statements DO NOT increase the refcounts of data_i, data_i_plus_1, and swap
		//if (RPerl__DEBUG) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), top of while() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
		//if (RPerl__DEBUG) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), top of while() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
		//if (RPerl__DEBUG) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), top of while() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

////		$is_sorted = 1;
		is_sorted = 1;
////		for ($i = 0; $i < ($data_length - 1); $i++)
		for (i = 0; i < (data_length - 1); i++)
////		{
		{
////#			print "in bubblesort(), inside for() loop, have \$i = $i\n" if $RPerl::DEBUG;
			// this printf() statement DOES NOT increase the refcounts of data_i, data_i_plus_1, and swap
			//if (RPerl__DEBUG2) { printf("in bubblesort(), top of for() loop, have i = %d\n", i); }
////#			print "in bubblesort(), inside for() loop, have \$data\n" . RPerl::DUMPER($data) . "\n" if $RPerl::DEBUG;
			// this printf() statement increases the refcounts of data_i, data_i_plus_1, and swap
			//if (RPerl__DEBUG3) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), top of for() loop, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
			// these printf() statements DO NOT increase the refcounts of data_i, data_i_plus_1, and swap
			//if (RPerl__DEBUG) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), top of for() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
			//if (RPerl__DEBUG) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), top of for() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
			//if (RPerl__DEBUG) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), top of for() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

			// NEED ANSWER: does property init go here or in sort_method()?  why do we even need it???
//			RPerl_object_property_init(data);

////			# compare elements and swap if out-of-order, this is the core sort comparison
////			if ($data->[$i] > $data->[($i + 1)])
//			if (SvNV(AV_ELEMENT((AV*) SvRV(data), i)) > SvNV(AV_ELEMENT((AV*) SvRV(data), (i + 1))))  // NEED ENABLE: short-hand
			data_i = AV_ELEMENT(data_av, i);  // NEED DISABLE: long-hand
			data_i_plus_1 = AV_ELEMENT(data_av, (i + 1));  // NEED DISABLE: long-hand
			if (SvNV(data_i) > SvNV(data_i_plus_1))  // NEED ANSWER: assuming numeric value and using C++ numeric comparator, is this appropriate?  NEED DISABLE: long-hand
////			{
			{
////#				print "in bubblesort(), inside for() loop, SWAPPED\n" if $RPerl::DEBUG;
				// this printf() statement DOES NOT increase the refcounts of data_i, data_i_plus_1, and swap
				//if (RPerl__DEBUG2) { printf("in bubblesort(), inside for() loop, SWAPPED\n"); }
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
			}
			// this printf() statement increases the refcounts of data_i, data_i_plus_1, and swap
			//if (RPerl__DEBUG3) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), bottom of for() loop, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
			// these printf() statements DO NOT increase the refcounts of data_i, data_i_plus_1, and swap
			//if (RPerl__DEBUG) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), bottom of for() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
			//if (RPerl__DEBUG) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), bottom of for() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
			//if (RPerl__DEBUG) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), bottom of for() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }
////		}
		}
		// this printf() statement increases the refcounts of data_i, data_i_plus_1, and swap
		//if (RPerl__DEBUG3) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), bottom of while() loop, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
		// these printf() statements DO NOT increase the refcounts of data_i, data_i_plus_1, and swap
		//if (RPerl__DEBUG) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), bottom of while() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
		//if (RPerl__DEBUG) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), bottom of while() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
		//if (RPerl__DEBUG) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), bottom of while() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }
////	}
	}
	
	// this printf() statement increases the refcounts of data_i, data_i_plus_1, and swap
	//if (RPerl__DEBUG3) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", SV_REFERENCE_COUNT(data));  printf("in bubblesort(), bottom of subroutine, have data = %s", RPerl_DUMPER__perl_from_c(data));  printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", SV_REFERENCE_COUNT(data)); }
	// these printf() statements DO NOT increase the refcounts of data_i, data_i_plus_1, and swap
	//if (RPerl__DEBUG) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", SV_REFERENCE_COUNT(data_i));  printf("in bubblesort(), bottom of subroutine, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i));  printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", SV_REFERENCE_COUNT(data_i)); }
	//if (RPerl__DEBUG) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", SV_REFERENCE_COUNT(data_i_plus_1));  printf("in bubblesort(), bottom of subroutine, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1));  printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", SV_REFERENCE_COUNT(data_i_plus_1)); }
	//if (RPerl__DEBUG) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", SV_REFERENCE_COUNT(swap));  printf("in bubblesort(), bottom of subroutine, have swap = %s", RPerl_DUMPER__perl_from_c(swap));  printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", SV_REFERENCE_COUNT(swap)); }

////	# data is now sorted via top-level nested iteration [O(n**2) total time, O(1) total extra space]
////	return $data;
	 return data;
////};
}

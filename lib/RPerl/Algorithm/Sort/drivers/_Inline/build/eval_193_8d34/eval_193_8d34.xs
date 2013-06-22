
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

# 1 "/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm/Sort/drivers/_Inline/build/eval_193_8d34/Filters.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm/Sort/drivers/_Inline/build/eval_193_8d34/Filters.c"

using std::cout; using std::endl;

# 1 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort/Bubble.h" 1

using std::cout; using std::endl;

# 1 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c" 1
# 1 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.h" 1
# 13 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.h"
void RPerl_object_property_init(SV* initee);
char* RPerl_DUMPER__perl_from_c(SV* dumpee);
# 2 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c" 2





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

        LEAVE;

        return retval;
}
# 5 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort/Bubble.h" 2


# 1 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort.cpp" 1

using std::cout; using std::endl;

# 1 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort.h" 1

using std::cout; using std::endl;

# 1 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c" 1
# 1 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.h" 1
# 2 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c" 2
# 5 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort.h" 2



# 1 "/tmp/RPerl-latest/lib/RPerl/Algorithm.cpp" 1

using std::cout; using std::endl;

# 1 "/tmp/RPerl-latest/lib/RPerl/Algorithm.h" 1

using std::cout; using std::endl;

# 1 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c" 1
# 1 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.h" 1
# 2 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c" 2
# 5 "/tmp/RPerl-latest/lib/RPerl/Algorithm.h" 2
# 17 "/tmp/RPerl-latest/lib/RPerl/Algorithm.h"
SV *uninherited__Algorithm(SV *person);
SV *uninherited(SV *person);




class CPP__RPerl__Algorithm
{
public:


 void inherited__Algorithm(SV *person);




 void CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW();

 CPP__RPerl__Algorithm() {}
 ~CPP__RPerl__Algorithm() {}




};
# 5 "/tmp/RPerl-latest/lib/RPerl/Algorithm.cpp" 2






void CPP__RPerl__Algorithm::inherited__Algorithm(SV *person) { cout << "in C++ PERL_TYPES Algorithm->inherited__Algorithm(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', FNORD\n"; }





SV *uninherited__Algorithm(SV *person) { cout << "in C++ PERL_TYPES Algorithm::uninherited__Algorithm(), have $person = '" << SvPV_nolen(person) << "', MYSTIC\n"; return newSVpv("C++ PERL_TYPES Algorithm::uninherited__Algorithm() RULES!", 0); }


SV *uninherited(SV *person) { cout << "in C++ PERL_TYPES Algorithm::uninherited(), have $person = '" << SvPV_nolen(person) << "', TERRITORY\n"; return newSVpv("C++ PERL_TYPES Algorithm::uninherited() RULES!", 0); }
# 9 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort.h" 2






SV *uninherited__Sort(SV *person);




class CPP__RPerl__Algorithm__Sort : public CPP__RPerl__Algorithm
{
public:


 void inherited__Sort(SV *person);




 void CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW();

 CPP__RPerl__Algorithm__Sort() {}
 ~CPP__RPerl__Algorithm__Sort() {}




};
# 5 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort.cpp" 2






void CPP__RPerl__Algorithm__Sort::inherited__Sort(SV *person) { cout << "in C++ PERL_TYPES Sort->inherited__Sort(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', FISH\n"; }





SV *uninherited__Sort(SV *person) { cout << "in C++ PERL_TYPES Sort::uninherited__Sort(), have $person = '" << SvPV_nolen(person) << "', MY\n"; return newSVpv("C++ PERL_TYPES Sort::uninherited__Sort() RULES!", 0); }
# 8 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort/Bubble.h" 2



# 1 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Inefficient.cpp" 1

using std::cout; using std::endl;

# 1 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Inefficient.h" 1

using std::cout; using std::endl;

# 1 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c" 1
# 1 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.h" 1
# 2 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c" 2
# 5 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Inefficient.h" 2



# 1 "/tmp/RPerl-latest/lib/RPerl/Algorithm.cpp" 1

using std::cout; using std::endl;

# 1 "/tmp/RPerl-latest/lib/RPerl/Algorithm.h" 1

using std::cout; using std::endl;

# 1 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c" 1
# 1 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.h" 1
# 2 "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.c" 2
# 5 "/tmp/RPerl-latest/lib/RPerl/Algorithm.h" 2
# 5 "/tmp/RPerl-latest/lib/RPerl/Algorithm.cpp" 2
# 9 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Inefficient.h" 2






SV *uninherited__Inefficient(SV *person);




class CPP__RPerl__Algorithm__Inefficient : public CPP__RPerl__Algorithm
{
public:


 void inherited__Inefficient(SV *person);
 void inherited(SV *person);



 void CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW();

 CPP__RPerl__Algorithm__Inefficient() {}
 ~CPP__RPerl__Algorithm__Inefficient() {}




};
# 5 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Inefficient.cpp" 2






void CPP__RPerl__Algorithm__Inefficient::inherited__Inefficient(SV *person) { cout << "in C++ PERL_TYPES Inefficient->inherited__Inefficient(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', FLUFFY\n"; }


void CPP__RPerl__Algorithm__Inefficient::inherited(SV *person) { cout << "in C++ PERL_TYPES Inefficient->inherited(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', INCOMPATIBLE\n"; }


SV *uninherited__Inefficient(SV *person) { cout << "in C++ PERL_TYPES Inefficient::uninherited__Inefficient(), have $person = '" << SvPV_nolen(person) << "', MESSY\n"; return newSVpv("C++ PERL_TYPES Inefficient::uninherited__Inefficient() RULES!", 0); }
# 12 "/tmp/RPerl-latest/lib/RPerl/Algorithm/Sort/Bubble.h" 2





SV *bubblesort(SV *data);

SV *uninherited__Bubble(SV *person);





class CPP__RPerl__Algorithm__Sort__Bubble : public CPP__RPerl__Algorithm__Sort, public CPP__RPerl__Algorithm__Inefficient
{
public:

 void sort();

 void inherited__Bubble(SV *person);



 SV *get_data() { return SvREFCNT_inc(this->data); }
 void set_data(SV* data_new) { this->data = data_new; }


 CPP__RPerl__Algorithm__Sort__Bubble() {}
 ~CPP__RPerl__Algorithm__Sort__Bubble() {}

private:





 SV *data;
};
# 5 "/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm/Sort/drivers/_Inline/build/eval_193_8d34/Filters.c" 2
# 13 "/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm/Sort/drivers/_Inline/build/eval_193_8d34/Filters.c"
void CPP__RPerl__Algorithm__Sort__Bubble::sort()

{
 if (0) { printf("in sort(), top of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n", (SvREFCNT(this->data))); printf("in sort(), top of subroutine, have this->data = %s", RPerl_DUMPER__perl_from_c(this->data)); printf("in sort(), top of subroutine, have post-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n\n", (SvREFCNT(this->data))); }


 this->data = bubblesort(this->data);

 if (0) { printf("in sort(), bottom of subroutine, have pre-SvREFCNT_dec pre-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n", (SvREFCNT(this->data))); printf("in sort(), bottom of subroutine, have pre-SvREFCNT_dec this->data = %s", RPerl_DUMPER__perl_from_c(this->data)); printf("in sort(), bottom of subroutine, have pre-SvREFCNT_dec post-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n\n", (SvREFCNT(this->data))); }
 SvREFCNT_dec(this->data);
 if (0) { printf("in sort(), bottom of subroutine, have post-SvREFCNT_dec pre-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n", (SvREFCNT(this->data))); printf("in sort(), bottom of subroutine, have post-SvREFCNT_dec this->data = %s", RPerl_DUMPER__perl_from_c(this->data)); printf("in sort(), bottom of subroutine, have post-SvREFCNT_dec post-DUMPER SV_REFERENCE_COUNT(this->data) = %lu\n\n", (SvREFCNT(this->data))); }


}





SV *bubblesort(SV *data)

{
 RPerl_object_property_init(data);
 SvREFCNT_inc(data);

 if (0) { printf("in bubblesort(), top of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", (SvREFCNT(data))); printf("in bubblesort(), top of subroutine, have data = %s", RPerl_DUMPER__perl_from_c(data)); printf("in bubblesort(), top of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", (SvREFCNT(data))); }

 int is_sorted = 0;

 int i;


 AV* data_av = (AV*) SvRV(data);
 const int data_length = av_len(data_av) + 1;
 SV *data_i = newSV(0);
 SV *data_i_plus_1 = newSV(0);


 SV *swap = newSV(0);

 if (0) { printf("in bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", (SvREFCNT(data_i))); printf("in bubblesort(), after variable init, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i)); printf("in bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", (SvREFCNT(data_i))); }
 if (0) { printf("in bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", (SvREFCNT(data_i_plus_1))); printf("in bubblesort(), after variable init, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1)); printf("in bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", (SvREFCNT(data_i_plus_1))); }
 if (0) { printf("in bubblesort(), after variable init, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", (SvREFCNT(swap))); printf("in bubblesort(), after variable init, have swap = %s", RPerl_DUMPER__perl_from_c(swap)); printf("in bubblesort(), after variable init, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", (SvREFCNT(swap))); }


  if (0) { printf("in bubblesort(), after variable init, have data_length = %d\n", data_length); }



 while (not(is_sorted))

 {

  if (0) { printf("in bubblesort(), top of while() loop\n"); }
  if (0) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", (SvREFCNT(data))); printf("in bubblesort(), top of while() loop, have data = %s", RPerl_DUMPER__perl_from_c(data)); printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", (SvREFCNT(data))); }
  if (0) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", (SvREFCNT(data_i))); printf("in bubblesort(), top of while() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i)); printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", (SvREFCNT(data_i))); }
  if (0) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", (SvREFCNT(data_i_plus_1))); printf("in bubblesort(), top of while() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1)); printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", (SvREFCNT(data_i_plus_1))); }
  if (0) { printf("in bubblesort(), top of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", (SvREFCNT(swap))); printf("in bubblesort(), top of while() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap)); printf("in bubblesort(), top of while() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", (SvREFCNT(swap))); }


  is_sorted = 1;

  for (i = 0; i < (data_length - 1); i++)

  {

   if (0) { printf("in bubblesort(), top of for() loop, have i = %d\n", i); }

   if (0) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", (SvREFCNT(data))); printf("in bubblesort(), top of for() loop, have data = %s", RPerl_DUMPER__perl_from_c(data)); printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", (SvREFCNT(data))); }
   if (0) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", (SvREFCNT(data_i))); printf("in bubblesort(), top of for() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i)); printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", (SvREFCNT(data_i))); }
   if (0) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", (SvREFCNT(data_i_plus_1))); printf("in bubblesort(), top of for() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1)); printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", (SvREFCNT(data_i_plus_1))); }
   if (0) { printf("in bubblesort(), top of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", (SvREFCNT(swap))); printf("in bubblesort(), top of for() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap)); printf("in bubblesort(), top of for() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", (SvREFCNT(swap))); }




   data_i = ((av_fetch(data_av,i,0)!=NULL)?*av_fetch(data_av,i,0):newSV(0));
   data_i_plus_1 = ((av_fetch(data_av,(i + 1),0)!=NULL)?*av_fetch(data_av,(i + 1),0):newSV(0));

   if (SvNV(data_i) > SvNV(data_i_plus_1))

   {

    if (0) { printf("in bubblesort(), inside for() loop, SWAPPED\n"); }

    is_sorted = 0;


    data_i = ((av_fetch(data_av,i,0)!=NULL)?*av_fetch(data_av,i,0):newSV(0));
    swap = data_i;


    data_i_plus_1 = ((av_fetch(data_av,(i + 1),0)!=NULL)?*av_fetch(data_av,(i + 1),0):newSV(0));
    av_store(data_av, i, SvREFCNT_inc(data_i_plus_1));


    av_store(data_av, (i + 1), SvREFCNT_inc(swap));

   }
   if (0) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", (SvREFCNT(data))); printf("in bubblesort(), bottom of for() loop, have data = %s", RPerl_DUMPER__perl_from_c(data)); printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", (SvREFCNT(data))); }
   if (0) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", (SvREFCNT(data_i))); printf("in bubblesort(), bottom of for() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i)); printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", (SvREFCNT(data_i))); }
   if (0) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", (SvREFCNT(data_i_plus_1))); printf("in bubblesort(), bottom of for() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1)); printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", (SvREFCNT(data_i_plus_1))); }
   if (0) { printf("in bubblesort(), bottom of for() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", (SvREFCNT(swap))); printf("in bubblesort(), bottom of for() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap)); printf("in bubblesort(), bottom of for() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", (SvREFCNT(swap))); }

  }
  if (0) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", (SvREFCNT(data))); printf("in bubblesort(), bottom of while() loop, have data = %s", RPerl_DUMPER__perl_from_c(data)); printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", (SvREFCNT(data))); }
  if (0) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", (SvREFCNT(data_i))); printf("in bubblesort(), bottom of while() loop, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i)); printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", (SvREFCNT(data_i))); }
  if (0) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", (SvREFCNT(data_i_plus_1))); printf("in bubblesort(), bottom of while() loop, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1)); printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", (SvREFCNT(data_i_plus_1))); }
  if (0) { printf("in bubblesort(), bottom of while() loop, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", (SvREFCNT(swap))); printf("in bubblesort(), bottom of while() loop, have swap = %s", RPerl_DUMPER__perl_from_c(swap)); printf("in bubblesort(), bottom of while() loop, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", (SvREFCNT(swap))); }

 }


 if (0) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data) = %lu\n", (SvREFCNT(data))); printf("in bubblesort(), bottom of subroutine, have data = %s", RPerl_DUMPER__perl_from_c(data)); printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data) = %lu\n\n", (SvREFCNT(data))); }
 if (0) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n", (SvREFCNT(data_i))); printf("in bubblesort(), bottom of subroutine, have data_i = %s", RPerl_DUMPER__perl_from_c(data_i)); printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data_i) = %lu\n\n", (SvREFCNT(data_i))); }
 if (0) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n", (SvREFCNT(data_i_plus_1))); printf("in bubblesort(), bottom of subroutine, have data_i_plus_1 = %s", RPerl_DUMPER__perl_from_c(data_i_plus_1)); printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(data_i_plus_1) = %lu\n\n", (SvREFCNT(data_i_plus_1))); }
 if (0) { printf("in bubblesort(), bottom of subroutine, have pre-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n", (SvREFCNT(swap))); printf("in bubblesort(), bottom of subroutine, have swap = %s", RPerl_DUMPER__perl_from_c(swap)); printf("in bubblesort(), bottom of subroutine, have post-DUMPER SV_REFERENCE_COUNT(swap) = %lu\n\n", (SvREFCNT(swap))); }




 return data;

}



void CPP__RPerl__Algorithm__Sort__Bubble::inherited__Bubble(SV *person) { cout << "in C++ PERL_TYPES Bubble->inherited__Bubble(), have $self = '" << this << "' and $person = '" << SvPV_nolen(person) << "', FRIED\n"; }





SV *uninherited__Bubble(SV *person) { cout << "in C++ PERL_TYPES Bubble::uninherited__Bubble(), have $person = '" << SvPV_nolen(person) << "', MITOCHONDRIAL\n"; return newSVpv("C++ PERL_TYPES Bubble::uninherited__Bubble() RULES!", 0); }

MODULE = eval_193_8d34        PACKAGE = main::CPP__RPerl__Algorithm

PROTOTYPES: DISABLE

void
CPP__RPerl__Algorithm::inherited__Algorithm(person)
	SV *	person
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->inherited__Algorithm(person);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
CPP__RPerl__Algorithm::CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW()
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW();
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

CPP__RPerl__Algorithm *
CPP__RPerl__Algorithm::new()
    
void
CPP__RPerl__Algorithm::DESTROY()
    

MODULE = eval_193_8d34        PACKAGE = main::CPP__RPerl__Algorithm__Sort

PROTOTYPES: DISABLE

void
CPP__RPerl__Algorithm__Sort::inherited__Sort(person)
	SV *	person
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->inherited__Sort(person);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
CPP__RPerl__Algorithm__Sort::CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW()
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW();
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

CPP__RPerl__Algorithm__Sort *
CPP__RPerl__Algorithm__Sort::new()
    
void
CPP__RPerl__Algorithm__Sort::DESTROY()
    

MODULE = eval_193_8d34        PACKAGE = main::CPP__RPerl__Algorithm__Inefficient

PROTOTYPES: DISABLE

void
CPP__RPerl__Algorithm__Inefficient::inherited__Inefficient(person)
	SV *	person
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->inherited__Inefficient(person);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
CPP__RPerl__Algorithm__Inefficient::inherited(person)
	SV *	person
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->inherited(person);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
CPP__RPerl__Algorithm__Inefficient::CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW()
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->CRAZY_INLINE_CPP_BUG__CAN_NOT_HAVE_MORE_THAN_7_BLANK_OR_COMMENT_LINES_IN_A_ROW();
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

CPP__RPerl__Algorithm__Inefficient *
CPP__RPerl__Algorithm__Inefficient::new()
    
void
CPP__RPerl__Algorithm__Inefficient::DESTROY()
    

MODULE = eval_193_8d34        PACKAGE = main::CPP__RPerl__Algorithm__Sort__Bubble

PROTOTYPES: DISABLE

void
CPP__RPerl__Algorithm__Sort__Bubble::sort()
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->sort();
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
CPP__RPerl__Algorithm__Sort__Bubble::inherited__Bubble(person)
	SV *	person
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->inherited__Bubble(person);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

SV *
CPP__RPerl__Algorithm__Sort__Bubble::get_data()
    
void
CPP__RPerl__Algorithm__Sort__Bubble::set_data(data_new)
	SV *	data_new
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->set_data(data_new);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

CPP__RPerl__Algorithm__Sort__Bubble *
CPP__RPerl__Algorithm__Sort__Bubble::new()
    
void
CPP__RPerl__Algorithm__Sort__Bubble::DESTROY()
    
MODULE = eval_193_8d34        PACKAGE = main  

PROTOTYPES: DISABLE

void
RPerl_object_property_init(initee)
	SV *	initee
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	RPerl_object_property_init(initee);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

char *
RPerl_DUMPER__perl_from_c(dumpee)
	SV *	dumpee
    
SV *
uninherited__Algorithm(person)
	SV *	person
    
SV *
uninherited(person)
	SV *	person
    
SV *
uninherited__Sort(person)
	SV *	person
    
SV *
uninherited__Inefficient(person)
	SV *	person
    
SV *
bubblesort(data)
	SV *	data
    
SV *
uninherited__Bubble(person)
	SV *	person
    
BOOT:
{
#ifndef get_av
    AV *isa = perl_get_av("main::CPP__RPerl__Algorithm__Sort::ISA", 1);
#else
    AV *isa = get_av("main::CPP__RPerl__Algorithm__Sort::ISA", 1);
#endif
    av_push(isa, newSVpv("main::CPP__RPerl__Algorithm", 0));
}
{
#ifndef get_av
    AV *isa = perl_get_av("main::CPP__RPerl__Algorithm__Inefficient::ISA", 1);
#else
    AV *isa = get_av("main::CPP__RPerl__Algorithm__Inefficient::ISA", 1);
#endif
    av_push(isa, newSVpv("main::CPP__RPerl__Algorithm", 0));
}
{
#ifndef get_av
    AV *isa = perl_get_av("main::CPP__RPerl__Algorithm__Sort__Bubble::ISA", 1);
#else
    AV *isa = get_av("main::CPP__RPerl__Algorithm__Sort__Bubble::ISA", 1);
#endif
    av_push(isa, newSVpv("main::CPP__RPerl__Algorithm__Sort", 0));
}
{
#ifndef get_av
    AV *isa = perl_get_av("main::CPP__RPerl__Algorithm__Sort__Bubble::ISA", 1);
#else
    AV *isa = get_av("main::CPP__RPerl__Algorithm__Sort__Bubble::ISA", 1);
#endif
    av_push(isa, newSVpv("main::CPP__RPerl__Algorithm__Inefficient", 0));
}


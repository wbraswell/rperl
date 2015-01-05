
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

#include <iostream>
#include <string>
#include <sstream>
#include <limits>
#include <vector>
#include <unordered_map>
# 1 "/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib/RPerl/Test/OperationsTypesReporting/_Inline/build/eval_9_d115/Filters19232.c"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib/RPerl/Test/OperationsTypesReporting/_Inline/build/eval_9_d115/Filters19232.c"



# 1 "/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib/RPerl/HelperFunctions.h" 1
# 40 "/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib/RPerl/HelperFunctions.h"
int RPerl_SvIOKp(SV* input_sv);
int RPerl_SvNOKp(SV* input_sv);
int RPerl_SvPOKp(SV* input_sv);
int RPerl_SvAROKp(SV* input_av_ref);
int RPerl_SvHROKp(SV* input_hv_ref);

void RPerl_object_property_init(SV* initee);
char* RPerl_DUMPER__perl_from_c(SV* dumpee);


SV* RPerl__HelperFunctions__ops() { return(newSVpv("CPP", 3)); }
# 5 "/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib/RPerl/Test/OperationsTypesReporting/_Inline/build/eval_9_d115/Filters19232.c" 2


int RPerl_SvIOKp(SV* input_sv) { return(SvIOKp(input_sv)); }
int RPerl_SvNOKp(SV* input_sv) { return(SvNOKp(input_sv)); }
int RPerl_SvPOKp(SV* input_sv) { return(SvPOKp(input_sv)); }
int RPerl_SvAROKp(SV* input_av_ref) { return((SvROK(input_av_ref) && (SvTYPE(SvRV(input_av_ref)) == SVt_PVAV))); }
int RPerl_SvHROKp(SV* input_hv_ref) { return((SvROK(input_hv_ref) && (SvTYPE(SvRV(input_hv_ref)) == SVt_PVHV))); }


void RPerl_object_property_init(SV* initee)
{
 dSP;
 PUSHMARK(SP);
 XPUSHs(initee);
 PUTBACK;
 call_pv("Dumper", G_SCALAR);

}

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

MODULE = eval_9_d115        PACKAGE = main  

PROTOTYPES: DISABLE

int
RPerl_SvIOKp(input_sv)
	SV *	input_sv
    
int
RPerl_SvNOKp(input_sv)
	SV *	input_sv
    
int
RPerl_SvPOKp(input_sv)
	SV *	input_sv
    
int
RPerl_SvAROKp(input_av_ref)
	SV *	input_av_ref
    
int
RPerl_SvHROKp(input_hv_ref)
	SV *	input_hv_ref
    
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
RPerl__HelperFunctions__ops()
    

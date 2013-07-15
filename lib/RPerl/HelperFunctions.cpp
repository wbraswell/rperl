#ifndef __CPP__INCLUDED__RPerl__HelperFunctions_cpp
#define __CPP__INCLUDED__RPerl__HelperFunctions_cpp 1

#include <RPerl/HelperFunctions.h>  // -> ???

// <<< HELPER FUNCTION DEFINITIONS >>
int RPerl_SvIOKp(SV* input_sv) { return(SvIOKp(input_sv)); }
int RPerl_SvNOKp(SV* input_sv) { return(SvNOKp(input_sv)); }
int RPerl_SvPOKp(SV* input_sv) { return(SvPOKp(input_sv)); }

void RPerl_object_property_init(SV* initee) { dSP; XPUSHs(initee); PUTBACK; call_pv("Dumper", G_SCALAR); }  // NEED ANSWER: what in the hades does this property init function even do?  why do we need it???

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

#endif

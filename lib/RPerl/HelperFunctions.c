#include "/tmp/RPerl-latest/lib/RPerl/HelperFunctions.h"		// -> TERM
//	#include <RPerl/HelperFunctions.h>

#ifndef __CPP__INCLUDED__RPerl__HelperFunctions_c

// <<< HELPER FUNCTION DEFINITIONS >>
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

#endif
#define __CPP__INCLUDED__RPerl__HelperFunctions_c 1


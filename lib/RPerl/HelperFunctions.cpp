// <<< DEBUG DEFINES >>>
#define RPerl__DEBUG 0  // NEED FIX: access actual inherited debug flag somehow?
#define RPerl__DEBUG2 0
#define RPerl__DEBUG3 0  // NEED FIX: these debug statements cause memory leaks by increasing the refcounts of data_i, data_i_plus_1, and swap

// <<< HELPER DEFINES >>>
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

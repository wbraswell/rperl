#ifndef __CPP__INCLUDED__RPerl__HelperFunctions_h
#define __CPP__INCLUDED__RPerl__HelperFunctions_h 0.002_040

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// START HERE: implement RPerl__diag, use in files called by 07_oo_inherit.t
// START HERE: implement RPerl__diag, use in files called by 07_oo_inherit.t
// START HERE: implement RPerl__diag, use in files called by 07_oo_inherit.t

/*
#include <stdlib.h>  // for getenv()
#include <stdio.h>  // for ostream object type

ostringstream RPerl__diag;

ostream& operator<<(ostream& ostream_object, const char* char_star_input)
{
        if (getenv("RPERL_DEBUG") { cerr << char_star_input; }
        return ostream_object;
}

ostream& operator<<(ostream& ostream_object, std::string string_input)
{
        if (getenv("RPERL_DEBUG") { cerr << string_input; }
        return ostream_object;
}
*/

// [[[ DEBUG DEFINES ]]]
#define RPERL_DEBUG 1  // NEED FIX: access actual environmental variable RPERL_DEBUG!
#define RPERL_DEBUG2 1
#define RPERL_DEBUG3 1  // NEED FIX: these debug statements cause memory leaks by increasing the refcounts of data_i, data_i_plus_1, and swap

// [[[ HELPER MACROS ]]]
#define SvAROKp(input_av_ref) (SvROK(input_av_ref) && (SvTYPE(SvRV(input_av_ref)) == SVt_PVAV))  // DEV NOTE: look P5P, I invented macros that should probably be in the P5 core!
#define SvHROKp(input_hv_ref) (SvROK(input_hv_ref) && (SvTYPE(SvRV(input_hv_ref)) == SVt_PVHV))
#define AV_ELEMENT(av,index) ((av_fetch(av,index,0)!=NULL)?*av_fetch(av,index,0):newSV(0))
#define SV_REFERENCE_COUNT(sv) (SvREFCNT(sv))

// [[[ HELPER FUNCTION DECLARATIONS ]]]
int RPerl_SvIOKp(SV* input_sv);
int RPerl_SvNOKp(SV* input_sv);
int RPerl_SvPOKp(SV* input_sv);
int RPerl_SvAROKp(SV* input_av_ref);
int RPerl_SvHROKp(SV* input_hv_ref);

void RPerl_object_property_init(SV* initee); // NEED ANSWER: what in the hades does this property init function even do?  why do we need it???
char* RPerl_DUMPER__perl_from_c(SV* dumpee);

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# ifdef __PERL__TYPES
SV* RPerl__HelperFunctions__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
int RPerl__HelperFunctions__MODE_ID() { int retval = 2;  return(retval); }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

#endif

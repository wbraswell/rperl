#ifndef __CPP__INCLUDED__RPerl__HelperFunctions_cpp
#define __CPP__INCLUDED__RPerl__HelperFunctions_cpp 0.005_100

#include <RPerl/HelperFunctions.h>  // -> NULL

// <<< HELPER FUNCTION DEFINITIONS >>
int RPerl_SvBOKp(SV* input_sv) { return(SvBOKp(input_sv)); }
int RPerl_SvUIOKp(SV* input_sv) { return(SvUIOKp(input_sv)); }
int RPerl_SvIOKp(SV* input_sv) { return(SvIOKp(input_sv)); }
int RPerl_SvNOKp(SV* input_sv) { return(SvNOKp(input_sv)); }
int RPerl_SvCOKp(SV* input_sv) { return(SvCOKp(input_sv)); }
int RPerl_SvPOKp(SV* input_sv) { return(SvPOKp(input_sv)); }
int RPerl_SvAROKp(SV* input_avref) { return(SvAROKp(input_avref)); }
int RPerl_SvHROKp(SV* input_hvref) { return(SvHROKp(input_hvref)); }

SV * RPerl_AV_ELEMENT(pTHX_ AV * av, SSize_t index) {
	SV ** svp = av_fetch(av,index,0);
	if(svp != NULL)
		return *svp;
	else
		return sv_newmortal();
}

// NEED ANSWER: what in the hades does this property init function even do?  why do we need it???
// use this to avoid "panic: attempt to copy freed scalar..."
void RPerl_object_property_init(SV* initee)
{
	dSP;
	PUSHMARK(SP);
	XPUSHs(initee);
	PUTBACK;
	call_pv("Dumper", G_SCALAR);
//	printf("in HelperFunctions::RPerl_object_property_init(), have initee->flags =\n0x%x\n", initee->sv_flags);
}

#endif

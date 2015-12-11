#ifndef __CPP__INCLUDED__rperlgmp_h
#define __CPP__INCLUDED__rperlgmp_h 0.004_000

// NEED FIX: remove duplicate code
// DEV NOTE, CORRELATION #rp26: can't figure out how to get GMPInteger.cpp to include HelperFunctions.cpp without redefining errors
#define SvHROKp(input_hv_ref) (SvROK(input_hv_ref) && (SvTYPE(SvRV(input_hv_ref)) == SVt_PVHV))

#include <RPerl/DataType/GMPInteger.cpp>  // -> GMPInteger.h
#include <RPerl/Operation/Expression/Operator/GMPFunctions.cpp>  // -> GMPFunctions.h

#endif

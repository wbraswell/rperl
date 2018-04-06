////use strict;  use warnings;
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes_h
#define __CPP__INCLUDED__RPerl__DataStructure__Hash__SubTypes_h 0.003_000

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ DATA TYPES ]]]
#include <RPerl/DataType/Integer.cpp>  // for integer type used in OPS & TYPES REPORTER

// [[[ TYPE-CHECKING MACROS ]]]
#define hashref_CHECK(possible_hashref) \
    (not(SvOK(possible_hashref)) ? \
            croak("\nERROR EHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashref value expected but undefined/null value found,\ncroaking") : \
            (not(SvHROKp(possible_hashref)) ? \
                    croak("\nERROR EHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashref value expected but non-hashref value found,\ncroaking") : \
                    (void)0))
#define hashref_CHECKTRACE(possible_hashref, variable_name, subroutine_name) \
    (not(SvOK(possible_hashref)) ? \
            croak("\nERROR EHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
            (not(SvHROKp(possible_hashref)) ? \
                    croak("\nERROR EHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashref value expected but non-hashref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
                    (void)0))
#define hashentry_CHECK(possible_hashentry) \
    ((possible_hashentry == NULL) ? \
            croak("\nERROR EHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashentry value expected but undefined/null value found,\ncroaking") : \
                    (void)0)
#define hashentry_CHECKTRACE(possible_hashentry, variable_name, subroutine_name) \
    ((possible_hashentry == NULL) ? \
            croak("\nERROR EHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhashentry value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
                    (void)0)

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__Hash__SubTypes__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataStructure__Hash__SubTypes__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

#endif

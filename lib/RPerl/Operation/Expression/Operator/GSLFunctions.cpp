#ifndef __CPP__INCLUDED__RPerl_Operation_Expression_Operator_GSLFunctions_cpp
#define __CPP__INCLUDED__RPerl_Operation_Expression_Operator_GSLFunctions_cpp 0.001_000

#include <RPerl/Operation/Expression/Operator/GSLFunctions.h>  // -> NULL


// [[[ ROWS & COLS ]]]
# ifdef __PERL__TYPES

SV* gsl_matrix_rows(SV* input_gsl_matrix) {
    // NEED ADD CODE EVENTUALLY
}

SV* gsl_matrix_cols(SV* input_gsl_matrix) {
    // NEED ADD CODE EVENTUALLY
}

# elif defined __CPP__TYPES

// use compile-time macros instead of run-time functions
/*
integer gsl_matrix_rows(gsl_matrix_rawptr input_gsl_matrix) {
    return input_gsl_matrix->size1;
}

integer gsl_matrix_cols(gsl_matrix_rawptr input_gsl_matrix) {
    return input_gsl_matrix->size2;
}
*/

# endif

#endif

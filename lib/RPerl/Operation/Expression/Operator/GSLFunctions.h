#ifndef __CPP__INCLUDED__RPerl_Operation_Expression_Operator_GSLFunctions_h
#define __CPP__INCLUDED__RPerl_Operation_Expression_Operator_GSLFunctions_h 0.002_000

// [[[ ROWS & COLS ]]]
# ifdef __PERL__TYPES
SV* gsl_matrix_rows(SV* input_gsl_matrix);
SV* gsl_matrix_cols(SV* input_gsl_matrix);
# elif defined __CPP__TYPES
// use compile-time macros instead of run-time functions
//integer gsl_matrix_rows(gsl_matrix_rawptr input_gsl_matrix);
//integer gsl_matrix_cols(gsl_matrix_rawptr input_gsl_matrix);
#define gsl_matrix_rows(input_gsl_matrix) input_gsl_matrix->size1
#define gsl_matrix_cols(input_gsl_matrix) input_gsl_matrix->size2
# endif

#endif

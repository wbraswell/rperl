using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__RPerl__DataType__GMPInteger_h
#define __CPP__INCLUDED__RPerl__DataType__GMPInteger_h 0.001_000

// [[[ TYPEDEFS ]]]
typedef mpz_t gmp_integer;

#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// DEV NOTE, CORRELATION #rp12: basic data types must be wholly independent of one another, to avoid weird redefining or undefining of subroutine errors [INCORRECT???]
#include <RPerl/DataType/String.cpp>  // string types used in *_to_string() subroutines

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataType__GMPInteger__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
integer RPerl__DataType__GMPInteger__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPE-CHECKING SUBROUTINES ]]]
void gmp_integer_CHECK(SV* possible_gmp_integer);
void gmp_integer_CHECKTRACE(SV* possible_gmp_integer, const char* variable_name, const char* subroutine_name);

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// DEV NOTE, CORRELATION #rp10: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES
gmp_integer XS_unpack_gmp_integer(SV* input_sv);
void XS_pack_gmp_integer(SV* output_sv, gmp_integer input_gmp_integer);
//# endif

// [[[ BOOLIFY ]]]
# ifdef __PERL__TYPES
SV* gmp_integer_to_bool(SV* input_gmp_integer);
# elif defined __CPP__TYPES
bool gmp_integer_to_bool(gmp_integer input_gmp_integer);
# endif

// [[[ UNSIGNED INTEGERIFY ]]]
# ifdef __PERL__TYPES
SV* gmp_integer_to_unsigned_integer(SV* input_gmp_integer);
# elif defined __CPP__TYPES
// DEV NOTE, CORRELATION #rp12: basic data types must be wholly independent of one another, to avoid weird redefining or undefining of subroutine errors [INCORRECT???]
//unsigned_integer gmp_integer_to_unsigned_integer(gmp_integer input_gmp_integer);
unsigned int gmp_integer_to_unsigned_integer(gmp_integer input_gmp_integer);
# endif

// [[[ INTEGERIFY ]]]
# ifdef __PERL__TYPES
SV* gmp_integer_to_integer(SV* input_gmp_integer);
# elif defined __CPP__TYPES
int gmp_integer_to_integer(gmp_integer input_gmp_integer);
# endif

// [[[ NUMBERIFY ]]]
# ifdef __PERL__TYPES
SV* gmp_integer_to_number(SV* input_gmp_integer);
# elif defined __CPP__TYPES
double gmp_integer_to_number(gmp_integer input_gmp_integer);
# endif

// [[[ CHARIFY ]]]
# ifdef __PERL__TYPES
SV* gmp_integer_to_char(SV* input_gmp_integer);
# elif defined __CPP__TYPES
char gmp_integer_to_char(gmp_integer input_gmp_integer);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* gmp_integer_to_string(SV* input_gmp_integer);
# elif defined __CPP__TYPES
string gmp_integer_to_string(gmp_integer input_gmp_integer);
# endif
string gmp_integer_to_string_CPPTYPES(gmp_integer input_gmp_integer);

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* gmp_integer__typetest0();
SV* gmp_integer__typetest1(SV* lucky_gmp_integer);
# elif defined __CPP__TYPES
gmp_integer gmp_integer__typetest0();
gmp_integer gmp_integer__typetest1(gmp_integer lucky_gmp_integer);
# endif

#endif

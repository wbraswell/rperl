using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__GSLMatrix_h
#define __CPP__INCLUDED__RPerl__DataStructure__GSLMatrix_h 0.001_000

// [[[ INCLUDES ]]]
//#include <gsl_matrix.h>      // -> ???  // SHOULD BE HANDLE BY INLINE AUTO-INCLUDES TO AVOID PARSING???

// NEED FIX: remove duplicate code
// DEV NOTE, CORRELATION #rp026: can't figure out how to get GMPInteger.cpp to include HelperFunctions.cpp without redefining errors
#define SvHROKp(input_hv_ref) (SvROK(input_hv_ref) && (SvTYPE(SvRV(input_hv_ref)) == SVt_PVHV))

# ifndef __CPP__INCLUDED__RPerl__DataStructure__GSLMatrix_h__typedefs
#define __CPP__INCLUDED__RPerl__DataStructure__GSLMatrix_h__typedefs 1

// [[[ TYPEDEFS ]]]
#define gsl_matrix_rawptr gsl_matrix*

// [[[ OO SUBCLASSES ]]]
/* UNUSED?
typedef std::unique_ptr<gsl_matrix> gsl_matrix_ptr;
typedef std::vector<gsl_matrix_ptr> gsl_matrix_arrayref;
typedef std::unordered_map<string, gsl_matrix_ptr> gsl_matrix_hashref;
typedef std::unordered_map<string, gsl_matrix_ptr>::iterator gsl_matrix_hashref_iterator;
*/

# endif

// [[[ PRE-DECLARED TYPEDEFS ]]]
# ifndef __CPP__INCLUDED__RPerl__DataType__Integer_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Integer_h__typedefs 1
// DEV NOTE, CORRELATION #rp001: keep track of all these hard-coded "semi-dynamic" integer data types
#  ifdef __TYPE__INTEGER__LONG
typedef long integer;
#define INTEGER "ld"  // assume format code 'ld' exists if type 'long' exists
#  elif defined __TYPE__INTEGER__LONG_LONG
typedef long long integer;
#define INTEGER "lld"  // assume format code 'lld' exists if type 'long long' exists
#  elif defined __TYPE__INTEGER____INT8
typedef __int8 integer;
#   if defined(_MSC_VER) && (_MSC_VER < 1800)  // MSVC older-than-2013
#define INTEGER "I8d"
#   else  // non-Windows, Windows w/ GCC, or MSVC 2013-or-newer
#include <inttypes.h>
#define INTEGER "PRId8"
#   endif
#  elif defined __TYPE__INTEGER____INT16
typedef __int16 integer;
#   if defined(_MSC_VER) && (_MSC_VER < 1800)  // MSVC older-than-2013
#define INTEGER "I16d"
#   else  // non-Windows, Windows w/ GCC, or MSVC 2013-or-newer
#include <inttypes.h>
#define INTEGER "PRId16"
#   endif
#  elif defined __TYPE__INTEGER____INT32
typedef __int32 integer;
#   if defined(_MSC_VER) && (_MSC_VER < 1800)  // MSVC older-than-2013
#define INTEGER "I32d"
#   else  // non-Windows, Windows w/ GCC, or MSVC 2013-or-newer
#include <inttypes.h>
#define INTEGER "PRId32"
#   endif
#  elif defined __TYPE__INTEGER____INT64
typedef __int64 integer;
#   if defined(_MSC_VER) && (_MSC_VER < 1800)  // MSVC older-than-2013
#define INTEGER "I64d"
#   else  // non-Windows, Windows w/ GCC, or MSVC 2013-or-newer
#include <inttypes.h>
#define INTEGER "PRId64"
#   endif
#  elif defined __TYPE__INTEGER____INT128
typedef __int128 integer;
#   if defined(_MSC_VER) && (_MSC_VER < 1800)  // MSVC older-than-2013
#define INTEGER "I128d"
#   else  // non-Windows, Windows w/ GCC, or MSVC 2013-or-newer
#include <inttypes.h>
#define INTEGER "PRId128"
#   endif
#  elif defined __TYPE__INTEGER__INT8_T
typedef int8_t integer;
#   if defined(_MSC_VER) && (_MSC_VER < 1800)  // MSVC older-than-2013
#define INTEGER "I8d"
#   else  // non-Windows, Windows w/ GCC, or MSVC 2013-or-newer
#include <inttypes.h>
#define INTEGER "PRId8"
#   endif
#  elif defined __TYPE__INTEGER__INT16_T
typedef int16_t integer;
#   if defined(_MSC_VER) && (_MSC_VER < 1800)  // MSVC older-than-2013
#define INTEGER "I16d"
#   else  // non-Windows, Windows w/ GCC, or MSVC 2013-or-newer
#include <inttypes.h>
#define INTEGER "PRId16"
#   endif
#  elif defined __TYPE__INTEGER__INT32_T
typedef int32_t integer;
#   if defined(_MSC_VER) && (_MSC_VER < 1800)  // MSVC older-than-2013
#define INTEGER "I32d"
#   else  // non-Windows, Windows w/ GCC, or MSVC 2013-or-newer
#include <inttypes.h>
#define INTEGER "PRId32"
#   endif
#  elif defined __TYPE__INTEGER__INT64_T
typedef int64_t integer;
#   if defined(_MSC_VER) && (_MSC_VER < 1800)  // MSVC older-than-2013
#define INTEGER "I64d"
#   else  // non-Windows, Windows w/ GCC, or MSVC 2013-or-newer
#include <inttypes.h>
#define INTEGER "PRId64"
#   endif
#  elif defined __TYPE__INTEGER__INT128_T
typedef int128_t integer;
#   if defined(_MSC_VER) && (_MSC_VER < 1800)  // MSVC older-than-2013
#define INTEGER "I128d"
#   else  // non-Windows, Windows w/ GCC, or MSVC 2013-or-newer
#include <inttypes.h>
#define INTEGER "PRId128"
#   endif
#  else
typedef long integer;  // default
#define INTEGER "ld"  // assume format code 'ld' exists if type 'long' exists
#  endif
# endif
# ifndef __CPP__INCLUDED__RPerl__DataType__String_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__String_h__typedefs 1
typedef std::string string;
typedef std::ostringstream ostringstream;
# endif

// [[[ INCLUDES ]]]
#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataStructure__GSLMatrix__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
int RPerl__DataStructure__GSLMatrix__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPE-CHECKING SUBROUTINES ]]]
void gsl_matrix_CHECK(SV* possible_gsl_matrix);
void gsl_matrix_CHECKTRACE(SV* possible_gsl_matrix, const char* variable_name, const char* subroutine_name);

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
gsl_matrix_rawptr XS_unpack_gsl_matrixPtr(SV* input_sv);
void XS_pack_gsl_matrixPtr(SV* output_sv, gsl_matrix_rawptr input_gsl_matrix);
# endif

// [[[ ARRAYIFY ]]]
# ifdef __PERL__TYPES
SV* gsl_matrix_to_number_arrayref(SV* input_gsl_matrix);
SV* gsl_matrix_to_number_arrayref_arrayref(SV* input_gsl_matrix);
# elif defined __CPP__TYPES
number_arrayref gsl_matrix_to_number_arrayref(gsl_matrix_rawptr input_gsl_matrix);
number_arrayref_arrayref gsl_matrix_to_number_arrayref_arrayref(gsl_matrix_rawptr input_gsl_matrix);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* gsl_matrix_to_string(SV* input_gsl_matrix);
# elif defined __CPP__TYPES
string gsl_matrix_to_string(gsl_matrix_rawptr input_gsl_matrix);
# endif
string gsl_matrix_to_string_CPPTYPES(gsl_matrix_rawptr input_gsl_matrix);

// [[[ GSL MATRIXIFY ]]]
# ifdef __PERL__TYPES
SV* number_arrayref_to_gsl_matrix(SV* input_number_arrayref, SV* rows, SV* cols);
# elif defined __CPP__TYPES
gsl_matrix_rawptr number_arrayref_to_gsl_matrix(number_arrayref input_number_arrayref, integer rows, integer cols);
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* gsl_matrix_typetest0();
SV* gsl_matrix_typetest1(SV* lucky_gsl_matrix);
# elif defined __CPP__TYPES
gsl_matrix_rawptr gsl_matrix_typetest0();
gsl_matrix_rawptr gsl_matrix_typetest1(gsl_matrix_rawptr lucky_gsl_matrix);
integer gsl_matrix_typetest99() { /* XS_pack_gsl_matrixPtr(newSV(0), gsl_matrix_alloc(1, 1)); gsl_matrix_typetest0(); */ return 25; }
# endif

#endif

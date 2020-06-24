using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Integer_h
#define __CPP__INCLUDED__RPerl__DataType__Integer_h 0.011_000

// [[[ TYPEDEFS ]]]
// DEV NOTE: must use "integer" typedef because "int" is already defined by Inline's default typemap, even if we put our own integer entry into typemap.rperl;
// if we allow Inline default int, then it will accept all kinds of non-integer values which should be filtered by XS_unpack_integer() and CHECK()
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

// [[[ PRE-DECLARED TYPEDEFS ]]]
# ifndef __CPP__INCLUDED__RPerl__DataType__Boolean_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Boolean_h__typedefs 1
typedef bool boolean;
# endif
# ifndef __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_h__typedefs 1
typedef unsigned long int unsigned_integer;
# endif
# ifndef __CPP__INCLUDED__RPerl__DataType__Number_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Number_h__typedefs 1
#  ifdef __TYPE__NUMBER__DOUBLE
typedef double number;
#define NUMBER "f"
#  elif defined __TYPE__NUMBER__LONG__DOUBLE
typedef long double number;
#define NUMBER "Lf"  // assume format code 'Lf' exists if type 'long double' exists
#  else
typedef double number;  // default
#define NUMBER "f"
#  endif
# endif
# ifndef __CPP__INCLUDED__RPerl__DataType__Character_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Character_h__typedefs 1
typedef char character;
# endif
# ifndef __CPP__INCLUDED__RPerl__DataType__String_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__String_h__typedefs 1
typedef std::string string;
typedef std::ostringstream ostringstream;
# endif

// [[[ INCLUDES ]]]
#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// [[[ TYPE-CHECKING MACROS ]]]
#define integer_CHECK(possible_integer) \
	(not(SvOK(possible_integer)) ? \
			croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found,\ncroaking") : \
			(not(SvIOKp(possible_integer)) ? \
					croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found,\ncroaking") : \
					(void)0))
#define integer_CHECKTRACE(possible_integer, variable_name, subroutine_name) \
	(not(SvOK(possible_integer)) ? \
			croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvIOKp(possible_integer)) ? \
					croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ TYPE-CHECKING SUBROUTINES ]]]
// DEPRECATED, SEE MACROS ABOVE
//void integer_CHECK(SV* possible_integer);
//void integer_CHECKTRACE(SV* possible_integer, const char* variable_name, const char* subroutine_name);

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataType__Integer__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
int RPerl__DataType__Integer__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// DEV NOTE, CORRELATION #rp010: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES
integer XS_unpack_integer(SV* input_sv);
void XS_pack_integer(SV* output_sv, integer input_integer);
//# endif

// [[[ BOOLEANIFY ]]]
# ifdef __PERL__TYPES
SV* integer_to_boolean(SV* input_integer);
# elif defined __CPP__TYPES
boolean integer_to_boolean(integer input_integer);
# endif

// [[[ UNSIGNED INTEGERIFY ]]]
# ifdef __PERL__TYPES
SV* integer_to_unsigned_integer(SV* input_integer);
# elif defined __CPP__TYPES
unsigned_integer integer_to_unsigned_integer(integer input_integer);
# endif

// [[[ NUMBERIFY ]]]
# ifdef __PERL__TYPES
SV* integer_to_number(SV* input_integer);
# elif defined __CPP__TYPES
number integer_to_number(integer input_integer);
# endif

// [[[ CHARACTERIFY ]]]
# ifdef __PERL__TYPES
SV* integer_to_character(SV* input_integer);
# elif defined __CPP__TYPES
character integer_to_character(integer input_integer);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* integer_to_string(SV* input_integer);
# elif defined __CPP__TYPES
string         to_string(integer input_integer);
string integer_to_string(integer input_integer);
# endif
string integer_to_string_CPPTYPES(integer input_integer);

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* integer_typetest0();
SV* integer_typetest1(SV* lucky_integer);
# elif defined __CPP__TYPES
integer integer_typetest0();
integer integer_typetest1(integer lucky_integer);
# endif

#endif

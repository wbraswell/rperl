using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_h
#define __CPP__INCLUDED__RPerl__DataType__Number_h 0.007_100

// [[[ TYPEDEFS ]]]
# ifndef __CPP__INCLUDED__RPerl__DataType__Number_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Number_h__typedefs 1
#  ifdef __TYPE__NUMBER__DOUBLE
typedef double number;
#  elif defined __TYPE__NUMBER__LONG__DOUBLE
typedef long double number;
#  else
typedef double number;  // default
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
# ifndef __CPP__INCLUDED__RPerl__DataType__Integer_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Integer_h__typedefs 1
// DEV NOTE, CORRELATION #rp01: keep track of all these hard-coded integer data types
#  ifdef __TYPE__INTEGER__LONG
typedef long integer;
#  elif defined __TYPE__INTEGER__LONG_LONG
typedef long long integer;
#  elif defined __TYPE__INTEGER____INT8
typedef __int8 integer;
#  elif defined __TYPE__INTEGER____INT16
typedef __int16 integer;
#  elif defined __TYPE__INTEGER____INT32
typedef __int32 integer;
#  elif defined __TYPE__INTEGER____INT64
typedef __int64 integer;
#  elif defined __TYPE__INTEGER____INT128
typedef __int128 integer;
#  elif defined __TYPE__INTEGER__INT8_T
typedef int8_t integer;
#  elif defined __TYPE__INTEGER__INT16_T
typedef int16_t integer;
#  elif defined __TYPE__INTEGER__INT32_T
typedef int32_t integer;
#  elif defined __TYPE__INTEGER__INT64_T
typedef int64_t integer;
#  elif defined __TYPE__INTEGER__INT128_T
typedef int128_t integer;
#  else
typedef long integer;  // default
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
#define number_CHECK(possible_number) \
	(not(SvOK(possible_number)) ? \
			croak("\nERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\ncroaking") : \
			(not(SvNOKp(possible_number) || SvIOKp(possible_number)) ? \
					croak("\nERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\ncroaking") : \
					(void)0))
#define number_CHECKTRACE(possible_number, variable_name, subroutine_name) \
	(not(SvOK(possible_number)) ? \
			croak("\nERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvNOKp(possible_number) || SvIOKp(possible_number)) ? \
					croak("\nERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ TYPE-CHECKING ]]]
// DEPRECATED, SEE MACROS ABOVE
//void number_CHECK(SV* possible_number);
//void number_CHECKTRACE(SV* possible_number, const char* variable_name, const char* subroutine_name);

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataType__Number__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
int RPerl__DataType__Number__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// DEV NOTE, CORRELATION #rp10: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES
number XS_unpack_number(SV* input_sv);
void XS_pack_number(SV* output_sv, number input_number);
//# endif

// [[[ BOOLEANIFY ]]]
# ifdef __PERL__TYPES
SV* number_to_boolean(SV* input_number);
# elif defined __CPP__TYPES
boolean number_to_boolean(number input_number);
# endif

// [[[ UNSIGNED INTEGERIFY ]]]
# ifdef __PERL__TYPES
SV* number_to_unsigned_integer(SV* input_number);
# elif defined __CPP__TYPES
unsigned_integer number_to_unsigned_integer(number input_number);
# endif

// [[[ INTEGERIFY ]]]
# ifdef __PERL__TYPES
SV* number_to_integer(SV* input_number);
# elif defined __CPP__TYPES
integer number_to_integer(number input_number);
# endif

// [[[ CHARACTERIFY ]]]
# ifdef __PERL__TYPES
SV* number_to_character(SV* input_number);
# elif defined __CPP__TYPES
character number_to_character(number input_number);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* number_to_string(SV* input_number);
# elif defined __CPP__TYPES
string number_to_string(number input_number);
# endif
//string number_to_string_CPPTYPES(number input_number);
string number_to_string_CPPTYPES(number input_number);

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* number__typetest0();
SV* number__typetest1(SV* lucky_number);
# elif defined __CPP__TYPES
number number__typetest0();
number number__typetest1(number lucky_number);
# endif

#endif

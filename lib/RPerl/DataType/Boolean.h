using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Boolean_h
#define __CPP__INCLUDED__RPerl__DataType__Boolean_h 0.001_000

// [[[ TYPEDEFS ]]]
// DEV NOTE: must use "boolean" typedef because "bool" is already defined by Inline's default typemap, even if we put our own boolean entry into typemap.rperl;
// if we allow Inline default "bool" typemap, then it will return undef/NULL instead of 0 (and possibly other errors)
# ifndef __CPP__INCLUDED__RPerl__DataType__Boolean_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Boolean_h__typedefs 1
typedef bool boolean;
# endif

// [[[ PRE-DECLARED TYPEDEFS ]]]
# ifndef __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_h__typedefs 1
typedef unsigned long int unsigned_integer;
# endif
# ifndef __CPP__INCLUDED__RPerl__DataType__Integer_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Integer_h__typedefs 1
typedef long int integer;
# endif
# ifndef __CPP__INCLUDED__RPerl__DataType__Number_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Number_h__typedefs 1
typedef double number;
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
#define boolean_CHECK(possible_boolean) \
	(not(SvOK(possible_boolean)) ? \
			croak("\nERROR EBV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nboolean value expected but undefined/null value found,\ncroaking") : \
			(not(SvBOKp(possible_boolean)) ? \
					croak("\nERROR EBV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nboolean value expected but non-boolean value found,\ncroaking") : \
					(void)0))
#define boolean_CHECKTRACE(possible_boolean, variable_name, subroutine_name) \
	(not(SvOK(possible_boolean)) ? \
			croak("\nERROR EBV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nboolean value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvBOKp(possible_boolean)) ? \
					croak("\nERROR EBV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nboolean value expected but non-boolean value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataType__Boolean__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
int RPerl__DataType__Boolean__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// DEV NOTE, CORRELATION #rp10: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES
boolean XS_unpack_boolean(SV* input_sv);
void XS_pack_boolean(SV* output_sv, boolean input_boolean);
//# endif

// [[[ UNSIGNED INTEGERIFY ]]]
# ifdef __PERL__TYPES
SV* boolean_to_unsigned_integer(SV* input_boolean);
# elif defined __CPP__TYPES
unsigned_integer boolean_to_unsigned_integer(boolean input_boolean);
# endif

// [[[ INTEGERIFY ]]]
# ifdef __PERL__TYPES
SV* boolean_to_integer(SV* input_boolean);
# elif defined __CPP__TYPES
integer boolean_to_integer(boolean input_boolean);
# endif

// [[[ NUMBERIFY ]]]
# ifdef __PERL__TYPES
SV* boolean_to_number(SV* input_boolean);
# elif defined __CPP__TYPES
number boolean_to_number(boolean input_boolean);
# endif

// [[[ CHARACTERIFY ]]]
# ifdef __PERL__TYPES
SV* boolean_to_character(SV* input_boolean);
# elif defined __CPP__TYPES
character boolean_to_character(boolean input_boolean);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* boolean_to_string(SV* input_boolean);
# elif defined __CPP__TYPES
string boolean_to_string(boolean input_boolean);
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* boolean__typetest0();
SV* boolean__typetest1(SV* lucky_boolean);
# elif defined __CPP__TYPES
boolean boolean__typetest0();
boolean boolean__typetest1(boolean lucky_boolean);
# endif

#endif

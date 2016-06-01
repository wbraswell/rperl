using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Character_h
#define __CPP__INCLUDED__RPerl__DataType__Character_h 0.001_000

// [[[ TYPEDEFS ]]]
// DEV NOTE: must use "character" typedef because "bool" is already defined by Inline's default typemap, even if we put our own character entry into typemap.rperl;
// if we allow Inline default "bool" typemap, then it will return undef/NULL instead of 0 (and possibly other errors)
# ifndef __CPP__INCLUDED__RPerl__DataType__Character_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Character_h__typedefs 1
typedef char character;
# endif

// [[[ PRE-DECLARED TYPEDEFS ]]]
# ifndef __CPP__INCLUDED__RPerl__DataType__Boolean_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Boolean_h__typedefs 1
typedef bool character;
# endif
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
# ifndef __CPP__INCLUDED__RPerl__DataType__String_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__String_h__typedefs 1
typedef std::string string;
typedef std::ostringstream ostringstream;
# endif

// [[[ INCLUDES ]]]
#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// [[[ TYPE-CHECKING MACROS ]]]
#define character_CHECK(possible_character) \
	(not(SvOK(possible_character)) ? \
			croak("\nERROR ETV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ncharacter value expected but undefined/null value found,\ncroaking") : \
			(not(SvCOKp(possible_character)) ? \
					croak("\nERROR ETV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ncharacter value expected but non-character value found,\ncroaking") : \
					(void)0))
#define character_CHECKTRACE(possible_character, variable_name, subroutine_name) \
	(not(SvOK(possible_character)) ? \
			croak("\nERROR ETV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ncharacter value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvCOKp(possible_character)) ? \
					croak("\nERROR ETV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ncharacter value expected but non-character value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataType__Character__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
int RPerl__DataType__Character__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// DEV NOTE, CORRELATION #rp10: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES
character XS_unpack_character(SV* input_sv);
void XS_pack_character(SV* output_sv, character input_character);
//# endif

// [[[ BOOLEANIFY ]]]
# ifdef __PERL__TYPES
SV* character_to_boolean(SV* input_character);
# elif defined __CPP__TYPES
boolean character_to_boolean(character input_character);
# endif

// [[[ UNSIGNED INTEGERIFY ]]]
# ifdef __PERL__TYPES
SV* character_to_unsigned_integer(SV* input_character);
# elif defined __CPP__TYPES
unsigned_integer character_to_unsigned_integer(character input_character);
# endif

// [[[ INTEGERIFY ]]]
# ifdef __PERL__TYPES
SV* character_to_integer(SV* input_character);
# elif defined __CPP__TYPES
integer character_to_integer(character input_character);
# endif

// [[[ NUMBERIFY ]]]
# ifdef __PERL__TYPES
SV* character_to_number(SV* input_character);
# elif defined __CPP__TYPES
number character_to_number(character input_character);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* character_to_string(SV* input_character);
# elif defined __CPP__TYPES
string character_to_string(character input_character);
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* character__typetest0();
SV* character__typetest1(SV* lucky_character);
# elif defined __CPP__TYPES
character character__typetest0();
character character__typetest1(character lucky_character);
# endif

#endif

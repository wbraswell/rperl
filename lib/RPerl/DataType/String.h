using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__String_h
#define __CPP__INCLUDED__RPerl__DataType__String_h 0.007_000

// [[[ TYPEDEFS ]]]
# ifndef __CPP__INCLUDED__RPerl__DataType__String_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__String_h__typedefs 1
typedef std::string string;
typedef std::ostringstream ostringstream;
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

// [[[ INCLUDES ]]]
#include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// [[[ TYPE-CHECKING MACROS ]]]
#define string_CHECK(possible_string) \
	(not(SvOK(possible_string)) ? \
			croak("\nERROR EPV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found,\ncroaking") : \
			(not(SvPOKp(possible_string)) ? \
					croak("\nERROR EPV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found,\ncroaking") : \
					(void)0))
#define string_CHECKTRACE(possible_string, variable_name, subroutine_name) \
	(not(SvOK(possible_string)) ? \
			croak("\nERROR EPV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvPOKp(possible_string)) ? \
					croak("\nERROR EPV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ TYPE CHECKING ]]]
// DEPRECATED, SEE MACROS ABOVE
//void string_CHECK(SV* possible_string);
//void string_CHECKTRACE(SV* possible_string, const char* variable_name, const char* subroutine_name);

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataType__String__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
int RPerl__DataType__String__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// DEV NOTE, CORRELATION #rp10: the pack/unpack subs (below) are called by number_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES
string XS_unpack_string(SV* input_sv);
void XS_pack_string(SV* output_sv, string input_string);
//# endif

// [[[ SEARCH & REPLACE ]]]
# ifdef __PERL__TYPES
void string_substitute_global(SV* input_string, const string& find_string, const string& replace_string);
# elif defined __CPP__TYPES
void string_substitute_global(string& input_string, const string& find_string, const string& replace_string);
# endif

// [[[ BOOLEANIFY ]]]
# ifdef __PERL__TYPES
SV* string_to_boolean(SV* input_string);
# elif defined __CPP__TYPES
boolean string_to_boolean(string input_string);
# endif

// [[[ UNSIGNED INTEGERIFY ]]]
# ifdef __PERL__TYPES
SV* string_to_unsigned_integer(SV* input_string);
# elif defined __CPP__TYPES
unsigned_integer string_to_unsigned_integer(string input_string);
# endif

// [[[ INTEGERIFY ]]]
# ifdef __PERL__TYPES
SV* string_to_integer(SV* input_string);
# elif defined __CPP__TYPES
integer string_to_integer(string input_string);
# endif

// [[[ NUMBERIFY ]]]
# ifdef __PERL__TYPES
SV* string_to_number(SV* input_string);
# elif defined __CPP__TYPES
number string_to_number(string input_string);
# endif

// [[[ CHARACTERIFY ]]]
# ifdef __PERL__TYPES
SV* string_to_character(SV* input_string);
# elif defined __CPP__TYPES
character string_to_character(string input_string);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* string_to_string(SV* input_sv);
# elif defined __CPP__TYPES
string string_to_string(string input_string);
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* string__typetest0();
SV* string__typetest1(SV* lucky_string);
# elif defined __CPP__TYPES
string string__typetest0();
string string__typetest1(string lucky_string);
# endif

#endif

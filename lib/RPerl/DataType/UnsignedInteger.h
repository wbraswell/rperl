using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_h
#define __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_h 0.002_000

// [[[ TYPEDEFS ]]]
# ifndef __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_h__typedefs 1
typedef unsigned int unsigned_integer;
# endif

// [[[ PRE-DECLARED TYPEDEFS ]]]
# ifndef __CPP__INCLUDED__RPerl__DataType__Boolean_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Boolean_h__typedefs 1
typedef bool boolean;
# endif
# ifndef __CPP__INCLUDED__RPerl__DataType__Integer_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Integer_h__typedefs 1
typedef int integer;
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
#define unsigned_integer_CHECK(possible_unsigned_integer) \
	(not(SvOK(possible_unsigned_integer)) ? \
			croak("\nERROR EUIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nunsigned_integer value expected but undefined/null value found,\ncroaking") : \
			(not(SvUIOKp(possible_unsigned_integer)) ? \
					croak("\nERROR EUIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nunsigned_integer value expected but non-unsigned_integer value found,\ncroaking") : \
					(void)0))
#define unsigned_integer_CHECKTRACE(possible_unsigned_integer, variable_name, subroutine_name) \
	(not(SvOK(possible_unsigned_integer)) ? \
			croak("\nERROR EUIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nunsigned_integer value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvUIOKp(possible_unsigned_integer)) ? \
					croak("\nERROR EUIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nunsigned_integer value expected but non-unsigned_integer value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ OPERATIONS & DATA TYPES REPORTER ]]]
# ifdef __PERL__TYPES
SV* RPerl__DataType__UnsignedInteger__MODE_ID() { return(newSViv(1)); }  // CPPOPS_PERLTYPES is 1
# elif defined __CPP__TYPES
int RPerl__DataType__UnsignedInteger__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
// DEV NOTE, CORRELATION #rp10: the pack/unpack subs (below) are called by *_to_string_CPPTYPES(), moved outside #ifdef blocks
//# ifdef __CPP__TYPES
unsigned_integer XS_unpack_unsigned_integer(SV* input_sv);
void XS_pack_unsigned_integer(SV* output_sv, unsigned_integer input_unsigned_integer);
//# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* unsigned_integer_to_string(SV* input_unsigned_integer);
# elif defined __CPP__TYPES
string unsigned_integer_to_string(unsigned_integer input_unsigned_integer);
# endif
string unsigned_integer_to_string_CPPTYPES(unsigned_integer input_unsigned_integer);

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* unsigned_integer__typetest0();
SV* unsigned_integer__typetest1(SV* lucky_unsigned_integer);
# elif defined __CPP__TYPES
unsigned_integer unsigned_integer__typetest0();
unsigned_integer unsigned_integer__typetest1(unsigned_integer lucky_unsigned_integer);
# endif

#endif

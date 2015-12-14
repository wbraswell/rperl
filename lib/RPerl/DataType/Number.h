using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_h
#define __CPP__INCLUDED__RPerl__DataType__Number_h 0.005_000

// [[[ TYPEDEFS ]]]
# ifndef __CPP__INCLUDED__RPerl__DataType__Number_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Number_h__typedefs 1
typedef double number;
# endif

// [[[ PRE-DECLARED TYPEDEFS ]]]
// DEV NOTE, CORRELATION #rp12: basic data types must be wholly independent of one another, to avoid possible weird redefining or undefining of subroutine errors
# ifndef __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__UnsignedInteger_h__typedefs 1
typedef unsigned int unsigned_integer;
# endif
# ifndef __CPP__INCLUDED__RPerl__DataType__Integer_h__typedefs
#define __CPP__INCLUDED__RPerl__DataType__Integer_h__typedefs 1
typedef int integer;
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

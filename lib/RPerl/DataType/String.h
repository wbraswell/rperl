////use strict;  use warnings;
using std::cout;  using std::endl;

// VERSION 0.2.3

#ifndef __CPP__INCLUDED__RPerl__DataType__String_h
#define __CPP__INCLUDED__RPerl__DataType__String_h 1

#include <types_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// [[[ TYPE-CHECKING MACROS ]]]
#define CHECK_STRING(possible_string) \
	(not(SvOK(possible_string)) ? \
			croak("\nERROR EPV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found,\ncroaking") : \
			(not(SvPOKp(possible_string)) ? \
					croak("\nERROR EPV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found,\ncroaking") : \
					(void)0))
#define CHECK_TRACE_STRING(possible_string, variable_name, subroutine_name) \
	(not(SvOK(possible_string)) ? \
			croak("\nERROR EPV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name) : \
			(not(SvPOKp(possible_string)) ? \
					croak("\nERROR EPV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found,\nin variable '%s' from subroutine '%s',\ncroaking", variable_name, subroutine_name) : \
					(void)0))

// [[[ TYPEDEFS ]]]
typedef std::string string;
typedef std::ostringstream ostringstream;

// [[[ TYPE CHECKING ]]]
// DEPRECATED, SEE MACROS ABOVE
//void check_string(SV* possible_string);
//void check_trace_string(SV* possible_string, const char* variable_name, const char* subroutine_name);

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
string XS_unpack_string(SV* input_sv);
void XS_pack_string(SV* output_sv, string input_string);
# endif

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# ifdef __PERL__TYPES
# define OPS_TYPES_ID 1 // CPPOPS_PERLTYPES is 1
SV* ops_string() { return(newSVpv("CPP", 3)); }
SV* types_string() { return(newSVpv("PERL", 4)); }
# elif defined __CPP__TYPES
# define OPS_TYPES_ID 2 // CPPOPS_CPPTYPES is 2
string ops_string() { string retval = "CPP";  return(retval); }
string types_string() { string retval = "CPP";  return(retval); }
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* typetest___void__in___string__out();
SV* typetest___string__in___string__out(SV* lucky_string);
# elif defined __CPP__TYPES
string typetest___void__in___string__out();
string typetest___string__in___string__out(string lucky_string);
# endif

#endif

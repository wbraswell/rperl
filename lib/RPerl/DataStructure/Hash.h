////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash_h
#define __CPP__INCLUDED__RPerl__DataStructure__Hash_h 0.003000

#include <types_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for type-checking subroutines & macros
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

//// [[[ DATA TYPES ]]]
////use RPerl::DataType::Integer;
#include <RPerl/DataType/Integer.cpp>
////use RPerl::DataType::Number;
#include <RPerl/DataType/Number.cpp>
////use RPerl::DataType::String;
#include <RPerl/DataType/String.cpp>
////use RPerl::DataType::Scalar;
////use RPerl::DataType::Unknown;

// [[[ TYPE-CHECKING MACROS ]]]
#define hash_ref__CHECK(possible_hash_ref) \
	(not(SvOK(possible_hash_ref)) ? \
			croak("\nERROR EHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_ref value expected but undefined/null value found,\ncroaking") : \
			(not(SvHROKp(possible_hash_ref)) ? \
					croak("\nERROR EHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_ref value expected but non-hash_ref value found,\ncroaking") : \
					(void)0))
#define hash_ref__CHECKTRACE(possible_hash_ref, variable_name, subroutine_name) \
	(not(SvOK(possible_hash_ref)) ? \
			croak("\nERROR EHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_ref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvHROKp(possible_hash_ref)) ? \
					croak("\nERROR EHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_ref value expected but non-hash_ref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))
#define hash_entry__CHECK(possible_hash_entry) \
	((possible_hash_entry == NULL) ? \
			croak("\nERROR EHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_entry value expected but undefined/null value found,\ncroaking") : \
					(void)0)
#define hash_entry__CHECKTRACE(possible_hash_entry, variable_name, subroutine_name) \
	((possible_hash_entry == NULL) ? \
			croak("\nERROR EHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_entry value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0)

// [[[ TYPEDEFS ]]]
typedef std::unordered_map<string, integer> integer__hash_ref;
typedef std::unordered_map<string, integer>::iterator integer__hash_ref__iterator;
typedef std::unordered_map<string, integer>::const_iterator integer__hash_ref__const_iterator;
typedef std::unordered_map<string, number> number__hash_ref;
typedef std::unordered_map<string, number>::iterator number__hash_ref__iterator;
typedef std::unordered_map<string, number>::const_iterator number__hash_ref__const_iterator;
typedef std::unordered_map<string, string> string__hash_ref;
typedef std::unordered_map<string, string>::iterator string__hash_ref__iterator;
typedef std::unordered_map<string, string>::const_iterator string__hash_ref__const_iterator;

// [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# ifdef __PERL__TYPES
SV* hash__ops() { return(newSVpv("CPP", 3)); }
SV* hash__types() { return(newSVpv("PERL", 4)); }
# elif defined __CPP__TYPES
string hash__ops() { string retval = "CPP";  return(retval); }
string hash__types() { string retval = "CPP";  return(retval); }
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ TYPEMAP PACK/UNPACK FOR __CPP__TYPES ]]]
# ifdef __CPP__TYPES
integer__hash_ref XS_unpack_integer__hash_ref(SV* input_hv_ref);
void XS_pack_integer__hash_ref(SV* output_hv_ref, integer__hash_ref input_unordered_map);
number__hash_ref XS_unpack_number__hash_ref(SV* input_hv_ref);
void XS_pack_number__hash_ref(SV* output_hv_ref, number__hash_ref input_unordered_map);
string__hash_ref XS_unpack_string__hash_ref(SV* input_hv_ref);
void XS_pack_string__hash_ref(SV* output_hv_ref, string__hash_ref input_unordered_map);
# endif

// [[[ STRINGIFY ]]]
# ifdef __PERL__TYPES
SV* integer__hash_ref__stringify(SV* input_hv_ref);
SV* number__hash_ref__stringify(SV* input_hv_ref);
SV* string__hash_ref__stringify(SV* input_hv_ref);
# elif defined __CPP__TYPES
string integer__hash_ref__stringify(integer__hash_ref input_unordered_map);
string number__hash_ref__stringify(number__hash_ref input_unordered_map);
string string__hash_ref__stringify(string__hash_ref input_unordered_map);
# endif

// [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* integer__hash_ref__typetest0(SV* lucky_integers);
SV* integer__hash_ref__typetest1(SV* my_size);
SV* number__hash_ref__typetest0(SV* lucky_numbers);
SV* number__hash_ref__typetest1(SV* my_size);
SV* string__hash_ref__typetest0(SV* people);
SV* string__hash_ref__typetest1(SV* my_size);
# elif defined __CPP__TYPES
string integer__hash_ref__typetest0(integer__hash_ref lucky_integers);
integer__hash_ref integer__hash_ref__typetest1(integer my_size);
string number__hash_ref__typetest0(number__hash_ref lucky_numbers);
number__hash_ref number__hash_ref__typetest1(integer my_size);
string string__hash_ref__typetest0(string__hash_ref people);
string__hash_ref string__hash_ref__typetest1(integer my_size);
# endif

#endif

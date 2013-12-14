////use strict;  use warnings;
using std::cout;  using std::endl;

// VERSION 0.2.1

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash_h
#define __CPP__INCLUDED__RPerl__DataStructure__Hash_h 1

#include <types_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// for SvHROKp() macro and RPerl_SvHROKp() subroutine
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

// [[[ TYPE-CHECKING MACROS ]]]
#define CHECK_HASH_REF(possible_hash_ref) \
	(not(SvOK(possible_hash_ref)) ? \
			croak("\nERROR EHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_ref value expected but undefined/null value found,\ncroaking") : \
			(not(SvHROKp(possible_hash_ref)) ? \
					croak("\nERROR EHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_ref value expected but non-hash_ref value found,\ncroaking") : \
					(void)0))
#define CHECKTRACE_HASH_REF(possible_hash_ref, variable_name, subroutine_name) \
	(not(SvOK(possible_hash_ref)) ? \
			croak("\nERROR EHVRV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_ref value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
			(not(SvHROKp(possible_hash_ref)) ? \
					croak("\nERROR EHVRV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_ref value expected but non-hash_ref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0))
#define CHECK_HASH_ENTRY(possible_hash_entry) \
	((possible_hash_entry == NULL) ? \
			croak("\nERROR EHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_entry value expected but undefined/null value found,\ncroaking") : \
					(void)0)
#define CHECKTRACE_HASH_ENTRY(possible_hash_entry, variable_name, subroutine_name) \
	((possible_hash_entry == NULL) ? \
			croak("\nERROR EHE00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nhash_entry value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name) : \
					(void)0)

////# [[[ DATA TYPES ]]]
////use RPerl::DataType::Integer;
#include <RPerl/DataType/Integer.cpp>
////use RPerl::DataType::Number;
#include <RPerl/DataType/Number.cpp>
////use RPerl::DataType::String;
#include <RPerl/DataType/String.cpp>
////use RPerl::DataType::Scalar;
////use RPerl::DataType::Unknown;

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
SV* ops_hash() { return(newSVpv("CPP", 3)); }
SV* types_hash() { return(newSVpv("PERL", 4)); }
# elif defined __CPP__TYPES
string ops_hash() { string retval = "CPP";  return(retval); }
string types_hash() { string retval = "CPP";  return(retval); }
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
SV* stringify_integer__hash_ref(SV* input_hv_ref);
SV* stringify_number__hash_ref(SV* input_hv_ref);
SV* stringify_string__hash_ref(SV* input_hv_ref);
# elif defined __CPP__TYPES
string stringify_integer__hash_ref(integer__hash_ref input_unordered_map);
string stringify_number__hash_ref(number__hash_ref input_unordered_map);
string stringify_string__hash_ref(string__hash_ref input_unordered_map);
# endif

//# [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
SV* typetest___integer__hash_ref__in___string__out(SV* lucky_integers);
SV* typetest___integer__in___integer__hash_ref__out(SV* my_size);
SV* typetest___number__hash_ref__in___string__out(SV* lucky_numbers);
SV* typetest___integer__in___number__hash_ref__out(SV* my_size);
SV* typetest___string__hash_ref__in___string__out(SV* people);
SV* typetest___integer__in___string__hash_ref__out(SV* my_size);
# elif defined __CPP__TYPES
string typetest___integer__hash_ref__in___string__out(integer__hash_ref lucky_integers);
integer__hash_ref typetest___integer__in___integer__hash_ref__out(integer my_size);
string typetest___number__hash_ref__in___string__out(number__hash_ref lucky_numbers);
number__hash_ref typetest___integer__in___number__hash_ref__out(integer my_size);
string typetest___string__hash_ref__in___string__out(string__hash_ref people);
string__hash_ref typetest___integer__in___string__hash_ref__out(integer my_size);
# endif

#endif

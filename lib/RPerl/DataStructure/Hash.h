////use strict;  use warnings;
using std::cout;  using std::endl;

// VERSION 0.1.3

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash_h
#define __CPP__INCLUDED__RPerl__DataStructure__Hash_h 1

////# [[[ DATA TYPES ]]]
////use RPerl::DataType::Number;
#include <RPerl/DataType/Number.cpp>
////use RPerl::DataType::String;
#include <RPerl/DataType/String.cpp>
////use RPerl::DataType::Scalar;
////use RPerl::DataType::Unknown;

// [[[ TYPEDEFS FOR RPERL-TYPES-IN-C ]]]
typedef std::unordered_map<string, int> int__hash_ref;
typedef std::unordered_map<string, int>::iterator int__hash_ref__iterator;
typedef std::unordered_map<string, int>::const_iterator int__hash_ref__const_iterator;
typedef std::unordered_map<string, number> number__hash_ref;
typedef std::unordered_map<string, number>::iterator number__hash_ref__iterator;
typedef std::unordered_map<string, number>::const_iterator number__hash_ref__const_iterator;
typedef std::unordered_map<string, string> string__hash_ref;
typedef std::unordered_map<string, string>::iterator string__hash_ref__iterator;
typedef std::unordered_map<string, string>::const_iterator string__hash_ref__const_iterator;

#include <types.h> // for definitions of __PERL__TYPES or __CPP__TYPES

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

// [[[ TYPEMAP PACK/UNPACK DECLARATIONS ]]]
int__hash_ref XS_unpack_int__hash_ref(SV* input_hv_ref);
void XS_pack_int__hash_ref(SV* output_hv_ref, int__hash_ref input_unordered_map);
number__hash_ref XS_unpack_number__hash_ref(SV* input_hv_ref);
void XS_pack_number__hash_ref(SV* output_hv_ref, number__hash_ref input_unordered_map);
string__hash_ref XS_unpack_string__hash_ref(SV* input_hv_ref);
void XS_pack_string__hash_ref(SV* output_hv_ref, string__hash_ref input_unordered_map);

// [[[ STRINGIFY DECLARATIONS ]]]
# ifdef __PERL__TYPES
SV* stringify_int__hash_ref(SV* input_hv_ref);
SV* stringify_number__hash_ref(SV* input_hv_ref);
SV* stringify_string__hash_ref(SV* input_hv_ref);
# elif defined __CPP__TYPES
string stringify_int__hash_ref(int__hash_ref input_unordered_map);
string stringify_number__hash_ref(number__hash_ref input_unordered_map);
string stringify_string__hash_ref(string__hash_ref input_unordered_map);
# endif

//# [[[ TYPE TESTING DECLARATIONS ]]]
# ifdef __PERL__TYPES
SV* typetest___int__hash_ref__in___string__out(SV* lucky_numbers);
SV* typetest___int__in___int__hash_ref__out(int my_size);
SV* typetest___number__hash_ref__in___string__out(SV* lucky_numbers);
SV* typetest___int__in___number__hash_ref__out(int my_size);
SV* typetest___string__hash_ref__in___string__out(SV* people);
SV* typetest___int__in___string__hash_ref__out(int my_size);
# elif defined __CPP__TYPES
string typetest___int__hash_ref__in___string__out(int__hash_ref lucky_numbers);
int__hash_ref typetest___int__in___int__hash_ref__out(int my_size);
string typetest___number__hash_ref__in___string__out(number__hash_ref lucky_numbers);
number__hash_ref typetest___int__in___number__hash_ref__out(int my_size);
string typetest___string__hash_ref__in___string__out(string__hash_ref people);
string__hash_ref typetest___int__in___string__hash_ref__out(int my_size);
# endif

#endif

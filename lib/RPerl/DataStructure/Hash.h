#ifndef __CPP__INCLUDED__RPerl__DataStructure__Hash_h

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

// [[[ TYPEMAP PACK/UNPACK SUBROUTINE PROTOTYPE DECLARATIONS FOR RPERL-TYPES-IN-C ]]]
int__hash_ref XS_unpack_int__hash_ref(SV *input_hv_ref);
void XS_pack_int__hash_ref(SV *output_hv_ref, int__hash_ref input_unordered_map);
number__hash_ref XS_unpack_number__hash_ref(SV *input_hv_ref);
void XS_pack_number__hash_ref(SV *output_hv_ref, number__hash_ref input_unordered_map);
string__hash_ref XS_unpack_string__hash_ref(SV *input_hv_ref);
void XS_pack_string__hash_ref(SV *output_hv_ref, string__hash_ref input_unordered_map);

//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
void typetest___int__hash_ref__in___void__out(int__hash_ref lucky_numbers);
int__hash_ref typetest___int__in___int__hash_ref__out(int my_size);
void typetest___number__hash_ref__in___void__out(number__hash_ref lucky_numbers);
number__hash_ref typetest___int__in___number__hash_ref__out(int my_size);
void typetest___string__hash_ref__in___void__out(string__hash_ref people);
string__hash_ref typetest___int__in___string__hash_ref__out(int my_size);

#endif
#define __CPP__INCLUDED__RPerl__DataStructure__Hash_h 1

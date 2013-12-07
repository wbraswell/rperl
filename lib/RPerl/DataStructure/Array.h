////use strict;  use warnings;
using std::cout;  using std::endl;

// VERSION 0.3.0

#ifndef __CPP__INCLUDED__RPerl__DataStructure__Array_h
#define __CPP__INCLUDED__RPerl__DataStructure__Array_h 1

////# [[[ DATA TYPES ]]]
////use RPerl::DataType::Number;
#include <RPerl/DataType/Number.cpp>
////use RPerl::DataType::String;
#include <RPerl/DataType/String.cpp>
////use RPerl::DataType::Scalar;
////use RPerl::DataType::Unknown;

// [[[ TYPEDEFS FOR RPERL-TYPES-IN-C ]]]
typedef std::vector<int> int__array_ref;
typedef std::vector<int>::iterator int__array_ref__iterator;
typedef std::vector<int>::const_iterator int__array_ref__const_iterator;
typedef std::vector<number> number__array_ref;
typedef std::vector<number>::iterator number__array_ref__iterator;
typedef std::vector<number>::const_iterator number__array_ref__const_iterator;
typedef std::vector<string> string__array_ref;
typedef std::vector<string>::iterator string__array_ref__iterator;
typedef std::vector<string>::const_iterator string__array_ref__const_iterator;

#include <types.h> // for definitions of __PERL__TYPES or __CPP__TYPES

// [[[ MACROS ]]]
#define VECTOR_RESIZE_NOSHRINK(my_vector, my_size) ((my_vector.size() < my_size) ? my_vector.resize((size_t)(my_size)) : (void)0)  // do grow but don't shrink

// [[[ TYPEMAP PACK/UNPACK DECLARATIONS ]]]
int__array_ref XS_unpack_int__array_ref(SV *input_av_ref);
void XS_pack_int__array_ref(SV *output_av_ref, int__array_ref input_vector);
number__array_ref XS_unpack_number__array_ref(SV *input_av_ref);
void XS_pack_number__array_ref(SV *output_av_ref, number__array_ref input_vector);
string__array_ref XS_unpack_string__array_ref(SV *input_av_ref);
void XS_pack_string__array_ref(SV *output_av_ref, string__array_ref input_vector);

// [[[ STRINGIFY DECLARATIONS ]]]
# ifdef __PERL__TYPES
//void stringify_int__array_ref(SV *input_av_ref);
SV* stringify_int__array_ref(SV *input_av_ref);
SV* stringify_number__array_ref(SV *input_av_ref);
SV* stringify_string__array_ref(SV *input_av_ref);
# elif defined __CPP__TYPES
string stringify_int__array_ref(int__array_ref input_vector);
string stringify_number__array_ref(number__array_ref input_vector);
string stringify_string__array_ref(string__array_ref input_vector);
# else
Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_exactly_one!
# endif

// [[[ DATA TYPES & OPERATIONS ]]]
# ifdef __PERL__TYPES
SV* types_array() { return(newSVpv("PERL", 4)); }
SV* ops_array() { return(newSVpv("CPP", 3)); }
# elif defined __CPP__TYPES
string types_array() { string retval = "CPP";  return(retval); }
string ops_array() { string retval = "CPP";  return(retval); }
# endif

//# [[[ TYPE TESTING ]]]
# ifdef __PERL__TYPES
//void typetest___int__array_ref__in___string__out(SV* lucky_numbers);
SV* typetest___int__array_ref__in___string__out(SV* lucky_numbers);
//void typetest___int__in___int__array_ref__out(int my_size);
SV* typetest___int__in___int__array_ref__out(int my_size);
SV* typetest___number__array_ref__in___string__out(SV* lucky_numbers);
SV* typetest___int__in___number__array_ref__out(int my_size);
SV* typetest___string__array_ref__in___string__out(SV* people);
SV* typetest___int__in___string__array_ref__out(int my_size);
# elif defined __CPP__TYPES
string typetest___int__array_ref__in___string__out(int__array_ref lucky_numbers);
int__array_ref typetest___int__in___int__array_ref__out(int my_size);
string typetest___number__array_ref__in___string__out(number__array_ref lucky_numbers);
number__array_ref typetest___int__in___number__array_ref__out(int my_size);
string typetest___string__array_ref__in___string__out(string__array_ref people);
string__array_ref typetest___int__in___string__array_ref__out(int my_size);
# endif

#endif

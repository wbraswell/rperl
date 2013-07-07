////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_h
#define __CPP__INCLUDED__RPerl__DataType__Number_h 1

// [[[ TYPEDEFS FOR RPERL-TYPES-IN-C ]]]
typedef long double number;

#include <RPerl/DataType/String.cpp>  // for stringify()

// [[[ STRINGIFY ]]]
string stringify_number(number input_number);


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
number typetest___void__in___number__out();
number typetest___number__in___number__out(number lucky_number);

#endif

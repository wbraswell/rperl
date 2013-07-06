#ifndef __CPP__INCLUDED__RPerl__DataType__Number_h

// [[[ TYPEDEFS FOR RPERL-TYPES-IN-C ]]]
typedef long double number;

#include <RPerl/DataType/String.cpp>  // for stringify()

// [[[ STRINGIFY ]]]
string stringify(number input_number);


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
number typetest___void__in___number__out();
number typetest___number__in___number__out(number lucky_number);

#endif
#define __CPP__INCLUDED__RPerl__DataType__Number_h 1

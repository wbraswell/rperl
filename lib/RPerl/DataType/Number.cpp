////use strict;  use warnings;
using std::cout;  using std::endl;

#include <RPerl/DataType/Number.h>		// -> NULL (relies on native C type)

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_cpp


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
void typetest___number__in___void__out(number lucky_number) { printf("in C++ printf() Number::typetest___number__in___void__out(), have lucky_number %1.14Lf, BATBOZ\n", lucky_number); }
//void typetest___number__in___void__out(number lucky_number) { cout << "in C++ cout<< Number::typetest___number__in___void__out(), have lucky_number " << lucky_number << ", BATBOZ" << endl; }
number typetest___void__in___number__out() { number retval = 22.0 / 7.0;  printf("in C++ printf() Number::typetest___void__in___number__out(), have retval %1.14Lf, BATBOZ\n", retval);  return(retval); }


#endif
#define __CPP__INCLUDED__RPerl__DataType__Number_cpp 1

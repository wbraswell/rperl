////use strict;  use warnings;
using std::cout;  using std::endl;

#include <RPerl/DataType/Number.h>		// -> NULL (relies on native C type)

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_cpp

// [[[ STRINGIFY ]]]
string stringify(number input_number)
{
	ostringstream output_stream;
	output_stream.precision(std::numeric_limits<double>::digits10);
	output_stream << input_number;
	return(output_stream.str());
}


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
number typetest___number__in___number__out(number lucky_number) { printf("in C++ printf() Number::typetest___number__in___number__out(), have lucky_number %1.14Lf, BATBOZ\n", lucky_number);  return(lucky_number * 2); }
//number typetest___number__in___number__out(number lucky_number) { cout << "in C++ cout<< Number::typetest___number__in___number__out(), have lucky_number " << lucky_number << ", BATBOZ" << endl;  return(lucky_number * 2); }
number typetest___void__in___number__out() { number retval = 22.0 / 7.0;  printf("in C++ printf() Number::typetest___void__in___number__out(), have retval %1.14Lf, BATBOZ\n", retval);  return(retval); }

#endif
#define __CPP__INCLUDED__RPerl__DataType__Number_cpp 1

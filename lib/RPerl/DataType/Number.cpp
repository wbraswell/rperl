////use strict;  use warnings;
using std::cout;  using std::endl;

#ifndef __CPP__INCLUDED__RPerl__DataType__Number_cpp
#define __CPP__INCLUDED__RPerl__DataType__Number_cpp 1

#include <RPerl/DataType/Number.h>		// -> NULL (relies on native C type)

// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]
// [[[ STRINGIFY ]]]

# ifdef __PERL__TYPES

SV* stringify_number(SV* input_number)
{
	ostringstream output_stream;
	output_stream.precision(std::numeric_limits<double>::digits10);
	output_stream << SvNV(input_number);
	return(newSVpv((const char *)((output_stream.str()).c_str()), 0));

	// DEV NOTE: none of these printf()-type solutions count significant digits both before and after the decimal point,
	// so we fall back to utilizing C++ ostringstream which stringifies floating point numbers exactly the same as Perl (AFAICTSF)
//	return(newSVpvf("%16.32Lf", (long double)SvNV(input_number)));
//	return(newSVpvf("%"NVff"", SvNV(input_number)));
//	return(newSVpvf("%"NVff"", 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679));
}

# elif defined __CPP__TYPES

string stringify_number(number input_number)
{
	ostringstream output_stream;
	output_stream.precision(std::numeric_limits<double>::digits10);
	output_stream << input_number;
	return(output_stream.str());
}

# endif


//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]
//# [[[ TYPE TESTING ]]]

# ifdef __PERL__TYPES

SV* typetest___void__in___number__out() { SV* retval = newSVnv(22.0 / 7.0);  printf("in C++ __PERL__TYPES printf() Number::typetest___void__in___number__out(), have retval %1.14Lf, BATBOZ\n", (long double)SvNV(retval));  return(retval); }
SV* typetest___number__in___number__out(SV* lucky_number) { printf("in C++ __PERL__TYPES printf() Number::typetest___number__in___number__out(), have lucky_number %1.14Lf, BATBOZ\n", (long double)SvNV(lucky_number));  return(newSVnv(SvNV(lucky_number) * 2.0)); }

# elif defined __CPP__TYPES

number typetest___void__in___number__out() { number retval = 22.0 / 7.0;  printf("in C++ __CPP__TYPES printf() Number::typetest___void__in___number__out(), have retval %1.14Lf, BATBOZ\n", retval);  return(retval); }
number typetest___number__in___number__out(number lucky_number) { printf("in C++ __CPP__TYPES printf() Number::typetest___number__in___number__out(), have lucky_number %1.14Lf, BATBOZ\n", lucky_number);  return(lucky_number * 2.0); }
//number typetest___number__in___number__out(number lucky_number) { cout << "in C++ __CPP__TYPES cout<< Number::typetest___number__in___number__out(), have lucky_number " << lucky_number << ", BATBOZ" << endl;  return(lucky_number * 2.0); }

# endif

#endif

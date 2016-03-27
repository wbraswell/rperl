#ifndef __CPP__INCLUDED__rperltypes_h
#define __CPP__INCLUDED__rperltypes_h 0.002_000

#include <rperltypes_mode.h>
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h

#include <RPerl/DataType/Boolean.cpp>	// -> Boolean.h
#include <RPerl/DataType/UnsignedInteger.cpp>	// -> UnsignedInteger.h
#include <RPerl/DataType/Integer.cpp>	// -> Integer.h
#include <RPerl/DataType/Number.cpp>	// -> Number.h
#include <RPerl/DataType/Character.cpp>	// -> Character.h
#include <RPerl/DataType/String.cpp>	// -> String.h
#include <RPerl/DataStructure/Array.cpp>	// -> Array.h
#include <RPerl/DataStructure/Hash.cpp>	// -> Hash.h

// DEV NOTE: renamed from Perl to_string() to C++ To_string() to avoid error redefining std::to_string()
string To_string(boolean input_boolean) { return boolean_to_string(input_boolean); }
string To_string(unsigned_integer input_unsigned_integer) { return unsigned_integer_to_string(input_unsigned_integer); }
string To_string(integer input_integer) { return integer_to_string(input_integer); }
//string To_string(gmp_integer input_gmp_integer) { return gmp_integer_to_string(input_gmp_integer); }
string To_string(number input_number) { return number_to_string(input_number); }
string To_string(character input_character) { return character_to_string(input_character); }
string To_string(string input_string) { return string_to_string(input_string); }

#endif

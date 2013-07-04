use strict;  use warnings;
package RPerl::DataStructure::Array;

our @ISA = ('RPerl::DataStructure');
use RPerl::DataStructure;

# [[[ DATA TYPES ]]]
use RPerl::DataType::Void;
use RPerl::DataType::Integer;
use RPerl::DataType::Float;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;
use RPerl::DataType::Scalar;
use RPerl::DataType::Unknown;

# [[[ DATA STRUCTURES ]]]
use RPerl::DataStructure::Hash;


# [[[ ARRAYS ]]]

# an array is a 1-dimensional list/vector/sequence/set of data types
package array;
our @ISA = ('ARRAY', 'RPerl::DataStructure::Array');

# array with const size
package const_array;
our @ISA = ('array', 'const');

# ref to array
package array_ref;
our @ISA = ('ref');

# ref to (array with const size)
package const_array_ref;
our @ISA = ('ref');


# [[[ INT ARRAYS ]]]

# array of ints
package int__array;
our @ISA = ('array');

# array of (ints with const values)
package const_int__array;
our @ISA = ('array');

# array of (refs to ints)
package int_ref__array;
our @ISA = ('array');

# array of (refs to (ints with const values))
package const_int_ref__array;
our @ISA = ('array');

# (array with const size) of ints
package int__const_array;
our @ISA = ('const_array');

# (array with const size) of (ints with const values)
package const_int__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to ints)
package int_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (ints with const values))
package const_int_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of ints
package int__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (ints with const values)
package const_int__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to ints)
package int_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (ints with const values))
package const_int_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of ints
package int__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (ints with const values)
package const_int__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to ints)
package int_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (ints with const values))
package const_int_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ FLOAT ARRAYS ]]]

# array of floats
package float__array;
our @ISA = ('array');

# array of (floats with const values)
package const_float__array;
our @ISA = ('array');

# array of (refs to floats)
package float_ref__array;
our @ISA = ('array');

# array of (refs to (floats with const values))
package const_float_ref__array;
our @ISA = ('array');

# (array with const size) of floats
package float__const_array;
our @ISA = ('const_array');

# (array with const size) of (floats with const values)
package const_float__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to floats)
package float_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (floats with const values))
package const_float_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of floats
package float__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (floats with const values)
package const_float__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to floats)
package float_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (floats with const values))
package const_float_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of floats
package float__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (floats with const values)
package const_float__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to floats)
package float_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (floats with const values))
package const_float_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ NUMBER ARRAYS ]]]

# array of numbers
package number__array;
our @ISA = ('array');

# array of (numbers with const values)
package const_number__array;
our @ISA = ('array');

# array of (refs to numbers)
package number_ref__array;
our @ISA = ('array');

# array of (refs to (numbers with const values))
package const_number_ref__array;
our @ISA = ('array');

# (array with const size) of numbers
package number__const_array;
our @ISA = ('const_array');

# (array with const size) of (numbers with const values)
package const_number__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to numbers)
package number_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (numbers with const values))
package const_number_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of numbers
package number__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (numbers with const values)
package const_number__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to numbers)
package number_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (numbers with const values))
package const_number_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of numbers
package number__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (numbers with const values)
package const_number__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to numbers)
package number_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (numbers with const values))
package const_number_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ CHAR ARRAYS ]]]

# array of chars
package char__array;
our @ISA = ('array');

# array of (chars with const values)
package const_char__array;
our @ISA = ('array');

# array of (refs to chars)
package char_ref__array;
our @ISA = ('array');

# array of (refs to (chars with const values))
package const_char_ref__array;
our @ISA = ('array');

# (array with const size) of chars
package char__const_array;
our @ISA = ('const_array');

# (array with const size) of (chars with const values)
package const_char__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to chars)
package char_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (chars with const values))
package const_char_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of chars
package char__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (chars with const values)
package const_char__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to chars)
package char_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (chars with const values))
package const_char_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of chars
package char__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (chars with const values)
package const_char__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to chars)
package char_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (chars with const values))
package const_char_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ STRING ARRAYS ]]]

# array of strings
package string__array;
our @ISA = ('array');

# array of (strings with const values)
package const_string__array;
our @ISA = ('array');

# array of (refs to strings)
package string_ref__array;
our @ISA = ('array');

# array of (refs to (strings with const values))
package const_string_ref__array;
our @ISA = ('array');

# (array with const size) of strings
package string__const_array;
our @ISA = ('const_array');

# (array with const size) of (strings with const values)
package const_string__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to strings)
package string_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (strings with const values))
package const_string_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of strings
package string__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (strings with const values)
package const_string__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to strings)
package string_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (strings with const values))
package const_string_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of strings
package string__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (strings with const values)
package const_string__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to strings)
package string_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (strings with const values))
package const_string_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ SCALAR ARRAYS ]]]

# array of scalars
package scalar__array;
our @ISA = ('array');

# array of (scalars with const values)
package const_scalar__array;
our @ISA = ('array');

# array of (refs to scalars)
package scalar_ref__array;
our @ISA = ('array');

# array of (refs to (scalars with const values))
package const_scalar_ref__array;
our @ISA = ('array');

# (array with const size) of scalars
package scalar__const_array;
our @ISA = ('const_array');

# (array with const size) of (scalars with const values)
package const_scalar__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to scalars)
package scalar_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (scalars with const values))
package const_scalar_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of scalars
package scalar__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (scalars with const values)
package const_scalar__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to scalars)
package scalar_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (scalars with const values))
package const_scalar_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of scalars
package scalar__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (scalars with const values)
package const_scalar__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to scalars)
package scalar_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (scalars with const values))
package const_scalar_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ UNKNOWN ARRAYS ]]]

# array of unknowns
package unknown__array;
our @ISA = ('array');

# array of (unknowns with const values)
package const_unknown__array;
our @ISA = ('array');

# array of (refs to unknowns)
package unknown_ref__array;
our @ISA = ('array');

# array of (refs to (unknowns with const values))
package const_unknown_ref__array;
our @ISA = ('array');

# (array with const size) of unknowns
package unknown__const_array;
our @ISA = ('const_array');

# (array with const size) of (unknowns with const values)
package const_unknown__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to unknowns)
package unknown_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (unknowns with const values))
package const_unknown_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of unknowns
package unknown__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (unknowns with const values)
package const_unknown__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to unknowns)
package unknown_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (unknowns with const values))
package const_unknown_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of unknowns
package unknown__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (unknowns with const values)
package const_unknown__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to unknowns)
package unknown_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (unknowns with const values))
package const_unknown_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ ARRAY ARRAYS (2-dimensional) ]]]

# array of arrays
package array__array;
our @ISA = ('array');

# array of (arrays with const sizes)
package const_array__array;
our @ISA = ('array');

# array of (refs to arrays)
package array_ref__array;
our @ISA = ('array');

# array of (refs to (arrays with const sizes))
package const_array_ref__array;
our @ISA = ('array');

# (array with const size) of arrays
package array__const_array;
our @ISA = ('const_array');

# (array with const size) of (arrays with const sizes)
package const_array__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to arrays)
package array_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (arrays with const sizes))
package const_array_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of arrays
package array__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (arrays with const sizes)
package const_array__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to arrays)
package array_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (arrays with const sizes))
package const_array_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of arrays
package array__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (arrays with const sizes)
package const_array__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to arrays)
package array_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (arrays with const sizes))
package const_array_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ HASH ARRAYS (2-dimesional) ]]]

# array of hashs
package hash__array;
our @ISA = ('array');

# array of (hashs with const sizes)
package const_hash__array;
our @ISA = ('array');

# array of (refs to hashs)
package hash_ref__array;
our @ISA = ('array');

# array of (refs to (hashs with const sizes))
package const_hash_ref__array;
our @ISA = ('array');

# (array with const size) of hashs
package hash__const_array;
our @ISA = ('const_array');

# (array with const size) of (hashs with const sizes)
package const_hash__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to hashs)
package hash_ref__const_array;
our @ISA = ('const_array');

# (array with const size) of (refs to (hashs with const sizes))
package const_hash_ref__const_array;
our @ISA = ('const_array');

# (ref to array) of hashs
package hash__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (hashs with const sizes)
package const_hash__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to hashs)
package hash_ref__array_ref;
our @ISA = ('array_ref');

# (ref to array) of (refs to (hashs with const sizes))
package const_hash_ref__array_ref;
our @ISA = ('array_ref');

# (ref to (array with const size)) of hashs
package hash__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (hashs with const sizes)
package const_hash__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to hashs)
package hash_ref__const_array_ref;
our @ISA = ('const_array_ref');

# (ref to (array with const size)) of (refs to (hashs with const sizes))
package const_hash_ref__const_array_ref;
our @ISA = ('const_array_ref');


# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
our void $typetest___int__array_ref__in___void__out = sub { (my int__array_ref $lucky_numbers) = @_;  my int $how_lucky = scalar @{$lucky_numbers};  my int $i;  for ($i = 0;  $i < $how_lucky;  ++$i) { print "in Perl Array::typetest___int__array_ref__in___void__out(), have lucky number $i/" . ($how_lucky - 1) . " = " . $lucky_numbers->[$i] . ", BARBAT\n"; } };
our int__array_ref $typetest___int__in___int__array_ref__out = sub { (my int $my_size) = @_;  my int__array_ref $new_array = [];  my int $i;  for ($i = 0;  $i < $my_size;  ++$i) { $new_array->[$i] = $i * 5;  print "in Perl Array::typetest___int__in___int__array_ref__out(), setting element $i/" . ($my_size - 1) . " = " . $new_array->[$i] . ", BARBAT\n"; }  return($new_array); };

our void $typetest___number__array_ref__in___void__out = sub { (my number__array_ref $lucky_numbers) = @_;  my int $how_lucky = scalar @{$lucky_numbers};  my int $i;  for ($i = 0;  $i < $how_lucky;  ++$i) { print "in Perl Array::typetest___number__array_ref__in___void__out(), have lucky number $i/" . ($how_lucky - 1) . " = " . $lucky_numbers->[$i] . ", BARBAT\n"; } };
our number__array_ref $typetest___int__in___number__array_ref__out = sub { (my int $my_size) = @_;  my number__array_ref $new_array = [];  my int $i;  for ($i = 0;  $i < $my_size;  ++$i) { $new_array->[$i] = $i * 5.123456789;  print "in Perl Array::typetest___int__in___number__array_ref__out(), setting element $i/" . ($my_size - 1) . " = " . $new_array->[$i] . ", BARBAT\n"; }  return($new_array); };

our void $typetest___string__array_ref__in___void__out = sub { (my string__array_ref $people) = @_;  my int $i;  for ($i = 0;  $i < scalar @{$people};  ++$i) { print "in Perl Array::typetest___string__array_ref__in___void__out(), have person $i = '" . $people->[$i] . "', FOOBAZ\n"; } };
our string__array_ref $typetest___int__in___string__array_ref__out = sub { (my int $my_size) = @_;  my string__array_ref $people = [];  my int $i;  for ($i = 0;  $i < $my_size;  ++$i) { $people->[$i] = "Jeffy Ten! $i/" . ($my_size - 1);  print "in Perl Array::typetest___void__in___string__array_ref__out(), bottom of for() loop, have i = $i, just set another Jeffy!\n"; }  return($people); };

use strict;  use warnings;
package RPerl::DataStructure::Hash;

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
use RPerl::DataStructure::Array;


# [[[ HASHES ]]]

# a hash is an associative array, meaning a 1-dimensional list/vector/sequence/set of (key, value) pairs
package hash;
our @ISA = ('HASH', 'RPerl::DataStructure::Hash');

# hash with const size
package const_hash;
our @ISA = ('hash', 'const');

# ref to hash
package hash_ref;
our @ISA = ('ref');

# ref to (hash with const size)
package const_hash_ref;
our @ISA = ('ref');


# [[[ INT HASHES ]]]

# hash of ints
package int__hash;
our @ISA = ('hash');

# hash of (ints with const values)
package const_int__hash;
our @ISA = ('hash');

# hash of (refs to ints)
package int_ref__hash;
our @ISA = ('hash');

# hash of (refs to (ints with const values))
package const_int_ref__hash;
our @ISA = ('hash');

# (hash with const size) of ints
package int__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (ints with const values)
package const_int__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to ints)
package int_ref__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to (ints with const values))
package const_int_ref__const_hash;
our @ISA = ('const_hash');

# (ref to hash) of ints
package int__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (ints with const values)
package const_int__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to ints)
package int_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to (ints with const values))
package const_int_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to (hash with const size)) of ints
package int__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (ints with const values)
package const_int__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to ints)
package int_ref__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (ints with const values))
package const_int_ref__const_hash_ref;
our @ISA = ('const_hash_ref');


# [[[ FLOAT HASHES ]]]

# hash of floats
package float__hash;
our @ISA = ('hash');

# hash of (floats with const values)
package const_float__hash;
our @ISA = ('hash');

# hash of (refs to floats)
package float_ref__hash;
our @ISA = ('hash');

# hash of (refs to (floats with const values))
package const_float_ref__hash;
our @ISA = ('hash');

# (hash with const size) of floats
package float__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (floats with const values)
package const_float__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to floats)
package float_ref__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to (floats with const values))
package const_float_ref__const_hash;
our @ISA = ('const_hash');

# (ref to hash) of floats
package float__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (floats with const values)
package const_float__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to floats)
package float_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to (floats with const values))
package const_float_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to (hash with const size)) of floats
package float__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (floats with const values)
package const_float__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to floats)
package float_ref__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (floats with const values))
package const_float_ref__const_hash_ref;
our @ISA = ('const_hash_ref');


# [[[ NUMBER HASHES ]]]

# hash of numbers
package number__hash;
our @ISA = ('hash');

# hash of (numbers with const values)
package const_number__hash;
our @ISA = ('hash');

# hash of (refs to numbers)
package number_ref__hash;
our @ISA = ('hash');

# hash of (refs to (numbers with const values))
package const_number_ref__hash;
our @ISA = ('hash');

# (hash with const size) of numbers
package number__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (numbers with const values)
package const_number__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to numbers)
package number_ref__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to (numbers with const values))
package const_number_ref__const_hash;
our @ISA = ('const_hash');

# (ref to hash) of numbers
package number__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (numbers with const values)
package const_number__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to numbers)
package number_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to (numbers with const values))
package const_number_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to (hash with const size)) of numbers
package number__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (numbers with const values)
package const_number__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to numbers)
package number_ref__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (numbers with const values))
package const_number_ref__const_hash_ref;
our @ISA = ('const_hash_ref');


# [[[ CHAR HASHES ]]]

# hash of chars
package char__hash;
our @ISA = ('hash');

# hash of (chars with const values)
package const_char__hash;
our @ISA = ('hash');

# hash of (refs to chars)
package char_ref__hash;
our @ISA = ('hash');

# hash of (refs to (chars with const values))
package const_char_ref__hash;
our @ISA = ('hash');

# (hash with const size) of chars
package char__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (chars with const values)
package const_char__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to chars)
package char_ref__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to (chars with const values))
package const_char_ref__const_hash;
our @ISA = ('const_hash');

# (ref to hash) of chars
package char__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (chars with const values)
package const_char__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to chars)
package char_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to (chars with const values))
package const_char_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to (hash with const size)) of chars
package char__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (chars with const values)
package const_char__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to chars)
package char_ref__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (chars with const values))
package const_char_ref__const_hash_ref;
our @ISA = ('const_hash_ref');


# [[[ STRING HASHES ]]]

# hash of strings
package string__hash;
our @ISA = ('hash');

# hash of (strings with const values)
package const_string__hash;
our @ISA = ('hash');

# hash of (refs to strings)
package string_ref__hash;
our @ISA = ('hash');

# hash of (refs to (strings with const values))
package const_string_ref__hash;
our @ISA = ('hash');

# (hash with const size) of strings
package string__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (strings with const values)
package const_string__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to strings)
package string_ref__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to (strings with const values))
package const_string_ref__const_hash;
our @ISA = ('const_hash');

# (ref to hash) of strings
package string__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (strings with const values)
package const_string__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to strings)
package string_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to (strings with const values))
package const_string_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to (hash with const size)) of strings
package string__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (strings with const values)
package const_string__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to strings)
package string_ref__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (strings with const values))
package const_string_ref__const_hash_ref;
our @ISA = ('const_hash_ref');


# [[[ SCALAR HASHES ]]]

# hash of scalars
package scalar__hash;
our @ISA = ('hash');

# hash of (scalars with const values)
package const_scalar__hash;
our @ISA = ('hash');

# hash of (refs to scalars)
package scalar_ref__hash;
our @ISA = ('hash');

# hash of (refs to (scalars with const values))
package const_scalar_ref__hash;
our @ISA = ('hash');

# (hash with const size) of scalars
package scalar__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (scalars with const values)
package const_scalar__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to scalars)
package scalar_ref__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to (scalars with const values))
package const_scalar_ref__const_hash;
our @ISA = ('const_hash');

# (ref to hash) of scalars
package scalar__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (scalars with const values)
package const_scalar__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to scalars)
package scalar_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to (scalars with const values))
package const_scalar_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to (hash with const size)) of scalars
package scalar__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (scalars with const values)
package const_scalar__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to scalars)
package scalar_ref__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (scalars with const values))
package const_scalar_ref__const_hash_ref;
our @ISA = ('const_hash_ref');


# [[[ UNKNOWN HASHES ]]]

# hash of unknowns
package unknown__hash;
our @ISA = ('hash');

# hash of (unknowns with const values)
package const_unknown__hash;
our @ISA = ('hash');

# hash of (refs to unknowns)
package unknown_ref__hash;
our @ISA = ('hash');

# hash of (refs to (unknowns with const values))
package const_unknown_ref__hash;
our @ISA = ('hash');

# (hash with const size) of unknowns
package unknown__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (unknowns with const values)
package const_unknown__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to unknowns)
package unknown_ref__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to (unknowns with const values))
package const_unknown_ref__const_hash;
our @ISA = ('const_hash');

# (ref to hash) of unknowns
package unknown__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (unknowns with const values)
package const_unknown__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to unknowns)
package unknown_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to (unknowns with const values))
package const_unknown_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to (hash with const size)) of unknowns
package unknown__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (unknowns with const values)
package const_unknown__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to unknowns)
package unknown_ref__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (unknowns with const values))
package const_unknown_ref__const_hash_ref;
our @ISA = ('const_hash_ref');


# [[[ ARRAY HASHES (2-dimensional) ]]]

# hash of arrays
package array__hash;
our @ISA = ('hash');

# hash of (arrays with const sizes)
package const_array__hash;
our @ISA = ('hash');

# hash of (refs to arrays)
package array_ref__hash;
our @ISA = ('hash');

# hash of (refs to (arrays with const sizes))
package const_array_ref__hash;
our @ISA = ('hash');

# (hash with const size) of arrays
package array__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (arrays with const sizes)
package const_array__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to arrays)
package array_ref__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to (arrays with const sizes))
package const_array_ref__const_hash;
our @ISA = ('const_hash');

# (ref to hash) of arrays
package array__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (arrays with const sizes)
package const_array__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to arrays)
package array_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to (arrays with const sizes))
package const_array_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to (hash with const size)) of arrays
package array__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (arrays with const sizes)
package const_array__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to arrays)
package array_ref__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (arrays with const sizes))
package const_array_ref__const_hash_ref;
our @ISA = ('const_hash_ref');


# [[[ HASH HASHES (2-dimesional) ]]]

# hash of hashs
package hash__hash;
our @ISA = ('hash');

# hash of (hashs with const sizes)
package const_hash__hash;
our @ISA = ('hash');

# hash of (refs to hashs)
package hash_ref__hash;
our @ISA = ('hash');

# hash of (refs to (hashs with const sizes))
package const_hash_ref__hash;
our @ISA = ('hash');

# (hash with const size) of hashs
package hash__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (hashs with const sizes)
package const_hash__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to hashs)
package hash_ref__const_hash;
our @ISA = ('const_hash');

# (hash with const size) of (refs to (hashs with const sizes))
package const_hash_ref__const_hash;
our @ISA = ('const_hash');

# (ref to hash) of hashs
package hash__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (hashs with const sizes)
package const_hash__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to hashs)
package hash_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to hash) of (refs to (hashs with const sizes))
package const_hash_ref__hash_ref;
our @ISA = ('hash_ref');

# (ref to (hash with const size)) of hashs
package hash__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (hashs with const sizes)
package const_hash__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to hashs)
package hash_ref__const_hash_ref;
our @ISA = ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (hashs with const sizes))
package const_hash_ref__const_hash_ref;
our @ISA = ('const_hash_ref');


# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
our void $typetest___int__hash_ref__in___void__out = sub { (my int__hash_ref $lucky_numbers) = @_;  foreach my string $key (keys %{$lucky_numbers}) { print "in Perl Hash::typetest___int__hash_ref__in___void__out(), have lucky number '$key' => " . $lucky_numbers->{$key} . ", BARSTOOL\n"; } };
our int__hash_ref $typetest___int__in___int__hash_ref__out = sub { (my int $my_size) = @_;  my int__hash_ref $new_hash = {};  my int $i;  my string $temp_key;  for ($i = 0;  $i < $my_size;  ++$i) { $temp_key = "funkey" . $i;  $new_hash->{$temp_key} = $i * 5;  print "in Perl Hash::typetest___int__in___int__hash_ref__out(), setting entry '$temp_key' => " . $new_hash->{$temp_key} . ", BARSTOOL\n"; }  return($new_hash); };
our void $typetest___number__hash_ref__in___void__out = sub { (my number__hash_ref $lucky_numbers) = @_;  foreach my string $key (keys %{$lucky_numbers}) { print "in Perl Hash::typetest___number__hash_ref__in___void__out(), have lucky number '$key' => " . $lucky_numbers->{$key} . ", BARSTOOL\n"; } };
our number__hash_ref $typetest___int__in___number__hash_ref__out = sub { (my int $my_size) = @_;  my number__hash_ref $new_hash = {};  my int $i;  my string $temp_key;  for ($i = 0;  $i < $my_size;  ++$i) { $temp_key = "funkey" . $i;  $new_hash->{$temp_key} = $i * 5.123456789;  print "in Perl Hash::typetest___int__in___number__hash_ref__out(), setting entry '$temp_key' => " . $new_hash->{$temp_key} . ", BARSTOOL\n"; }  return($new_hash); };
our void $typetest___string__hash_ref__in___void__out = sub { (my string__hash_ref $people) = @_;  foreach my string $key (keys %{$people}) { print "in Perl Hash::typetest___string__hash_ref__in___void__out(), have person '$key' => '" . $people->{$key} . "', STARBOOL\n"; } };
our string__hash_ref $typetest___int__in___string__hash_ref__out = sub { (my int $my_size) = @_;  my string__hash_ref $people = {};  my int $i;  for ($i = 0;  $i < $my_size;  ++$i) { $people->{"Luker_key" . $i} = "Jeffy Ten! " . $i . "/" . ($my_size - 1); print "in Perl Hash::typetest___int__in___string__hash_ref__out(), bottom of for() loop, have i = $i, just set another Jeffy!\n"; }  return($people); };

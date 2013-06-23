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

# a hash is an associative array, meaning a 1-dimensional list/vector/sequence/set of (key, data type) pairs
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
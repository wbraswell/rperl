## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::DataStructure::Hash::SubTypes;
use strict;
use warnings;
use version; our $VERSION = qv('0.1.0');
use Carp;

# [[[ HASHES ]]]

# a hash is an associative array, meaning a 1-dimensional list/vector/sequence/set of (key, value) pairs
package hash;
#use base ( 'HASH', 'RPerl::DataStructure::Hash' );  # NEED FIX: error base package 'HASH' is empty, does this need to be addressed?
use base ( 'RPerl::DataStructure::Hash' );

# hash with const size
package const_hash;
use base qw(hash const);

# ref to hash
package hash_ref;
use base ('ref');

# ref to (hash with const size)
package const_hash_ref;
use base ('ref');

# [[[ INTEGER HASHES ]]]

# hash of integers
package integer__hash;
use base ('hash');

# hash of (integers with const values)
package const_integer__hash;
use base ('hash');

# hash of (refs to integers)
package integer_ref__hash;
use base ('hash');

# hash of (refs to (integers with const values))
package const_integer_ref__hash;
use base ('hash');

# (hash with const size) of integers
package integer__const_hash;
use base ('const_hash');

# (hash with const size) of (integers with const values)
package const_integer__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to integers)
package integer_ref__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to (integers with const values))
package const_integer_ref__const_hash;
use base ('const_hash');

# (ref to hash) of integers
package integer__hash_ref;
use base ('hash_ref');

# (ref to hash) of (integers with const values)
package const_integer__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to integers)
package integer_ref__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to (integers with const values))
package const_integer_ref__hash_ref;
use base ('hash_ref');

# (ref to (hash with const size)) of integers
package integer__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (integers with const values)
package const_integer__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to integers)
package integer_ref__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (integers with const values))
package const_integer_ref__const_hash_ref;
use base ('const_hash_ref');

# [[[ FLOAT HASHES ]]]

# hash of floats
package float__hash;
use base ('hash');

# hash of (floats with const values)
package const_float__hash;
use base ('hash');

# hash of (refs to floats)
package float_ref__hash;
use base ('hash');

# hash of (refs to (floats with const values))
package const_float_ref__hash;
use base ('hash');

# (hash with const size) of floats
package float__const_hash;
use base ('const_hash');

# (hash with const size) of (floats with const values)
package const_float__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to floats)
package float_ref__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to (floats with const values))
package const_float_ref__const_hash;
use base ('const_hash');

# (ref to hash) of floats
package float__hash_ref;
use base ('hash_ref');

# (ref to hash) of (floats with const values)
package const_float__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to floats)
package float_ref__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to (floats with const values))
package const_float_ref__hash_ref;
use base ('hash_ref');

# (ref to (hash with const size)) of floats
package float__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (floats with const values)
package const_float__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to floats)
package float_ref__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (floats with const values))
package const_float_ref__const_hash_ref;
use base ('const_hash_ref');

# [[[ NUMBER HASHES ]]]

# hash of numbers
package number__hash;
use base ('hash');

# hash of (numbers with const values)
package const_number__hash;
use base ('hash');

# hash of (refs to numbers)
package number_ref__hash;
use base ('hash');

# hash of (refs to (numbers with const values))
package const_number_ref__hash;
use base ('hash');

# (hash with const size) of numbers
package number__const_hash;
use base ('const_hash');

# (hash with const size) of (numbers with const values)
package const_number__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to numbers)
package number_ref__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to (numbers with const values))
package const_number_ref__const_hash;
use base ('const_hash');

# (ref to hash) of numbers
package number__hash_ref;
use base ('hash_ref');

# (ref to hash) of (numbers with const values)
package const_number__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to numbers)
package number_ref__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to (numbers with const values))
package const_number_ref__hash_ref;
use base ('hash_ref');

# (ref to (hash with const size)) of numbers
package number__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (numbers with const values)
package const_number__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to numbers)
package number_ref__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (numbers with const values))
package const_number_ref__const_hash_ref;
use base ('const_hash_ref');

# [[[ CHAR HASHES ]]]

# hash of chars
package char__hash;
use base ('hash');

# hash of (chars with const values)
package const_char__hash;
use base ('hash');

# hash of (refs to chars)
package char_ref__hash;
use base ('hash');

# hash of (refs to (chars with const values))
package const_char_ref__hash;
use base ('hash');

# (hash with const size) of chars
package char__const_hash;
use base ('const_hash');

# (hash with const size) of (chars with const values)
package const_char__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to chars)
package char_ref__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to (chars with const values))
package const_char_ref__const_hash;
use base ('const_hash');

# (ref to hash) of chars
package char__hash_ref;
use base ('hash_ref');

# (ref to hash) of (chars with const values)
package const_char__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to chars)
package char_ref__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to (chars with const values))
package const_char_ref__hash_ref;
use base ('hash_ref');

# (ref to (hash with const size)) of chars
package char__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (chars with const values)
package const_char__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to chars)
package char_ref__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (chars with const values))
package const_char_ref__const_hash_ref;
use base ('const_hash_ref');

# [[[ STRING HASHES ]]]

# hash of strings
package string__hash;
use base ('hash');

# hash of (strings with const values)
package const_string__hash;
use base ('hash');

# hash of (refs to strings)
package string_ref__hash;
use base ('hash');

# hash of (refs to (strings with const values))
package const_string_ref__hash;
use base ('hash');

# (hash with const size) of strings
package string__const_hash;
use base ('const_hash');

# (hash with const size) of (strings with const values)
package const_string__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to strings)
package string_ref__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to (strings with const values))
package const_string_ref__const_hash;
use base ('const_hash');

# (ref to hash) of strings
package string__hash_ref;
use base ('hash_ref');

# (ref to hash) of (strings with const values)
package const_string__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to strings)
package string_ref__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to (strings with const values))
package const_string_ref__hash_ref;
use base ('hash_ref');

# (ref to (hash with const size)) of strings
package string__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (strings with const values)
package const_string__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to strings)
package string_ref__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (strings with const values))
package const_string_ref__const_hash_ref;
use base ('const_hash_ref');

# [[[ SCALAR HASHES ]]]

# hash of scalars
package scalar__hash;
use base ('hash');

# hash of (scalars with const values)
package const_scalar__hash;
use base ('hash');

# hash of (refs to scalars)
package scalar_ref__hash;
use base ('hash');

# hash of (refs to (scalars with const values))
package const_scalar_ref__hash;
use base ('hash');

# (hash with const size) of scalars
package scalar__const_hash;
use base ('const_hash');

# (hash with const size) of (scalars with const values)
package const_scalar__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to scalars)
package scalar_ref__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to (scalars with const values))
package const_scalar_ref__const_hash;
use base ('const_hash');

# (ref to hash) of scalars
package scalar__hash_ref;
use base ('hash_ref');

# (ref to hash) of (scalars with const values)
package const_scalar__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to scalars)
package scalar_ref__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to (scalars with const values))
package const_scalar_ref__hash_ref;
use base ('hash_ref');

# (ref to (hash with const size)) of scalars
package scalar__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (scalars with const values)
package const_scalar__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to scalars)
package scalar_ref__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (scalars with const values))
package const_scalar_ref__const_hash_ref;
use base ('const_hash_ref');

# [[[ UNKNOWN HASHES ]]]

# hash of unknowns
package unknown__hash;
use base ('hash');

# hash of (unknowns with const values)
package const_unknown__hash;
use base ('hash');

# hash of (refs to unknowns)
package unknown_ref__hash;
use base ('hash');

# hash of (refs to (unknowns with const values))
package const_unknown_ref__hash;
use base ('hash');

# (hash with const size) of unknowns
package unknown__const_hash;
use base ('const_hash');

# (hash with const size) of (unknowns with const values)
package const_unknown__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to unknowns)
package unknown_ref__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to (unknowns with const values))
package const_unknown_ref__const_hash;
use base ('const_hash');

# (ref to hash) of unknowns
package unknown__hash_ref;
use base ('hash_ref');

# (ref to hash) of (unknowns with const values)
package const_unknown__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to unknowns)
package unknown_ref__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to (unknowns with const values))
package const_unknown_ref__hash_ref;
use base ('hash_ref');

# (ref to (hash with const size)) of unknowns
package unknown__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (unknowns with const values)
package const_unknown__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to unknowns)
package unknown_ref__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (unknowns with const values))
package const_unknown_ref__const_hash_ref;
use base ('const_hash_ref');

# [[[ ARRAY HASHES (2-dimensional) ]]]

# hash of arrays
package array__hash;
use base ('hash');

# hash of (arrays with const sizes)
package const_array__hash;
use base ('hash');

# hash of (refs to arrays)
package array_ref__hash;
use base ('hash');

# hash of (refs to (arrays with const sizes))
package const_array_ref__hash;
use base ('hash');

# (hash with const size) of arrays
package array__const_hash;
use base ('const_hash');

# (hash with const size) of (arrays with const sizes)
package const_array__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to arrays)
package array_ref__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to (arrays with const sizes))
package const_array_ref__const_hash;
use base ('const_hash');

# (ref to hash) of arrays
package array__hash_ref;
use base ('hash_ref');

# (ref to hash) of (arrays with const sizes)
package const_array__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to arrays)
package array_ref__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to (arrays with const sizes))
package const_array_ref__hash_ref;
use base ('hash_ref');

# (ref to (hash with const size)) of arrays
package array__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (arrays with const sizes)
package const_array__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to arrays)
package array_ref__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (arrays with const sizes))
package const_array_ref__const_hash_ref;
use base ('const_hash_ref');

# [[[ HASH HASHES (2-dimesional) ]]]

# hash of hashs
package hash__hash;
use base ('hash');

# hash of (hashs with const sizes)
package const_hash__hash;
use base ('hash');

# hash of (refs to hashs)
package hash_ref__hash;
use base ('hash');

# hash of (refs to (hashs with const sizes))
package const_hash_ref__hash;
use base ('hash');

# (hash with const size) of hashs
package hash__const_hash;
use base ('const_hash');

# (hash with const size) of (hashs with const sizes)
package const_hash__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to hashs)
package hash_ref__const_hash;
use base ('const_hash');

# (hash with const size) of (refs to (hashs with const sizes))
package const_hash_ref__const_hash;
use base ('const_hash');

# (ref to hash) of hashs
package hash__hash_ref;
use base ('hash_ref');

# (ref to hash) of (hashs with const sizes)
package const_hash__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to hashs)
package hash_ref__hash_ref;
use base ('hash_ref');

# (ref to hash) of (refs to (hashs with const sizes))
package const_hash_ref__hash_ref;
use base ('hash_ref');

# (ref to (hash with const size)) of hashs
package hash__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (hashs with const sizes)
package const_hash__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to hashs)
package hash_ref__const_hash_ref;
use base ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (hashs with const sizes))
package const_hash_ref__const_hash_ref;
use base ('const_hash_ref');

1;

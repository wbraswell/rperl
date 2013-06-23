use strict;  use warnings;
package RPerl::DataType::String;

our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;

# a string is 0 or more letters, digits, or other ASCII (Unicode???) symbols
package string;
our @ISA = ('RPerl::DataType::String');

# string with const value
package const_string;
our @ISA = ('string', 'const');

# ref to string
package string_ref;
our @ISA = ('ref');

# ref to (string with const value)
package const_string_ref;
our @ISA = ('ref');

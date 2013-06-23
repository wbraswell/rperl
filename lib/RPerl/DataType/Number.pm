use strict;  use warnings;
package RPerl::DataType::Number;

our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;

# a number is any numeric value, meaning either an integer or a floating-point number
package number;
our @ISA = ('RPerl::DataType::Number');

# number with const value
package const_number;
our @ISA = ('number', 'const');

# ref to number
package number_ref;
our @ISA = ('ref');

# ref to (number with const value)
package const_number_ref;
our @ISA = ('ref');

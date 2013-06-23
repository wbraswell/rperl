use strict;  use warnings;
package RPerl::DataType::Integer;

our @ISA = ('RPerl::DataType::Number');
use RPerl::DataType::Number;

# an integer is a whole number, it has no floating-point (fractional/decimal) component
package int;
our @ISA = ('RPerl::DataType::Integer');

# int with const value
package const_int;
our @ISA = ('int', 'const');

# ref to int
package int_ref;
our @ISA = ('ref');

# ref to (int with const value)
package const_int_ref;
our @ISA = ('ref');
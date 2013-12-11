# NEED FIX, OUTDATED
# Float should have it's own functionality and compile to float C/C++ type, not just be a sub-type of Number
use strict;  use warnings;
package RPerl::DataType::Float;

our @ISA = ('RPerl::DataType::Number');
use RPerl::DataType::Number;

# a floating-point number has a fractional/decimal component
package float;
our @ISA = ('RPerl::DataType::Float');

# float with const value
package const_float;
our @ISA = ('float', 'const');

# ref to float
package float_ref;
our @ISA = ('ref');

# ref to (float with const value)
package const_float_ref;
our @ISA = ('ref');

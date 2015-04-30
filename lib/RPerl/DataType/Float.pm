# DEV NOTE, CORRELATION #7:
# NEED FIX, OUTDATED
# Float should have it's own functionality and compile to float C/C++ type for memory optimization, not just be a sub-type of Number
use strict;  use warnings;
package RPerl::DataType::Float;

our @ISA = ('RPerl::DataType::Number');
use RPerl::DataType::Number;

# a floating-point number has a fractional/decimal component
package float;
our @ISA = ('RPerl::DataType::Float');
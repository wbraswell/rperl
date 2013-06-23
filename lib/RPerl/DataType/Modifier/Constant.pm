use strict;  use warnings;
package RPerl::DataType::Modifier::Constant;

our @ISA = ('RPerl::DataType::Modifier');
use RPerl::DataType::Modifier;

# a constant data type's value does not change after being initialized;
# a constant data structure's size (number of elements) does not change after being initialized;
# a constant is not a data type, use 'const_unknown' instead
package const;
our @ISA = ('RPerl::DataType::Modifier::Constant');
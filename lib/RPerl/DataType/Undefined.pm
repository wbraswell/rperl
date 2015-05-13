use strict; use warnings;
package RPerl::DataType::Undefined;

our @ISA = ('RPerl::DataType');
use RPerl::DataType;

# undefined means it could be any data type or data structure
package undefined;
our @ISA = ('RPerl::DataType::Undefined');

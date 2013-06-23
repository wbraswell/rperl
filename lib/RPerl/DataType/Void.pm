use strict;  use warnings;
package RPerl::DataType::Void;

our @ISA = ('RPerl::DataType');
use RPerl::DataType;

# void means no type, void does NOT mean unknown data type, that is RPerl::DataType::Unknown
package void;
our @ISA = ('RPerl::DataType::Void');

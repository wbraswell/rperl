use strict; use warnings;
package RPerl::DataType::Unknown;

our @ISA = ('RPerl::DataType');
use RPerl::DataType;

# unknown means it could be any data type or data structure
package unknown;
our @ISA = ('RPerl::DataType::Unknown');

# ref to unknown
package unknown_ref;
our @ISA = ('ref');

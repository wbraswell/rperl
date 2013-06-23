use strict;  use warnings;
package RPerl::DataType::Scalar;

our @ISA = ('RPerl::DataType');
use RPerl::DataType;

# a scalar is a known, non-void data type, meaning a number or a string
# DEV NOTE: overload Perl's 'scalar' keyword
package scalar;
our @ISA = ('RPerl::DataType::Scalar');

# scalar with const value
package const_scalar;
our @ISA = ('scalar', 'const');

# ref to scalar
package scalar_ref;
our @ISA = ('ref');

# ref to (scalar with const value)
package const_scalar_ref;
our @ISA = ('ref');

use strict;  use warnings;
package RPerl::DataType::Scalar;

our @ISA = ('RPerl::DataType');
use RPerl::DataType;

# a scalartype is a known, non-void data type, meaning a number or a string
# DEV NOTE: do NOT overload Perl's 'scalar' keyword!!!
package scalartype;
our @ISA = ('RPerl::DataType::Scalar');

# scalartype with const value
package const_scalartype;
our @ISA = ('scalartype', 'const');

# ref to scalartype
package scalartype_ref;
our @ISA = ('ref');

# ref to (scalartype with const value)
package const_scalartype_ref;
our @ISA = ('ref');

package RPerl::DataType::Scalar;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

our @ISA = ('RPerl::DataType');
use RPerl::DataType;

# a scalartype is a known, non-void data type, meaning a number or a string
# DEV NOTE: do NOT overload Perl's 'scalar' keyword!!!
package scalartype;
our @ISA = ('RPerl::DataType::Scalar');

# scalartype with const value
package const_scalartype;
our @ISA = ('scalartype', 'const');
package RPerl::DataType::Reference;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
use RPerl::DataType::Constant;


package ref;
our @ISA = ('RPerl::DataType::Reference');


package const__ref;
our @ISA = ('ref', 'const');


package ref__method;
our @ISA = ('method');
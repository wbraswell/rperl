package RPerl::DataType::Reference;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
use RPerl::DataType::Constant;


package ref;
our @ISA = ('RPerl::DataType::Reference');


package const_ref;
#our @ISA = ('RPerl::DataType::Reference', 'RPerl::DataType::Constant');
our @ISA = ('ref', 'const');
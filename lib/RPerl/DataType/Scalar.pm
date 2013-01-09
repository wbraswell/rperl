package RPerl::DataType::Scalar;
use strict; use warnings;
our @ISA = ('RPerl::DataType');
use RPerl::DataType;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package scalar;
our @ISA = ('RPerl::DataType::Scalar');


package const_scalar;
our @ISA = ('RPerl::DataType::Scalar', 'RPerl::DataType::Constant');


package scalar_ref;
our @ISA = ('RPerl::DataType::Scalar', 'RPerl::DataType::Reference');


package const_scalar_ref;
our @ISA = ('RPerl::DataType::Scalar', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
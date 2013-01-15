package RPerl::DataType::Scalar;
use strict; use warnings;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package scalar;
our @ISA = ('RPerl::DataType::Scalar');


package const_scalar;
#our @ISA = ('RPerl::DataType::Scalar', 'RPerl::DataType::Constant');
our @ISA = ('scalar', 'const');


package scalar_ref;
#our @ISA = ('RPerl::DataType::Scalar', 'RPerl::DataType::Reference');
our @ISA = ('scalar', 'ref');


package const_scalar_ref;
#our @ISA = ('RPerl::DataType::Scalar', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
our @ISA = ('scalar', 'const', 'ref');
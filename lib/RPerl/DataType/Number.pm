package RPerl::DataType::Number;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package number;
our @ISA = ('RPerl::DataType::Number');


package const_number;
#our @ISA = ('RPerl::DataType::Number', 'RPerl::DataType::Constant');
our @ISA = ('number', 'const');


package number_ref;
#our @ISA = ('RPerl::DataType::Number', 'RPerl::DataType::Reference');
our @ISA = ('number', 'ref');


package const_number_ref;
#our @ISA = ('RPerl::DataType::Number', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
our @ISA = ('number', 'constant', 'ref');
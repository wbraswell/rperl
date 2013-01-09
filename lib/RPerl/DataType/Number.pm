package RPerl::DataType::Number;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package number;
our @ISA = ('RPerl::DataType::Number');


package const_number;
our @ISA = ('RPerl::DataType::Number', 'RPerl::DataType::Constant');


package number_ref;
our @ISA = ('RPerl::DataType::Number', 'RPerl::DataType::Reference');


package const_number_ref;
our @ISA = ('RPerl::DataType::Number', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
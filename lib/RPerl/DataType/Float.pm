package RPerl::DataType::Float;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Number');
use RPerl::DataType::Number;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package float;
our @ISA = ('RPerl::DataType::Float');


package const_float;
our @ISA = ('RPerl::DataType::Float', 'RPerl::DataType::Constant');


package float_ref;
our @ISA = ('RPerl::DataType::Float', 'RPerl::DataType::Reference');


package const_float_ref;
our @ISA = ('RPerl::DataType::Float', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');

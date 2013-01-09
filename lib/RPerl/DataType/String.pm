package RPerl::DataType::String;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package string;
our @ISA = ('RPerl::DataType::String');


package const_string;
our @ISA = ('RPerl::DataType::String', 'RPerl::DataType::Constant');


package string_ref;
our @ISA = ('RPerl::DataType::String', 'RPerl::DataType::Reference');


package const_string_ref;
our @ISA = ('RPerl::DataType::String', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');


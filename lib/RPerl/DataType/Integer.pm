package RPerl::DataType::Integer;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Number');
use RPerl::DataType::Number;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package int;
our @ISA = ('RPerl::DataType::Integer');


package const_int;
our @ISA = ('RPerl::DataType::Integer', 'RPerl::DataType::Constant');


package int_ref;
our @ISA = ('RPerl::DataType::Integer', 'RPerl::DataType::Reference');


package const_int_ref;
our @ISA = ('RPerl::DataType::Integer', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');

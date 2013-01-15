package RPerl::DataType::Float;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Number');
use RPerl::DataType::Number;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package float;
our @ISA = ('RPerl::DataType::Float');


package const_float;
#our @ISA = ('RPerl::DataType::Float', 'RPerl::DataType::Constant');
our @ISA = ('float', 'const');


package float_ref;
#our @ISA = ('RPerl::DataType::Float', 'RPerl::DataType::Reference');
our @ISA = ('float', 'ref');


package const_float_ref;
#our @ISA = ('RPerl::DataType::Float', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
our @ISA = ('float', 'const', 'ref');

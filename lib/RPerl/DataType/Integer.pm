package RPerl::DataType::Integer;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Number');
use RPerl::DataType::Number;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package int;
our @ISA = ('RPerl::DataType::Integer');


package const_int;
#our @ISA = ('RPerl::DataType::Integer', 'RPerl::DataType::Constant');
our @ISA = ('int', 'const');


package int_ref;
#our @ISA = ('RPerl::DataType::Integer', 'RPerl::DataType::Reference');
our @ISA = ('int', 'ref');


package const_int_ref;
#our @ISA = ('RPerl::DataType::Integer', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
our @ISA = ('int', 'const', 'ref');

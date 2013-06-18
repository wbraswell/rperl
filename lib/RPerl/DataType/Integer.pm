package RPerl::DataType::Integer;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Number');
use RPerl::DataType::Number;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package int;
our @ISA = ('RPerl::DataType::Integer');


package const__int;
our @ISA = ('int', 'const');


package int_ref;
our @ISA = ('ref');


package const__int_ref;
our @ISA = ('int_ref', 'const');


package int__method;
our @ISA = ('method');


package int_ref__method;
our @ISA = ('method');
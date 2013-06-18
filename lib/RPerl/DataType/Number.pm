package RPerl::DataType::Number;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package number;
our @ISA = ('RPerl::DataType::Number');


package const__number;
our @ISA = ('number', 'const');


package number_ref;
our @ISA = ('ref');


package const__number_ref;
our @ISA = ('number_ref', 'const');


package number__method;
our @ISA = ('method');


package number_ref__method;
our @ISA = ('method');

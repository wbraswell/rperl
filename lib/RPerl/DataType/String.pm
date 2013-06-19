package RPerl::DataType::String;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package string;
our @ISA = ('RPerl::DataType::String');


package const__string;
our @ISA = ('string', 'const');


package string_ref;
our @ISA = ('ref');


package const__string_ref;
our @ISA = ('string_ref', 'const');


package string__method;
our @ISA = ('method');


package string_ref__method;
our @ISA = ('method');
package RPerl::DataType::Float;
use strict; use warnings;
our @ISA = ('RPerl::DataType::Number');
use RPerl::DataType::Number;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package float;
our @ISA = ('RPerl::DataType::Float');


package const__float;
our @ISA = ('float', 'const');


package float_ref;
our @ISA = ('ref');


package const__float_ref;
our @ISA = ('float_ref', 'const');


package float__method;
our @ISA = ('method');


package float_ref__method;
our @ISA = ('method');
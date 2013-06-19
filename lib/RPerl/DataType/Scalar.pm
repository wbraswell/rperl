package RPerl::DataType::Scalar;
use strict; use warnings;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package scalar;
our @ISA = ('RPerl::DataType::Scalar');


package const__scalar;
our @ISA = ('scalar', 'const');


package scalar_ref;
our @ISA = ('ref');


package const__scalar_ref;
our @ISA = ('scalar_ref', 'const');


package scalar__method;
our @ISA = ('method');


package scalar_ref__method;
our @ISA = ('method');
package RPerl::DataStructure::Array;
use strict; use warnings;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package array;
our @ISA = ('ARRAY', 'RPerl::DataStructure::Array');


package array_ref;
our @ISA = ('ref');


package scalar_array_ref;
our @ISA = ('array_ref');


package const__array_ref;
our @ISA = ('array_ref', 'const');


package const__scalar_array_ref;
our @ISA = ('scalar_array_ref', 'const');


package array__method;
our @ISA = ('method');


package array_ref__method;
our @ISA = ('method');


package scalar_array_ref__method;
our @ISA = ('method');
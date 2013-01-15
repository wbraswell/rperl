package RPerl::DataStructure::Array;
use strict; use warnings;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package array;
our @ISA = ('ARRAY', 'RPerl::DataStructure::Array');


package array_ref;
#our @ISA = ('RPerl::DataStructure::Array', 'RPerl::DataType::Reference');
our @ISA = ('array', 'ref');


package scalar_array_ref;
#our @ISA = ('RPerl::DataStructure::Array', 'RPerl::DataType::Reference');
our @ISA = ('array_ref');


package const_array_ref;
#our @ISA = ('RPerl::DataStructure::Array', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
our @ISA = ('array_ref', 'const');


package const_scalar_array_ref;
#our @ISA = ('RPerl::DataStructure::Array', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
our @ISA = ('scalar_array_ref', 'const');
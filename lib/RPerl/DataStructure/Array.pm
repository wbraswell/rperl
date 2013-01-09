package RPerl::DataStructure::Array;
use strict; use warnings;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package array_ref;
our @ISA = ('RPerl::DataStructure::Array', 'RPerl::DataType::Reference');


package scalar_array_ref;
our @ISA = ('RPerl::DataStructure::Array', 'RPerl::DataType::Reference');


package const_array_ref;
our @ISA = ('RPerl::DataStructure::Array', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');


package const_scalar_array_ref;
our @ISA = ('RPerl::DataStructure::Array', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
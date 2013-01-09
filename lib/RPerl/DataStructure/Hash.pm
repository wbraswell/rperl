package RPerl::DataStructure::Hash;
use strict; use warnings;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package hash_ref;
our @ISA = ('RPerl::DataStructure::Hash', 'RPerl::DataType::Reference');


package scalar_hash_ref;
our @ISA = ('RPerl::DataStructure::Hash', 'RPerl::DataType::Reference');


package const_hash_ref;
our @ISA = ('RPerl::DataStructure::Hash', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');


package const_scalar_hash_ref;
our @ISA = ('RPerl::DataStructure::Hash', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
package RPerl::DataStructure::Hash;
use strict; use warnings;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package hash;
our @ISA = ('HASH', 'RPerl::DataStructure::Hash');


package hash_ref;
#our @ISA = ('RPerl::DataStructure::Hash', 'RPerl::DataType::Reference');
our @ISA = ('hash', 'ref');


package scalar_hash_ref;
#our @ISA = ('RPerl::DataStructure::Hash', 'RPerl::DataType::Reference');
our @ISA = ('hash_ref');


package const_hash_ref;
#our @ISA = ('RPerl::DataStructure::Hash', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
our @ISA = ('hash_ref', 'const');


package const_scalar_hash_ref;
#our @ISA = ('RPerl::DataStructure::Hash', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');
our @ISA = ('scalar_hash_ref', 'constant');
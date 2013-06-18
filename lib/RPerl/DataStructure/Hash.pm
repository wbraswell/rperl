package RPerl::DataStructure::Hash;
use strict; use warnings;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package hash;
our @ISA = ('HASH', 'RPerl::DataStructure::Hash');


package hash_ref;
our @ISA = ('ref');


package scalar_hash_ref;
our @ISA = ('hash_ref');


package const__hash_ref;
our @ISA = ('hash_ref', 'const');


package const__scalar_hash_ref;
our @ISA = ('scalar_hash_ref', 'const');


package hash__method;
our @ISA = ('method');


package hash_ref__method;
our @ISA = ('method');


package scalar_hash_ref__method;
our @ISA = ('method');
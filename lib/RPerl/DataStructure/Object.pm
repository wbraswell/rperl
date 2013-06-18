package RPerl::DataStructure::Object;
use strict; use warnings;
our @ISA = ('RPerl::DataStructure::Hash');
use RPerl::DataStructure::Hash;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package object;
our @ISA = ('RPerl::DataStructure::Object');


package const__object;
our @ISA = ('object', 'const');


package object_ref;
our @ISA = ('ref');


package const__object_ref;
our @ISA = ('object_ref', 'const');


package object__method;
our @ISA = ('method');


package object_ref__method;
our @ISA = ('method');

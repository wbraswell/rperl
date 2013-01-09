package RPerl::DataStructure::Object;
use strict; use warnings;
our @ISA = ('RPerl::DataStructure::Hash');
use RPerl::DataStructure::Hash;
use RPerl::DataType::Constant;
use RPerl::DataType::Reference;


package object;
our @ISA = ('RPerl::DataStructure::Object');


package const_object;
our @ISA = ('RPerl::DataStructure::Object', 'RPerl::DataType::Constant');


package object_ref;
our @ISA = ('RPerl::DataStructure::Object', 'RPerl::DataType::Reference');

package const_object_ref;
our @ISA = ('RPerl::DataStructure::Object', 'RPerl::DataType::Constant', 'RPerl::DataType::Reference');

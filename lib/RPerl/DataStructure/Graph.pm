use strict;  use warnings; 
package RPerl::DataStructure::Graph;

# NEED ADDRESS: which inheritance???
our @ISA = ('RPerl::DataStructure', 'RPerl::DataType::Modifier::Reference');
#our @ISA = ('RPerl::DataType::Modifier::Reference');
use RPerl::DataStructure;


# [[[ GRAPHS ]]]

# ref to graph
package graphref;
our @ISA = ('RPerl::DataStructure::GraphReference'); 
use RPerl::DataStructure::Graph;

# NEED ADD: remaining sub-types

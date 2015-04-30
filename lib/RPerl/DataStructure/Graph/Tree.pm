use strict;  use warnings; 
package RPerl::DataStructure::Graph::Tree;

# NEED FIX: weird inheritance for these as-reference-only data structures
package RPerl::DataStructure::Graph::TreeReference;
our @ISA = ('RPerl::DataStructure::GraphReference');
use RPerl::DataStructure::Graph;


# [[[ GRAPHS ]]]

# ref to tree
package treeref;
our @ISA = ('RPerl::DataStructure::Graph::TreeReference');
use RPerl::DataStructure::Graph::Tree;

# NEED ADD: remaining sub-types

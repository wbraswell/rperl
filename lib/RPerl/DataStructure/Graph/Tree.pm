package RPerl::DataStructure::Graph::Tree;
use strict;  use warnings;


package RPerl::DataStructure::Graph::TreeReference;
our @ISA = ('RPerl::DataStructure::GraphReference');
use RPerl::DataStructure::Graph;


package tree_ref;
our @ISA = ('RPerl::DataStructure::Graph::TreeReference');
use RPerl::DataStructure::Graph::Tree;
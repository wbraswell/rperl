package RPerl::DataStructure::Graph::Tree;
use strict;
use warnings; 
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

# NEED FIX: weird inheritance for these as-reference-only data structures
package RPerl::DataStructure::Graph::TreeReference;
use parent qw(RPerl::DataStructure::GraphReference);
use RPerl::DataStructure::Graph;

# [[[ GRAPHS ]]]

# ref to tree
package  # hide from PAUSE indexing
    treeref;
use parent qw(RPerl::DataStructure::Graph::TreeReference);
use RPerl::DataStructure::Graph::Tree;

# NEED ADD: remaining sub-types

1;  # end of class
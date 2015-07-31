package RPerl::DataStructure::Graph;
use strict;
use warnings; 
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

use parent qw(RPerl::DataType::Modifier::Reference);
use RPerl::DataType::Modifier::Reference;


# [[[ GRAPHS ]]]

# ref to graph
package  # hide from PAUSE indexing
    graphref;
use parent qw(RPerl::DataStructure::GraphReference); 
use RPerl::DataStructure::Graph;

# NEED ADD: remaining sub-types

1;  # end of class
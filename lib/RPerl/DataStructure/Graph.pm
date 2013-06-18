package RPerl::DataStructure::Graph;
use strict;  use warnings; 


package RPerl::DataStructure::GraphReference;
our @ISA = ('RPerl::DataStructure', 'RPerl::DataType::Reference');
use RPerl::DataStructure;
use RPerl::DataType::Reference;


package graph_ref;
our @ISA = ('RPerl::DataStructure::GraphReference'); 
use RPerl::DataStructure::Graph;


package graph_ref__method;
our @ISA = ('method');
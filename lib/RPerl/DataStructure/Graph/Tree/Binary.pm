use strict;  use warnings;
package RPerl::DataStructure::Graph::Tree::Binary;

# NEED FIX: weird inheritance for these as-reference-only data structures
package RPerl::DataStructure::Graph::Tree::BinaryReference;
our @ISA = ('RPerl::DataStructure::Graph::TreeReference');
use RPerl::DataStructure::Graph::Tree;

# trees are comprised of nodes
use RPerl::DataStructure::Graph::Tree::Binary::Node;

# coderef parameter accepted by traverse method(s)
use RPerl::Code;

# must include here because we do not inherit data types
use RPerl::DataType::Unknown;
use RPerl::DataType::String;
use RPerl::DataStructure::Array;
#use RPerl::CodeBlock::Subroutine::Method;  # NEED ADD: explicit method declarations

our hashref $properties =
{
	root => my RPerl::DataStructure::Graph::Tree::Binary::NodeReference $TYPED_root = undef,  # start with root = undef so we can test for empty tree
};

our RPerl::DataStructure::Graph::Tree::BinaryReference $new_from_nested_arrayrefs = sub {(my string $class, my arrayref $input) = @_;
;
#	RPerl::diag("in ...Tree::BinaryReference::new_from_nested_arrayrefs(), received \$class = '$class', and \$input =\n" . RPerl::DUMPER($input) . "\n");
	my unknown $output = $class->new();

	$output->{root} = binarytreenoderef->new_from_nested_arrayrefs($input);

	return $output;
};

# much happens in the Node class, provide wrapper methods
our unknown $traverse_breadthfirst_queue = sub {(my RPerl::DataStructure::Graph::Tree::BinaryReference $self, my RPerl::CodeReference $callback) = @_; return $self->{root}->traverse_breadthfirst_queue($callback) if defined($self->{root}); };
our unknown $traverse_depthfirst_preorder = sub {(my RPerl::DataStructure::Graph::Tree::BinaryReference $self, my RPerl::CodeReference $callback) = @_; return $self->{root}->traverse_depthfirst_preorder($callback) if defined($self->{root}); };
our arrayref $to_nested_arrayrefs = sub {(my RPerl::DataStructure::Graph::Tree::BinaryReference $data) = @_; return $data->{root}->to_nested_arrayrefs(); };


# [[[ BINARY TREES ]]]

# ref to binary tree
# DEV NOTE: for naming conventions, see DEV NOTE in same code section of LinkedList.pm
package binarytreeref;
our @ISA = ('RPerl::DataStructure::Graph::Tree::BinaryReference');
use RPerl::DataStructure::Graph::Tree::Binary;
our $properties = $properties; our $new_from_nested_arrayrefs = $new_from_nested_arrayrefs; our $traverse_depthfirst_preorder = $traverse_depthfirst_preorder; our $to_nested_arrayrefs = $to_nested_arrayrefs; our $traverse_breadthfirst_queue = $traverse_breadthfirst_queue;

# [[[ INT BINARY TREES ]]]

# (ref to binary tree) of integers
package integer_binarytreeref;
our @ISA = ('binarytreeref');
our $properties = $properties; our $new_from_arrayref = $new_from_arrayref; our $binarytree_unshift = $binarytree_unshift; our $DUMPER = $DUMPER;

# NEED ADD: remaining sub-types

1;

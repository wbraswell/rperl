use strict;  use warnings;
package RPerl::DataStructure::Graph::Tree::Binary;

# NEED FIX: weird inheritance for these as-reference-only data structures
package RPerl::DataStructure::Graph::Tree::BinaryReference;
our @ISA = ('RPerl::DataStructure::Graph::TreeReference');
use RPerl::DataStructure::Graph::Tree;

# trees are comprised of nodes
use RPerl::DataStructure::Graph::Tree::Binary::Node;

# code_ref parameter accepted by traverse method(s)
use RPerl::Code;

# must include here because we do not inherit data types
use RPerl::DataType::Unknown;
use RPerl::DataType::String;
use RPerl::DataStructure::Array;
#use RPerl::Code::Subroutine::Method;  # NEED ADD: explicit method declarations

our %properties =
(
	root => my RPerl::DataStructure::Graph::Tree::Binary::NodeReference $KEY_root = undef,  # start with root = undef so we can test for empty tree
);

our RPerl::DataStructure::Graph::Tree::BinaryReference $new_from_nested_array_refs = sub {(my string $class, my const_array_ref $input) = @_;
;
#	print "in ...Tree::BinaryReference::new_from_nested_array_refs(), received \$class = '$class', and \$input =\n" . RPerl::DUMPER($input) . "\n" if $RPerl::DEBUG;
	my unknown $output = $class->new();

	$output->{root} = binarytreenode_ref->new_from_nested_array_refs($input);

	return $output;
};

# much happens in the Node class, provide wrapper methods
our unknown $traverse_breadthfirst_queue = sub {(my RPerl::DataStructure::Graph::Tree::BinaryReference $self, my RPerl::CodeReference $callback) = @_; return $self->{root}->traverse_breadthfirst_queue($callback) if defined($self->{root}); };
our unknown $traverse_depthfirst_preorder = sub {(my RPerl::DataStructure::Graph::Tree::BinaryReference $self, my RPerl::CodeReference $callback) = @_; return $self->{root}->traverse_depthfirst_preorder($callback) if defined($self->{root}); };
our array_ref $to_nested_array_refs = sub {(my RPerl::DataStructure::Graph::Tree::BinaryReference $data) = @_; return $data->{root}->to_nested_array_refs(); };


# [[[ BINARY TREES ]]]

# ref to binary tree
# DEV NOTE: for naming conventions, see DEV NOTE in same code section of LinkedList.pm
package binarytree_ref;
our @ISA = ('RPerl::DataStructure::Graph::Tree::BinaryReference');
use RPerl::DataStructure::Graph::Tree::Binary;
our %properties = %properties; our $new_from_nested_array_refs = $new_from_nested_array_refs; our $traverse_depthfirst_preorder = $traverse_depthfirst_preorder; our $to_nested_array_refs = $to_nested_array_refs; our $traverse_breadthfirst_queue = $traverse_breadthfirst_queue;

# ref to binary tree with const size
package const_binarytree_ref;
our @ISA = ('ref');


# [[[ INT BINARY TREES ]]]

# (ref to binary tree) of integers
package integer__binarytree_ref;
our @ISA = ('binarytree_ref');
our %properties = %properties; our $new_from_array_ref = $new_from_array_ref; our $binarytree_unshift = $binarytree_unshift; our $DUMPER = $DUMPER;

# (ref to binary tree with const size) of integers
package integer__const_binarytree_ref;
our @ISA = ('const_binarytree_ref');
our %properties = %properties; our $new_from_array_ref = $new_from_array_ref; our $binarytree_unshift = $binarytree_unshift; our $DUMPER = $DUMPER;

# NEED ADD: remaining sub-types

1;
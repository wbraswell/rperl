package RPerl::DataStructure::Graph::Tree::Binary;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# NEED FIX: weird inheritance for these as-reference-only data structures
package RPerl::DataStructure::Graph::Tree::BinaryReference;
use parent qw(RPerl::DataStructure::Graph::TreeReference);
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

sub new_from_nested_arrayrefs {
    { my RPerl::DataStructure::Graph::Tree::BinaryReference $RETURN_TYPE };
    (my string $class, my arrayref $input) = @ARG;
#	RPerl::diag("in ...Tree::BinaryReference::new_from_nested_arrayrefs(), received \$class = '$class', and \$input =\n" . RPerl::DUMPER($input) . "\n");
	my unknown $output = $class->new();

	$output->{root} = binarytreenoderef->new_from_nested_arrayrefs($input);
    return $output;
}

# much happens in the Node class, provide wrapper methods
sub traverse_breadthfirst_queue { { my unknown $RETURN_TYPE };(my RPerl::DataStructure::Graph::Tree::BinaryReference $self, my RPerl::CodeReference $callback) = @ARG; return $self->{root}->traverse_breadthfirst_queue($callback) if defined($self->{root}); }
sub traverse_depthfirst_preorder { { my unknown $RETURN_TYPE };(my RPerl::DataStructure::Graph::Tree::BinaryReference $self, my RPerl::CodeReference $callback) = @ARG; return $self->{root}->traverse_depthfirst_preorder($callback) if defined($self->{root}); }
sub to_nested_arrayrefs { { my arrayref $RETURN_TYPE };(my RPerl::DataStructure::Graph::Tree::BinaryReference $data) = @ARG; return $data->{root}->to_nested_arrayrefs(); }


# [[[ BINARY TREES ]]]

# ref to binary tree
# DEV NOTE: for naming conventions, see DEV NOTE in same code section of LinkedList.pm
package  # hide from PAUSE indexing
    binarytreeref;
use parent qw(RPerl::DataStructure::Graph::Tree::BinaryReference);
use RPerl::DataStructure::Graph::Tree::Binary;
our $properties = $properties; our $new_from_nested_arrayrefs = $new_from_nested_arrayrefs; our $traverse_depthfirst_preorder = $traverse_depthfirst_preorder; our $to_nested_arrayrefs = $to_nested_arrayrefs; our $traverse_breadthfirst_queue = $traverse_breadthfirst_queue;

# [[[ INT BINARY TREES ]]]

# (ref to binary tree) of integers
package  # hide from PAUSE indexing
    integer_binarytreeref;
use parent qw(binarytreeref);
our $properties = $properties; our $new_from_arrayref = $new_from_arrayref; our $binarytree_unshift = $binarytree_unshift; our $DUMPER = $DUMPER;

# NEED ADD: remaining sub-types

1;  # end of class

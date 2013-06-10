package RPerl::DataStructure::Graph::Tree::Binary;
use strict; use warnings;

package RPerl::DataStructure::Graph::Tree::BinaryReference;
our @ISA = ('RPerl::DataStructure::Graph::TreeReference');
use RPerl::DataStructure::Graph::Tree;

# trees are comprised of nodes
use RPerl::DataStructure::Graph::Tree::Binary::Node;

# code_ref parameter accepted by traverse method(s)
use RPerl::DataStructure::Code;

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
our unknown $traverse_breadthfirst_queue = sub {(my RPerl::DataStructure::Graph::Tree::BinaryReference $self, my RPerl::DataStructure::CodeReference $callback) = @_; return $self->{root}->traverse_breadthfirst_queue($callback) if defined($self->{root}); };
our unknown $traverse_depthfirst_preorder = sub {(my RPerl::DataStructure::Graph::Tree::BinaryReference $self, my RPerl::DataStructure::CodeReference $callback) = @_; return $self->{root}->traverse_depthfirst_preorder($callback) if defined($self->{root}); };
our array_ref $to_nested_array_refs = sub {(my RPerl::DataStructure::Graph::Tree::BinaryReference $data) = @_; return $data->{root}->to_nested_array_refs(); };


# we only provide data structure references, not the direct data structures themselves,
# because an RPerl::Class is a blessed hash _reference_, and we are not natively implementing the data structures in C here;
# thus the slightly weird naming convention where some places have delimeters (:: or _) and some don't,
# I favored the consistency of user-side RPerl data type short-form package alias _ delimeter over the Perl system-side package name scope :: delimeter 
package binarytree_ref;
our @ISA = ('RPerl::DataStructure::Graph::Tree::BinaryReference');
use RPerl::DataStructure::Graph::Tree::Binary;
our %properties = %properties; our $new_from_nested_array_refs = $new_from_nested_array_refs; our $traverse_depthfirst_preorder = $traverse_depthfirst_preorder; our $to_nested_array_refs = $to_nested_array_refs; our $traverse_breadthfirst_queue = $traverse_breadthfirst_queue;


package scalar_binarytree_ref;
our @ISA = ('binarytree_ref');
use RPerl::DataStructure::Graph::Tree::Binary;
our %properties = %properties; our $new_from_nested_array_refs = $new_from_nested_array_refs; our $traverse_depthfirst_preorder = $traverse_depthfirst_preorder; our $to_nested_array_refs = $to_nested_array_refs; our $traverse_breadthfirst_queue = $traverse_breadthfirst_queue;


package const_binarytree_ref;
our @ISA = ('binarytree_ref', 'const');
use RPerl::DataStructure::Graph::Tree::Binary;
use RPerl::DataType::Constant;
our %properties = %properties; our $new_from_nested_array_refs = $new_from_nested_array_refs; our $traverse_depthfirst_preorder = $traverse_depthfirst_preorder; our $to_nested_array_refs = $to_nested_array_refs; our $traverse_breadthfirst_queue = $traverse_breadthfirst_queue;


package const_scalar_binarytree_ref;
our @ISA = ('scalar_binarytree_ref', 'const');
use RPerl::DataStructure::Graph::Tree::Binary;
use RPerl::DataType::Constant;
our %properties = %properties; our $new_from_nested_array_refs = $new_from_nested_array_refs; our $traverse_depthfirst_preorder = $traverse_depthfirst_preorder; our $to_nested_array_refs = $to_nested_array_refs; our $traverse_breadthfirst_queue = $traverse_breadthfirst_queue;
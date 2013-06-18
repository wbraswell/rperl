package RPerl::DataStructure::Graph::Tree::Binary::Node;
use strict;  use warnings;

package RPerl::DataStructure::Graph::Tree::Binary::NodeReference;
our @ISA = ('RPerl::DataStructure', 'RPerl::DataType::Reference');
use RPerl::DataStructure;
use RPerl::DataType::Reference;

# code_ref parameter accepted by traverse method(s)
use RPerl::DataStructure::Code;

our %properties =
(
	data => my unknown $KEY_data = undef,
	left => my RPerl::DataStructure::Graph::Tree::Binary::NodeReference $KEY_left = undef,
	right => my RPerl::DataStructure::Graph::Tree::Binary::NodeReference $KEY_right = undef
);

# traverse nodes breadth-first
our unknown $traverse_breadthfirst_queue = sub {(my RPerl::DataStructure::Graph::Tree::Binary::NodeReference $self, my RPerl::DataStructure::CodeReference $callback) = @_;
;
	print "in ...Tree::Binary::NodeReference::traverse_breadthfirst_queue(), received \$self = \n" . RPerl::DUMPER($self) . "\n" if $RPerl::DEBUG;
	my @return_value = ();
	my $return_value_tmp;
	my @queue = ();
	my RPerl::DataStructure::Graph::Tree::Binary::NodeReference $node;
	
	unshift(@queue, $self);
	
	print "in ...Tree::Binary::NodeReference::traverse_breadthfirst_queue(), before while() loop have \@queue = \n" . RPerl::DUMPER(\@queue) . "\n" if $RPerl::DEBUG;
	
	while (scalar(@queue) > 0)
	{
		$node = pop(@queue);
		print "in ...Tree::Binary::NodeReference::traverse_breadthfirst_queue(), top of while() loop have \$node = \n" . RPerl::DUMPER($node) . "\n" if $RPerl::DEBUG;
	
		$return_value_tmp = &{$callback}($node);
		push(@return_value, $return_value_tmp) if (defined($return_value_tmp));  # do not include undef values
		
		print "in ...Tree::Binary::NodeReference::traverse_breadthfirst_queue(), inside while() loop, after callback have \@return_value = \n" . RPerl::DUMPER(\@return_value) . "\n" if $RPerl::DEBUG;
		
		unshift(@queue, $node->{left}) if (defined($node->{left}));
		unshift(@queue, $node->{right}) if (defined($node->{right}));
		print "in ...Tree::Binary::NodeReference::traverse_breadthfirst_queue(), bottom of while() loop, have \@queue = \n" . RPerl::DUMPER(\@queue) . "\n" if $RPerl::DEBUG;
	}

};

# traverse nodes depth-first in pre-order
our unknown $traverse_depthfirst_preorder = sub {(my RPerl::DataStructure::Graph::Tree::Binary::NodeReference $self, my RPerl::DataStructure::CodeReference $callback) = @_;
;
	print "in ...Tree::Binary::NodeReference::traverse_depthfirst_preorder(), received \$self = \n" . RPerl::DUMPER($self) . "\n" if $RPerl::DEBUG;
#	print "in ...Tree::Binary::NodeReference::traverse_depthfirst_preorder(), received \$callback = " . RPerl::DUMPER($callback) . "\n" if $RPerl::DEBUG;
	my @return_value = ();
	my unknown $return_value_tmp = undef;
	
	# callback on self
	$return_value_tmp = &{$callback}($self);
	push(@return_value, $return_value_tmp) if (defined($return_value_tmp));  # do not include undef values
	print "in ...Tree::Binary::NodeReference::traverse_depthfirst_preorder(), after callback on \$self have \@return_value = \n" . RPerl::DUMPER(\@return_value) . "\n" if $RPerl::DEBUG;
	
	# possibly recurse on left
	if (defined($self->{left}))
	{
		if (ref(\$self->{left}) eq 'SCALAR') { $return_value_tmp = &{$callback}($self->{left});  push(@return_value, $return_value_tmp); }
		else { $return_value_tmp = $self->{left}->traverse_depthfirst_preorder($callback);  @return_value = (@return_value, @{$return_value_tmp}); }
	}
	print "in ...Tree::Binary::NodeReference::traverse_depthfirst_preorder(), after (possible recurse on) \$self->{left} have \@return_value = \n" . RPerl::DUMPER(\@return_value) . "\n" if $RPerl::DEBUG;
	
	# possibly recurse on right
	if (defined($self->{right}))
	{
		if (ref(\$self->{right}) eq 'SCALAR') { $return_value_tmp = &{$callback}($self->{right});  push(@return_value, $return_value_tmp); }
		else { $return_value_tmp = $self->{right}->traverse_depthfirst_preorder($callback);  @return_value = (@return_value, @{$return_value_tmp}); }
	}
	print "in ...Tree::Binary::NodeReference::traverse_depthfirst_preorder(), after (possible recurse on) \$self->{right} have \@return_value = \n" . RPerl::DUMPER(\@return_value) . "\n" if $RPerl::DEBUG;
	
	return \@return_value;
};

# accept binary tree nodes, return nested array refs;
# modified pre-order traversal to achieve the opposite of new_from_nested_array_refs()
our unknown $to_nested_array_refs = sub {(my RPerl::DataStructure::Graph::Tree::Binary::NodeReference $self) = @_;
;
#	print "in ...Tree::Binary::NodeReference::to_nested_array_refs(), received \$self = \n" . RPerl::DUMPER($self) . "\n" if $RPerl::DEBUG;
	my array_ref $return_value = [];
	my array_ref $return_value_children = [];
	$return_value->[1] = $return_value_children;
	
	$return_value->[0] = $self->{data};  # do include undef values
#	print "in ...Tree::Binary::NodeReference::to_nested_array_refs(), after callback on \$self have \$return_value = \n" . RPerl::DUMPER($return_value) . "\n" if $RPerl::DEBUG;
	
	# possibly recurse on left
	if (defined($self->{left}))
	{
		if (ref(\$self->{left}) eq 'SCALAR') { $return_value_children->[0] = $self->{left}; }
		else { $return_value_children->[0] = $self->{left}->to_nested_array_refs(); }
	}
	else { $return_value_children->[0] = undef; }
#	print "in ...Tree::Binary::NodeReference::to_nested_array_refs(), after (possible recurse on) \$self->{left} have \$return_value = \n" . RPerl::DUMPER($return_value) . "\n" if $RPerl::DEBUG;
	
	# possibly recurse on right
	if (defined($self->{right}))
	{
		if (ref(\$self->{right}) eq 'SCALAR') { $return_value_children->[1] = $self->{right}; }
		else { $return_value_children->[1] = $self->{right}->to_nested_array_refs(); }
	}
	else { $return_value_children->[1] = undef; }
#	print "in ...Tree::Binary::NodeReference::to_nested_array_refs(), after (possible recurse on) \$self->{right} have \$return_value = \n" . RPerl::DUMPER($return_value) . "\n" if $RPerl::DEBUG;
	
	return $return_value;
};

# accept nested array refs, return binary tree nodes
our RPerl::DataStructure::Graph::Tree::Binary::NodeReference $new_from_nested_array_refs = sub {(my string $class, my const_array_ref $input) = @_;
;
#	print "in ...Tree::Binary::NodeReference::new_from_nested_array_refs(), received \$class = '$class', and \$input =\n" . RPerl::DUMPER($input) . "\n" if $RPerl::DEBUG;
	my unknown $output = $class->new();

	$output->{data} = $input->[0];
	
	if (ref($input->[1]->[0]) eq 'ARRAY') { $output->{left} = $class->new_from_nested_array_refs($input->[1]->[0]); }
	else { $output->{left} = $input->[1]->[0]; }
	
	if (ref($input->[1]->[1]) eq 'ARRAY') { $output->{right} = $class->new_from_nested_array_refs($input->[1]->[1]); }
	else { $output->{right} = $input->[1]->[1]; }
	
#	print "in ...Tree::Binary::NodeReference::new_from_nested_array_refs(), about to return \$output =\n" . RPerl::DUMPER($output) . "\n" if $RPerl::DEBUG;

	return $output;
};

=UNUSED CODE (Using default Data::Dumper for now)
our string $DUMPER = sub {(my RPerl::DataStructure::Graph::Tree::Binary::NodeReference $node) = @_;
;
	my string $dumped = '[';

# START HERE
	$dumped .= "**FAKE_DUMP_STRING**";
	
	$dumped .= ']';
	return $dumped;
};
=cut


# we only provide data structure references, not the direct data structures themselves,
# because an RPerl::Class is a blessed hash _reference_, and we are not natively implementing the data structures in C here;
# thus the slightly weird naming convention where some places have delimeters (:: or _) and some don't,
# I favored the consistency of user-side RPerl data type short-form package alias _ delimeter over the Perl system-side package name scope :: delimeter 
package binarytreenode_ref;
our @ISA = ('RPerl::DataStructure::Graph::Tree::Binary::NodeReference');
use RPerl::DataStructure::Graph::Tree::Binary::Node;
our %properties = %properties; our $new_from_nested_array_refs = $new_from_nested_array_refs; our $traverse_depthfirst_preorder = $traverse_depthfirst_preorder; our $to_nested_array_refs = $to_nested_array_refs; our $traverse_breadthfirst_queue = $traverse_breadthfirst_queue;


package binarytreenode_ref__method;
our @ISA = ('method');
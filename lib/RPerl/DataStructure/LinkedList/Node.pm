use strict;  use warnings;
package RPerl::DataStructure::LinkedList::Node;

package RPerl::DataStructure::LinkedList::NodeReference;
our @ISA = ('RPerl::DataStructure', 'RPerl::DataType::Modifier::Reference');
use RPerl::DataStructure;

# must include here because we do not inherit data types
use RPerl::DataType::Integer;
use RPerl::DataType::String;
use RPerl::DataType::Unknown;
use RPerl::CodeBlock::Subroutine::Method;

our %properties =
(
	data => my unknown $KEY_data = undef,
	next => my RPerl::DataStructure::LinkedList::NodeReference $KEY_next = undef
);

our string__method $DUMPER = sub {(my RPerl::DataStructure::LinkedList::NodeReference $node) = @_;
;
	my string $dumped = '[';
	my integer $is_first = 1;
	
	while (defined($node))
	{
		if ($is_first) { $is_first = 0; }
		else { $dumped .= ', '; }
		# TODO: handle non-scalar linked list elements
		$dumped .= $node->{data};
		$node = $node->{next};
	}
	
	$dumped .= ']';
	return $dumped;
};

# ref to (linked list node)
# DEV NOTE: for naming conventions, see DEV NOTE in same code section of LinkedList.pm
package linkedlistnode_ref;
our @ISA = ('RPerl::DataStructure::LinkedList::NodeReference');
use RPerl::DataStructure::LinkedList::Node;
our %properties = %properties;
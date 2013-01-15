package RPerl::DataStructure::LinkedList::NodeReference;
use strict;  use warnings;
our @ISA = ('RPerl::DataStructure', 'RPerl::DataType::Reference');
use RPerl::DataStructure;
use RPerl::DataType::Reference;

our %properties =
(
	data => my unknown $KEY_data = undef,
	next => my RPerl::DataStructure::LinkedList::NodeReference $KEY_next = undef
);

our string $DUMPER = sub {(my RPerl::DataStructure::LinkedList::NodeReference $node) = @_;
;
	my string $dumped = '[';
	my int $is_first = 1;
	
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


# we only provide data structure references, not the direct data structures themselves,
# because an RPerl::Class is a blessed hash _reference_, and we are not natively implementing the data structures in C here;
# thus the slightly weird naming convention where some places have delimeters (:: or _) and some don't,
# I favored the consistency of user-side RPerl data type short-form package alias _ delimeter over the Perl system-side package name scope :: delimeter 
package linkedlistnode_ref;
our @ISA = ('RPerl::DataStructure::LinkedList::NodeReference');
use RPerl::DataStructure::LinkedList::NodeReference;
our %properties = %properties;
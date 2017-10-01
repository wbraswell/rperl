package RPerl::DataStructure::LinkedList::Node;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_100;

package RPerl::DataStructure::LinkedList::NodeReference;
#use parent qw(RPerl::DataStructure RPerl::DataType::Modifier::Reference);  # NEED UPGRADE, CORRELATION #rp023: Inline::CPP support for multiple inheritance
use parent qw(RPerl::DataType::Modifier::Reference);
#use RPerl::DataStructure;
use RPerl::DataType::Modifier::Reference;

# must include here because we do not inherit data types
use RPerl::DataType::Integer;
use RPerl::DataType::String;
use RPerl::DataType::Unknown;
use RPerl::CodeBlock::Subroutine::Method;

our hashref $properties =
{
	data => my unknown $TYPED_data = undef,
	next => my RPerl::DataStructure::LinkedList::NodeReference $TYPED_next = undef
};

sub DUMPER {
    { my string::method $RETURN_TYPE };
    (my RPerl::DataStructure::LinkedList::NodeReference $node) = @ARG;
	my string $dumped = '[';
	my integer $is_first = 1;
	
	while (defined($node))
	{
		if ($is_first) { $is_first = 0; }
		else { $dumped .= ', '; }
		# TODO: handle non-scalartype linked list elements
		$dumped .= $node->{data};
		$node = $node->{next};
	}
	
	$dumped .= ']';
    return $dumped;
}

# ref to (linked list node)
# DEV NOTE: for naming conventions, see DEV NOTE in same code section of LinkedList.pm
package  # hide from PAUSE indexing
    linkedlistnoderef;
use parent qw(RPerl::DataStructure::LinkedList::NodeReference);
use RPerl::DataStructure::LinkedList::Node;
our $properties = $properties;

1;  # end of class

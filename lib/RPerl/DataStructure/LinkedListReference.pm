package RPerl::DataStructure::LinkedListReference;
use strict; use warnings;

# derivative types need to access our anonymous-method-holding variables
our @ISA = ('RPerl::DataStructure', 'RPerl::DataType::Reference');

use RPerl::DataStructure;
use RPerl::DataType::Reference;

# linked lists are comprised of nodes
use RPerl::DataStructure::LinkedList::NodeReference;

our %properties =
(
	head => my RPerl::DataStructure::LinkedList::NodeReference $KEY_head = undef,  # start with head = undef so we can test for empty list
);

our RPerl::DataStructure::LinkedListReference $new_from_array_ref = sub {(my string $class, my const_array_ref $input) = @_;
;
	print "in new_from_array_ref(), received \$class = '$class', and \$input =\n" . RPerl::DUMPER($input) . "\n" if $RPerl::DEBUG;
	my unknown $output = $class->new();
	my int $i;
	for ($i = (scalar(@{$input}) - 1); $i >= 0; $i--)
	{
		linkedlist_unshift($output, $input->[$i]);
	}
	return $output;
};

# do not name just "unshift" to avoid confusion with Perl builtin
our void $linkedlist_unshift = sub {(my RPerl::DataStructure::LinkedListReference $list, my unknown $element) = @_; 
;
	my RPerl::DataStructure::LinkedList::NodeReference $new_node = RPerl::DataStructure::LinkedList::NodeReference->new();
	$new_node->{data} = $element;
	$new_node->{next} = $list->{head};
	$list->{head} = $new_node;
};

our string $DUMPER = sub {(my RPerl::DataStructure::LinkedListReference $data) = @_;
;
	my string $dumped = '[';
	my RPerl::DataStructure::LinkedList::NodeReference $node = $data->{head};
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
package linkedlist_ref;
our @ISA = ('RPerl::DataStructure::LinkedListReference');
use RPerl::DataStructure::LinkedListReference;
our %properties = %properties; our $new_from_array_ref = $new_from_array_ref; our $linkedlist_unshift = $linkedlist_unshift; our $DUMPER = $DUMPER;

package scalar_linkedlist_ref;
our @ISA = ('RPerl::DataStructure::LinkedListReference');
use RPerl::DataStructure::LinkedListReference;
our %properties = %properties; our $new_from_array_ref = $new_from_array_ref; our $linkedlist_unshift = $linkedlist_unshift; our $DUMPER = $DUMPER;


package const_linkedlist_ref;
our @ISA = ('RPerl::DataStructure::LinkedListReference', 'RPerl::DataType::Constant');
use RPerl::DataStructure::LinkedListReference;
use RPerl::DataType::Constant;
our %properties = %properties; our $new_from_array_ref = $new_from_array_ref; our $linkedlist_unshift = $linkedlist_unshift; our $DUMPER = $DUMPER;


package const_scalar_linkedlist_ref;
our @ISA = ('RPerl::DataStructure::LinkedListReference', 'RPerl::DataType::Constant');
use RPerl::DataStructure::LinkedListReference;
use RPerl::DataType::Constant;
our %properties = %properties; our $new_from_array_ref = $new_from_array_ref; our $linkedlist_unshift = $linkedlist_unshift; our $DUMPER = $DUMPER;
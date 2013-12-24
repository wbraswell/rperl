use strict;  use warnings;
package RPerl::DataStructure::LinkedList;

# NEED FIX: this is also a valid RPerl Class, but we can't inherit from RPerl::Class due to circular references?
use RPerl::DataStructure::Array;

package RPerl::DataStructure::LinkedListReference;
# NEED ADDRESS: which inheritance???
our @ISA = ('RPerl::DataStructure', 'RPerl::DataType::Modifier::Reference');
#our @ISA = ('RPerl::DataType::Modifier::Reference');
use RPerl::DataStructure;

# linked lists are comprised of nodes
use RPerl::DataStructure::LinkedList::Node;

our %properties =
(
	head => my RPerl::DataStructure::LinkedList::NodeReference $KEY_head = undef,  # start with head = undef so we can test for empty list
);

our RPerl::DataStructure::LinkedListReference $new_from_array_ref = sub {(my string $class, my const_array_ref $input) = @_;
;
#	print STDERR "in new_from_array_ref(), received \$class = '$class', and \$input =\n" . RPerl::DUMPER($input) . "\n" if $RPerl::DEBUG;
	my unknown $output = $class->new();
	my integer $i;
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

our string__method $DUMPER = sub {(my RPerl::DataStructure::LinkedListReference $data) = @_; return $data->{head}->DUMPER(); };


# [[[ LINKED LISTS ]]]

# ref to linked list
# DEV NOTE: we only provide data structure references, not the direct data structures themselves,
# because an RPerl::Class is a blessed hash _reference_, and we are not natively implementing the data structures in C here;
# thus the slightly weird naming convention where some places have delimeters (:: or _) and some don't,
# I favored the consistency of user-side RPerl data type short-form package alias _ delimeter over the Perl system-side package name scope :: delimeter 
package linkedlist_ref;
our @ISA = ('RPerl::DataStructure::LinkedListReference');
use RPerl::DataStructure::LinkedList;
# TODO: check if these (and other) symbol copies can be shortened???   move integer import() subroutine to be automatically called by 'use' command?
our %properties = %properties; our $new_from_array_ref = $new_from_array_ref; our $linkedlist_unshift = $linkedlist_unshift; our $DUMPER = $DUMPER;

# ref to linked list with const size
package const_linkedlist_ref;
our @ISA = ('ref');


# [[[ INT LINKED LISTS ]]]

# (ref to linked list) of integers
package integer__linkedlist_ref;
our @ISA = ('linkedlist_ref');

# (ref to linked list with const size) of integers
package integer__const_linkedlist_ref;
our @ISA = ('const_linkedlist_ref');

# NEED ADD: remaining sub-types

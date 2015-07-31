package RPerl::DataStructure::LinkedList;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# NEED FIX: this is also a valid RPerl Class, but we can't inherit from RPerl::CompileUnit::Module::Class due to circular references?
use RPerl::DataStructure::Array;

package RPerl::DataStructure::LinkedListReference;
use parent qw(RPerl::DataType::Modifier::Reference);
use RPerl::DataType::Modifier::Reference;

# linked lists are comprised of nodes
use RPerl::DataStructure::LinkedList::Node;

our hashref $properties =
{
	head => my RPerl::DataStructure::LinkedList::NodeReference $TYPED_head = undef,  # start with head = undef so we can test for empty list
};

our RPerl::DataStructure::LinkedListReference $new_from_arrayref = sub {(my string $class, my arrayref $input) = @_;
#	RPerl::diag("in new_from_arrayref(), received \$class = '$class', and \$input =\n" . RPerl::DUMPER($input) . "\n");
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
	my RPerl::DataStructure::LinkedList::NodeReference $new_node = RPerl::DataStructure::LinkedList::NodeReference->new();
	$new_node->{data} = $element;
	$new_node->{next} = $list->{head};
	$list->{head} = $new_node;
};

our string::method $DUMPER = sub {(my RPerl::DataStructure::LinkedListReference $data) = @_; return $data->{head}->DUMPER(); };


# [[[ LINKED LISTS ]]]

# ref to linked list
# DEV NOTE: we only provide data structure references, not the direct data structures themselves,
# because an RPerl::CompileUnit::Module::Class is a blessed hash _reference_, and we are not natively implementing the data structures in C here;
# thus the slightly weird naming convention where some places have delimeters (:: or _) and some don't,
# I favored the consistency of user-side RPerl data type short-form package alias _ delimeter over the Perl system-side package name scope :: delimeter 
package  # hide from PAUSE indexing
    linkedlistref;
use parent qw(RPerl::DataStructure::LinkedListReference);
use RPerl::DataStructure::LinkedList;
# TODO: check if these (and other) symbol copies can be shortened???   move integer import() subroutine to be automatically called by 'use' command?
our $properties = $properties; our $new_from_arrayref = $new_from_arrayref; our $linkedlist_unshift = $linkedlist_unshift; our $DUMPER = $DUMPER;

# [[[ INT LINKED LISTS ]]]

# (ref to linked list) of integers
package  # hide from PAUSE indexing
    integer_linkedlistref;
use parent qw(linkedlistref);

# NEED ADD: remaining sub-types

1;  # end of class
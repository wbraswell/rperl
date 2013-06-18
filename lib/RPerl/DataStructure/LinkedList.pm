package RPerl::DataStructure::LinkedList;
use strict; use warnings;

package RPerl::DataStructure::LinkedListReference;
our @ISA = ('RPerl::DataStructure', 'RPerl::DataType::Reference');
use RPerl::DataStructure;
use RPerl::DataType::Reference;

# linked lists are comprised of nodes
use RPerl::DataStructure::LinkedList::Node;

our %properties =
(
	head => my RPerl::DataStructure::LinkedList::NodeReference $KEY_head = undef,  # start with head = undef so we can test for empty list
);

our RPerl::DataStructure::LinkedListReference $new_from_array_ref = sub {(my string $class, my const_array_ref $input) = @_;
;
#	print "in new_from_array_ref(), received \$class = '$class', and \$input =\n" . RPerl::DUMPER($input) . "\n" if $RPerl::DEBUG;
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

our string $DUMPER = sub {(my RPerl::DataStructure::LinkedListReference $data) = @_; return $data->{head}->DUMPER(); };


# we only provide data structure references, not the direct data structures themselves,
# because an RPerl::Class is a blessed hash _reference_, and we are not natively implementing the data structures in C here;
# thus the slightly weird naming convention where some places have delimeters (:: or _) and some don't,
# I favored the consistency of user-side RPerl data type short-form package alias _ delimeter over the Perl system-side package name scope :: delimeter 
package linkedlist_ref;
our @ISA = ('RPerl::DataStructure::LinkedListReference');
use RPerl::DataStructure::LinkedList;
# TODO: check if these (and other) symbol copies can be shortened???   move into import() subroutine to be automatically called by 'use' command?
our %properties = %properties; our $new_from_array_ref = $new_from_array_ref; our $linkedlist_unshift = $linkedlist_unshift; our $DUMPER = $DUMPER;


package scalar_linkedlist_ref;
our @ISA = ('linkedlist_ref');
use RPerl::DataStructure::LinkedList;
our %properties = %properties; our $new_from_array_ref = $new_from_array_ref; our $linkedlist_unshift = $linkedlist_unshift; our $DUMPER = $DUMPER;


package const__linkedlist_ref;
our @ISA = ('linkedlist_ref', 'const');
use RPerl::DataStructure::LinkedList;
use RPerl::DataType::Constant;
our %properties = %properties; our $new_from_array_ref = $new_from_array_ref; our $linkedlist_unshift = $linkedlist_unshift; our $DUMPER = $DUMPER;


package const__scalar_linkedlist_ref;
our @ISA = ('scalar_linkedlist_ref', 'const');
use RPerl::DataStructure::LinkedList;
use RPerl::DataType::Constant;
our %properties = %properties; our $new_from_array_ref = $new_from_array_ref; our $linkedlist_unshift = $linkedlist_unshift; our $DUMPER = $DUMPER;


package linkedlist_ref__method;
our @ISA = ('method');


package scalar_linkedlist_ref__method;
our @ISA = ('method');



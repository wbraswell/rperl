#!/usr/bin/perl
# NEED FIX, OUTDATED
# NEED FIX, OUTDATED
# NEED FIX, OUTDATED
use strict;
use warnings;
use RPerl::AfterFilter;

# supported algorithms
#use RPerl::Algorithm::Graph::Tree::FOOBAZ;

# <<<=== TREE 1 ===>>>
# <<<=== TREE 1 ===>>>
# <<<=== TREE 1 ===>>>

my $nested_arrayrefs_chars = ['F', [['B', ['A', ['D', ['C', 'E']]]], ['G', [undef, ['I', ['H', undef]]]]]];

RPerl::diag("in multi_tree.pl, have \$nested_arrayrefs_chars =\n" . RPerl::DUMPER($nested_arrayrefs_chars) . "\n");

my scalartype_binarytreeref $tree = scalar_binarytreeref->new_from_nested_arrayrefs($nested_arrayrefs_chars);
#my scalartype_binarytreeref $tree = scalar_binarytreeref->new_from_nested_arrayrefs([2112, [[33, [17, 71]], [44, [23, [1.21, [undef, 55]]]]]]);
=UNUSED CODE
my scalartype_binarytreeref $tree = scalar_binarytreeref->new_from_nested_arrayrefs(
[2112, 
	[[33, 
		[17, 
		 71]], 
	 [44, 
	 	[23, 
	 	[1.21, 
	 		[undef, 
	 		 55]]]]]]);
=cut	 		 
=TREE DIAGRAM
					2112
			33				44
		17		71		23		1.21
							undef	55
=cut

RPerl::diag("in multi_tree.pl, have \$tree =\n" . RPerl::DUMPER($tree) . "\n");

our string $callback_value = sub {(my binarytreenoderef $node) = @_;
;
	return $node if (ref(\$node) eq 'SCALAR');
	return $node->{data};
};

my $retval_depthfirst_preorder = $tree->traverse_depthfirst_preorder($callback_value);
RPerl::diag("in multi_tree.pl, have \$retval_depthfirst_preorder =\n" . RPerl::DUMPER($retval_depthfirst_preorder) . "\n");

my $retval_breadthfirst_queue = $tree->traverse_breadthfirst_queue($callback_value);
RPerl::diag("in multi_tree.pl, have \$retval_breadthfirst_queue =\n" . RPerl::DUMPER($retval_breadthfirst_queue) . "\n");

my $retval_nested_arrayrefs = $tree->to_nested_arrayrefs();
RPerl::diag("in multi_tree.pl, have \$retval_nested_arrayrefs =\n" . RPerl::DUMPER($retval_nested_arrayrefs) . "\n");




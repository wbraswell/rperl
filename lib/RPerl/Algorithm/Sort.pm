package RPerl::Algorithm::Sort;
use strict;  use warnings;

our @ISA = ('RPerl::Algorithm');
use RPerl::Algorithm;

our %properties =
(
	data_scalar_array_ref => undef
);

# TODO: CHECK IF THIS METHOD EVEN WORKS
# call out to run the algorithm
sub run_void { my $self_obj = shift;  $self_obj->sort_void(); }

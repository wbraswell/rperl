package RPerl::Algorithm::Sort;
use strict;  use warnings;

our @ISA = ('RPerl::Algorithm');
use RPerl::Algorithm;

# TODO: CHECK IF THIS METHOD EVEN WORKS
# call out to run the algorithm
our void $run = sub { (my object $self) = @_;  $self->sort_method(); }

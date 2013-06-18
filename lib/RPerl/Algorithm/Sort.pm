package RPerl::Algorithm::Sort;
use strict;  use warnings;

our @ISA = ('RPerl::Algorithm');
use RPerl::Algorithm;

# START HERE: test new method types, get inheritance working in C++

our void__method $inherited_method = sub { (my object $self, my string $person) = @_;  print "[[[ HOWDY $person FROM INSIDE inherited_method()!!! ]]]\n"; };

#print "WAZZUP FROM Sort.pm\n";
#inherited_method('FAKESELF', "Spidey");
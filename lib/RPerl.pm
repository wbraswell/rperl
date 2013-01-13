package RPerl;
use strict;  use warnings;
our @ISA = ('RPerl::Class');
use RPerl::Class;

# <<<=== DECREASE MAGIC ===>>>

#no magic;  # require data types, full declarations, other non-magic
#use types;  # circular dependency causes "subroutine DUMPER redefined" error, solved by replacing use with require below
require types;


# <<<=== PSEUDO-EXPORTED VARIABLES AND FUNCTIONS ===>>>

our $DEBUG = 1;

# TODO: replace Data::Dumper with pure-RPerl equivalent?
use Data::Dumper;
sub DUMPER
{
	# TODO: handle any data structure that has its own DUMPER() method, not just linked lists
	return $_[0]->DUMPER() if ((ref($_[0] eq 'RPerl::DataStructure::LinkedListReference')) or (ref($_[0]) =~ m/_linkedlist_/));
	return Dumper(@_);
}


# <<<=== INCREASE RUNTIME PERFORMANCE ===>>>

# parse

# compile

# parallelize
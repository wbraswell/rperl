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
#	die ('in RPerl::DUMPER(), received undef argument, dying') if (not(defined($_[0])));
	return '**UNDEF**' if (not(defined($_[0])));
	return $_[0]->DUMPER() if (defined(eval('$' . ref($_[0]) . '::DUMPER')));  ## no critic
	return Dumper(@_);
}


# <<<=== INCREASE RUNTIME PERFORMANCE ===>>>

# parse

# compile

# parallelize
package RPerl;
use strict;
use warnings;
use version; our $VERSION = 0.003_002;
use parent ('RPerl::Class');
use RPerl::Class;
use Carp;

# IMPORTANT SYSTEM-DEPENDENT CONFIGURATION VARIABLE!  drivers must set this to the path to RPerl
our $INCLUDE_PATH = 'lib';

# <<<=== DECREASE MAGIC ===>>>

#no magic;  # require data types, full declarations, other non-magic
#use rperltypes;  # circular dependency causes "subroutine DUMPER redefined" error, solved by replacing use with require below
require rperltypes;

# <<<=== PSEUDO-EXPORTED VARIABLES AND FUNCTIONS ===>>>

our $DEBUG = 1;

=disable
# TODO: replace Data::Dumper with pure-RPerl equivalent?
use Data::Dumper;
sub DUMPER
{
#	die ('in RPerl::DUMPER(), received undef argument, dying') if (not(defined($_[0])));
	return '**UNDEF**' if (not(defined($_[0])));
	return $_[0]->DUMPER() if (defined(eval('$' . ref($_[0]) . '::DUMPER')));  ## no critic
	return Dumper(@_);
}
=cut

# <<<=== INCREASE RUNTIME PERFORMANCE ===>>>

# parse

# compile

# parallelize

1;

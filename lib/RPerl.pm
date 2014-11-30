# [[[ HEADER ]]]
package RPerl;
use strict;
use warnings;
our $VERSION = 1.000_000;  # BETA!!!

# [[[ INCLUDES ]]]
require RPerl::Config;

# <<<=== DECREASE MAGIC ===>>>

#no magic;  # require data types, full declarations, other non-magic
#use rperltypes;  # circular dependency causes "subroutine DUMPER redefined" error, solved by replacing use with require below
require rperltypes;

# <<<=== EXPORTED FUNCTIONS ===>>>

# TODO: replace Data::Dumper with pure-RPerl equivalent?
#=disable
sub DUMPER
{
#	die ('in RPerl::DUMPER(), received undef argument, dying') if (not(defined($_[0])));
	return '**UNDEF**' if (not(defined($_[0])));
	return $_[0]->DUMPER() if (defined(eval('$' . ref($_[0]) . '::DUMPER')));
	return Dumper(@_);
}
#=cut

sub diag {
#  print {*STDERR} @_ if $ENV{TEST_VERBOSE};
  if ($ENV{TEST_VERBOSE} or $RPerl::DEBUG) {
      print {*STDERR} @_;
  }
  1;
}

# <<<=== EXPORTED DATA ===>>>

our $DEBUG = 0;  # Perl variable $RPerl::DEBUG and environmental variable TEST_VERBOSE are equivalent, see diag() above

# <<<=== INCREASE RUNTIME PERFORMANCE ===>>>

# parse

# compile

# parallelize

1;

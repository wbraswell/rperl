use strict;  use warnings;
package RPerl::Code::Subroutine;

our @ISA = ('RPerl::Code');
use RPerl::Code;

# DEV NOTE: sub is already a keyword in Perl, don't need to actually do anything special
# non-method subroutines simply omit "__method" from the end of their return type
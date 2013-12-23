use strict;  use warnings;
package RPerl::Code::Subroutine;

our @ISA = ('RPerl::Code');
use RPerl::Code;

# DEV NOTE: sub is already a keyword in Perl, don't need to actually do anything special
# non-method subroutines simply omit "__method" from the end of their return type



# Random note for later from mst:  sprint/summer 2012
#   This would warn BUT "no warnings 'illegalproto'" disables that
#   Now you can extract the prototype at runtime using 'perldoc -f prototype'
#   Key thing: whitespace in the prototype is lost so you'll be parsing 'integer__array_ref->integer__array_ref'
#   however it's otherwise preserved verbatim by the perl compiler and you can do what you like with it
#   Web::Simple uses this to provide 'sub (GET + /user/:id) { ... }' for web routing.
#   sub bubblesort(integer__array_ref -> integer__array_ref) {}
# end random note
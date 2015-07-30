# [[[ HEADER ]]]
package RPerl::Operation;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.000_010;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use rperloperations;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    type      => my string $TYPED_type                 = undef,
    name      => my string $TYPED_name                 = undef,
    arguments => my object_arrayref $TYPED_arguments = undef,
};

1;  # end of class

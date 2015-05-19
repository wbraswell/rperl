package RPerl::Operation;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_010;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
use rperloperations;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    type      => my string $TYPED_type                 = undef,
    name      => my string $TYPED_name                 = undef,
    arguments => my object_arrayref $TYPED_arguments = undef,
};

# [[[ OO METHODS ]]]

1;

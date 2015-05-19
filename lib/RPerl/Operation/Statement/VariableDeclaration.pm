package RPerl::Operation::Statement::VariableDeclaration;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_020;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    type  => my string $TYPED_type  = undef,
    name  => my string $TYPED_name  = undef,
    value => my object $TYPED_value = undef,
};

# [[[ OO METHODS ]]]

1;

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::MethodArguments::Class_00_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

# [[[ SUBROUTINES & OO METHODS ]]]
our void::method $empty_method = sub {
    ( my object $self ) = @ARG;
    return 2;
};

1;    # end of class

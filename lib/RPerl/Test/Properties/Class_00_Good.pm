# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Properties::Class_00_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { test_property => my integer $TYPED_test_property = 2 };

# [[[ SUBROUTINES & OO METHODS ]]]
sub test_method {
    { my void::method $RETURN_TYPE };
    ( my object $self, my integer $input_integer ) = @ARG;
    $self->{test_property} *= $input_integer;
    return $self->{test_property};
}

1;    # end of class

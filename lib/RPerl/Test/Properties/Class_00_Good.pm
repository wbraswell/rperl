# [[[ HEADER ]]]
package RPerl::Test::Properties::Class_00_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { test_property => my integer $TYPED_test_property = 2 };

# [[[ OO METHODS & SUBROUTINES ]]]
our void_method $test_method = sub {
    ( my object $self, my integer $input_integer) = @_;
    $self->{test_property} *= $input_integer;
    return $self->{test_property};
};

1;    # end of class

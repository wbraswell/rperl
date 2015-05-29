# [[[ HEADER ]]]
package RPerl::Test::OperatorVoid01NamedVoid::Class_00_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]
our void_method $foo = sub {
    return;
};

1;    # end of class

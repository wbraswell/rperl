# [[[ HEADER ]]]
package RPerl::Test::MethodArguments::Class_03_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our hash_ref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

# [[[ OO METHODS ]]]
our void__method $empty_method = sub {
    (   my object $self,
        my number $foo,
        my string $bar,
        my scalartype__array_ref $baz,
        my integer__hash_ref $bat
    ) = @_;
    return 2;
};

1;    # end of class

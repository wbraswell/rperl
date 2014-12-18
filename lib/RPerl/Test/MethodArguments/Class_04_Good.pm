# [[[ HEADER ]]]
package RPerl::Test::MethodArguments::Class_04_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    empty_property => my integer $TYPED_empty_property = 2
);

# [[[ OO METHODS ]]]
our void__method $empty_method = sub {
    ( my string $class, my number $foo, my number__array_ref $bar, my number__hash_ref $baz ) = @_;
    return 2;
};

1;                  # end of class

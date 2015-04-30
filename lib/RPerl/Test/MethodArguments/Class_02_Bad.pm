# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected Token:  object' >>>

# [[[ HEADER ]]]
package RPerl::Test::MethodArguments::Class_02_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

# [[[ OO METHODS ]]]
our void_method $empty_method = sub {
    (   my object $sel,
        my number $foo,
        my number_arrayref $bar,
        my number_hashref $baz
    ) = @_;
    return 2;
};

1;    # end of class

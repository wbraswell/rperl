# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  $sel' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::MethodArguments::Class_02_Bad;
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
sub empty_method {
    { my void::method $RETURN_TYPE };
    (   my object $sel,
        my number $foo,
        my number_arrayref $bar,
        my number_hashref $baz
    ) = @ARG;
    return 2;
}

1;    # end of class

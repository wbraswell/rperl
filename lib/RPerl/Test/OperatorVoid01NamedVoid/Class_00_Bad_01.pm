# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: 'FOO' >>>

# [[[ HEADER ]]]
package RPerl::Test::OperatorVoid01NamedVoid::Class_00_Bad_00;
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
our void_method $foo = sub { return 2, 3, 4; };

1;    # end of class

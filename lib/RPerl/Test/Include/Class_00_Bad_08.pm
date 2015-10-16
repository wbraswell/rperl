# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  use' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Include::Class_00_Bad_08;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

use RPerl::Test::Bar;

# [[[ OO METHODS & SUBROUTINES ]]]
our integer::method $empty_method = sub {
    return 2;
};

1;                  # end of class

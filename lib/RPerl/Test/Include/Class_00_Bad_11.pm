# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  use' >>>

# [[[ HEADER ]]]
package RPerl::Test::Include::Class_00_Bad_11;
use strict;
use RPerl::Test::Foo;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ INCLUDES ]]]
use RPerl::Test::Bar;

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

# [[[ OO METHODS & SUBROUTINES ]]]
our void_method $empty_method = sub { return 2; };

1;                  # end of class

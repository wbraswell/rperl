# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: '"use" not allowed in expression' >>>
# <<< PARSE_ERROR: 'syntax error' >>>
# <<< PARSE_ERROR: 'near "foo' >>>

foo
# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Header::Class_00_Bad_PreHeader;
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
sub empty_method { { my void::method $RETURN_TYPE }; return 2; }

1;                  # end of class

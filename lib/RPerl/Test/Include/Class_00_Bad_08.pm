# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected token:  use' >>>

# [[[ HEADER ]]]
package RPerl::Test::Include::Class_00_Bad_08;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;

# [[[ OO PROPERTIES ]]]
our hash_ref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

use RPerl::Test::Bar;

# [[[ OO METHODS ]]]
our void__method $empty_method = sub { return 2; };

1;                  # end of class

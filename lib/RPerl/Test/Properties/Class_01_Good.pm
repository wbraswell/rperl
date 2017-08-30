# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Properties::Class_01_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our hashref $properties = { 
    foo => my integer $TYPED_foo = 2,
    bar => my integer $TYPED_bar = 3
};

1;    # end of class

# [[[ HEADER ]]]
package RPerl::Test::Module::Class_00_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO OBJECT PROPERTIES ]]]
our hash_ref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

# [[[ OO CLASS PROPERTIES ]]]
our hash_ref $class_properties
    = { empty_class_property => my string $TYPED_empty_class_property
        = 'howdy' };

# [[[ OO METHODS ]]]
our void__method $empty_method = sub { return 2; };

1;    # end of class

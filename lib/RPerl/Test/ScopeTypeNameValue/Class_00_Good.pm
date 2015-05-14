# [[[ HEADER ]]]
package RPerl::Test::ScopeTypeNameValue::Class_00_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { some_integer => my integer $TYPED_empty_property = 23 };

# [[[ OO METHODS ]]]
our string_method $properties_stnv = sub {
    return main::scope_type_name_value($properties);
};

1;    # end of class

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Properties::Class_20_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# DEV NOTE, CORRELATION #rp054: auto-generation of OO property accessors/mutators checks the auto-generated RPerl type list for base data types to determine if the entire data structure can be returned by setting ($return_whole = 1)

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    # no initial size, no initial values 
    test_property => my integer_hashref $TYPED_test_property = undef
};

# [[[ SUBROUTINES & OO METHODS ]]]
sub test_method {
    { my integer_hashref::method $RETURN_TYPE };
    ( my object $self, my integer $input_integer ) = @ARG;
    my integer_hashref $test_property_shortcut = $self->get_test_property();
    $test_property_shortcut->{a} *= $input_integer;
    return $self->{test_property};
}

1;    # end of class

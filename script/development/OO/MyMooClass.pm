# [[[ HEADER ]]]
package MyMooClass;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
#extends 'MyMooClassParent';

# [[[ INCLUDES ]]]
use Moo;

# [[[ OO PROPERTIES ]]]
sub integer { return sub { shift =~/\A-?[0-9]+\z/ }; }  # NEED REMOVE, SHOULD BE PROVIDED BY 'use Types;'???
has 'bar' => (is => 'ro', required => 1, isa => integer);

# [[[ SUBROUTINES & OO METHODS ]]]

# START HERE: how to do methods below in Moo(se)???
# START HERE: how to do methods below in Moo(se)???
# START HERE: how to do methods below in Moo(se)???

sub double_bar_save {
    ( my MyRMooClass $self ) = @ARG;
    $self->{bar} = $self->{bar} * 2;
}

sub double_bar_return {
    ( my MyRMooClass $self ) = @ARG;
    return my integer $retval = $self->{bar} * 2;
}
1;

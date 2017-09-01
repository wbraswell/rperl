# [[[ HEADER ]]]

package MyMooClass;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use Moo;
#extends 'MyMooClassParent';






# [[[ OO PROPERTIES ]]]
sub integer { return sub { shift =~ /\A-?[0-9]+\z/ or die; }; }  # NEED REMOVE, SHOULD BE PROVIDED BY 'use Types;'???
has 'bar' => (is => 'ro', required => 1, isa => integer);

# [[[ SUBROUTINES & OO METHODS ]]]

sub double_bar_save {

    my $self = shift;
    $self->{bar} = $self->{bar} * 2;
}

sub double_bar_return {

    my $self = shift;
    return $self->{bar} * 2;
}

1;    # end of class


# [[[ HEADER ]]]

package MyMooSubclass;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use Moo;
extends 'MyMooClass';






# [[[ OO PROPERTIES ]]]
sub integer { return sub { shift =~ /\A-?[0-9]+\z/ or die; }; }  # NEED REMOVE, SHOULD BE IN DataTypes/Integer.pm
has 'bax' => (is => 'ro', required => 1, isa => integer);

# [[[ SUBROUTINES & OO METHODS ]]]

sub triple_bax_save {

    my $self = shift;
    $self->{bax} = $self->{bax} * 3;
}

sub triple_bax_return {

    my $self = shift;
    return $self->{bax} * 3;
}

sub multiply_bax_return {

    my $self = shift;
    my $multiplier = shift;
    if ( $multiplier < 10 ) {
        return $self->{bax} * $multiplier;
    }
    return $self->{bax} * 3;
}

1;    # end of subclass

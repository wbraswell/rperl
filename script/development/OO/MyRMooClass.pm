# [[[ HEADER ]]]
use RPerl;
package MyRMooClass;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
#extends 'MyRMooClassParent';

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use Moo;

# [[[ OO PROPERTIES ]]]
sub integer { return sub { shift =~/\A-?[0-9]+\z/ }; }  # NEED REMOVE, SHOULD BE IN DataTypes/Integer.pm
has 'bar' => (is => 'ro', required => 1, isa => integer);

# [[[ SUBROUTINES & OO METHODS ]]]

sub double_bar_save {
    ( my MyRMooClass $self ) = @ARG;
    $self->{bar} = $self->{bar} * 2;
}

sub double_bar_return {
    ( my MyRMooClass $self ) = @ARG;
    return my integer $retval = $self->{bar} * 2;
}

1;    # end of class


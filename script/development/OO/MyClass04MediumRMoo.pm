# [[[ HEADER ]]]
use RPerl;
package MyClass04MediumRMoo;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use Moo;


# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitMultiplePackages ProhibitReusedNames ProhibitPackageVars)  # USER DEFAULT 8: allow additional packages

# [[[ OO PROPERTIES ]]]
sub integer { return sub { shift =~ /\A-?[0-9]+\z/ or die; }; }    # NEED REMOVE, SHOULD BE IN DataTypes/Integer.pm
has 'bar' => ( is => 'ro', required => 1, isa => integer );

# [[[ SUBROUTINES & OO METHODS ]]]

sub double_bar_save {
    { my void::method $RETURN_TYPE };
    ( my MyClass04MediumRMoo $self ) = @ARG;
    $self->{bar} = $self->{bar} * 2;
}

sub double_bar_return {
    { my integer::method $RETURN_TYPE };
    ( my MyClass04MediumRMoo $self ) = @ARG;
    return my integer $retval = $self->{bar} * 2;
}

1;    # end of class


# [[[ HEADER ]]]
use RPerl;
package MySubclass04MediumRMoo;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use Moo;
extends 'MyClass04MediumRMoo';

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitMultiplePackages ProhibitReusedNames ProhibitPackageVars)  # USER DEFAULT 8: allow additional packages

# [[[ OO PROPERTIES ]]]
sub integer { return sub { shift =~ /\A-?[0-9]+\z/ or die; }; }    # NEED REMOVE, SHOULD BE IN DataTypes/Integer.pm
has 'bax' => ( is => 'ro', required => 1, isa => integer );

# [[[ SUBROUTINES & OO METHODS ]]]

sub triple_bax_save {
    { my void::method $RETURN_TYPE };
    ( my MySubclass04MediumRMoo $self ) = @ARG;
    $self->{bax} = $self->{bax} * 3;
}

sub triple_bax_return {
    { my integer::method $RETURN_TYPE };
    ( my MySubclass04MediumRMoo $self ) = @ARG;
    return $self->{bax} * 3;
}

sub multiply_bax_return {
    { my integer::method $RETURN_TYPE };
    ( my MySubclass04MediumRMoo $self, my integer $multiplier ) = @ARG;

    if ( $multiplier < 10 ) {
        return $self->{bax} * $multiplier;
    }
    return $self->{bax} * 3;
}

1;    # end of subclass

# [[[ HEADER ]]]
use RPerl;

package RPerl::Test::Subclass::MySubclasserA_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT = qw(swings tinker_toys);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = { preschool => my string $TYPED_preschool = 'Busy Beaver' };

# [[[ SUBROUTINES & OO METHODS ]]]

sub building_blocks {
    { my RPerl::Test::Subclass::MySubclasserA_Good::method $RETURN_TYPE };
    ( my RPerl::Test::Subclass::MySubclasserA_Good $self ) = @ARG;
    $self->{preschool} .= '; ABCDEFG';
    my RPerl::Test::Subclass::MySubclasserA_Good $chum = RPerl::Test::Subclass::MySubclasserA_Good->new();
    return $chum;
}

sub finger_paints {
    { my RPerl::Test::Subclass::MySubclasserA_Good_arrayref::method $RETURN_TYPE };
    ( my RPerl::Test::Subclass::MySubclasserA_Good $self ) = @ARG;
    $self->{preschool} .= '; orange yellow red';
    my RPerl::Test::Subclass::MySubclasserA_Good_arrayref $friends
        = [ RPerl::Test::Subclass::MySubclasserA_Good->new(), RPerl::Test::Subclass::MySubclasserA_Good->new(),
        RPerl::Test::Subclass::MySubclasserA_Good->new() ];
    return $friends;
}

sub sand_box {
    { my RPerl::Test::Subclass::MySubclasserA_Good_hashref::method $RETURN_TYPE };
    ( my RPerl::Test::Subclass::MySubclasserA_Good $self ) = @ARG;
    $self->{preschool} .= '; castle';
    my RPerl::Test::Subclass::MySubclasserA_Good_hashref $classmates = {
        'alvin'    => RPerl::Test::Subclass::MySubclasserA_Good->new(),
        'simon'    => RPerl::Test::Subclass::MySubclasserA_Good->new(),
        'theodore' => RPerl::Test::Subclass::MySubclasserA_Good->new()
    };
    return $classmates;
}

sub swings {
    { my RPerl::Test::Subclass::MySubclasserA_Good_arrayref $RETURN_TYPE };
    my RPerl::Test::Subclass::MySubclasserA_Good_arrayref $others
        = [ RPerl::Test::Subclass::MySubclasserA_Good->new(), RPerl::Test::Subclass::MySubclasserA_Good->new() ];
    return $others;
}

sub tinker_toys {
    { my RPerl::Test::Subclass::MySubclasserA_Good_hashref $RETURN_TYPE };
    my RPerl::Test::Subclass::MySubclasserA_Good_hashref $peers
        = { 'chip' => RPerl::Test::Subclass::MySubclasserA_Good->new(), 'dale' => RPerl::Test::Subclass::MySubclasserA_Good->new() };
    return $peers;
}

1;    # end of class

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'No such class RPerl::Test::Subclass::MySubclasserA_Bad_02_hashref::methodd' >>>

# [[[ HEADER ]]]
use RPerl;

package RPerl::Test::Subclass::MySubclasserA_Bad_02;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = { preschool => my string $TYPED_preschool = 'Busy Beaver' };

# [[[ SUBROUTINES & OO METHODS ]]]

sub building_blocks {
    { my RPerl::Test::Subclass::MySubclasserA_Bad_02::method $RETURN_TYPE };
    ( my RPerl::Test::Subclass::MySubclasserA_Bad_02 $self ) = @ARG;
    $self->{preschool} .= '; ABCDEFG';
    my RPerl::Test::Subclass::MySubclasserA_Bad_02 $chum = RPerl::Test::Subclass::MySubclasserA_Bad_02->new();
    return $chum;
}

sub finger_paints {
    { my RPerl::Test::Subclass::MySubclasserA_Bad_02_arrayref::method $RETURN_TYPE };
    ( my RPerl::Test::Subclass::MySubclasserA_Bad_02 $self ) = @ARG;
    $self->{preschool} .= '; orange yellow red';
    my RPerl::Test::Subclass::MySubclasserA_Bad_02_arrayref $friends
        = [ RPerl::Test::Subclass::MySubclasserA_Bad_02->new(), RPerl::Test::Subclass::MySubclasserA_Bad_02->new(),
        RPerl::Test::Subclass::MySubclasserA_Bad_02->new() ];
    return $friends;
}

sub sand_box {
    { my RPerl::Test::Subclass::MySubclasserA_Bad_02_hashref::methodd $RETURN_TYPE };
    ( my RPerl::Test::Subclass::MySubclasserA_Bad_02 $self ) = @ARG;
    $self->{preschool} .= '; castle';
    my RPerl::Test::Subclass::MySubclasserA_Bad_02_hashref $classmates = {
        'alvin'    => RPerl::Test::Subclass::MySubclasserA_Bad_02->new(),
        'simon'    => RPerl::Test::Subclass::MySubclasserA_Bad_02->new(),
        'theodore' => RPerl::Test::Subclass::MySubclasserA_Bad_02->new()
    };
    return $classmates;
}

sub swings {
    { my RPerl::Test::Subclass::MySubclasserA_Bad_02_arrayref $RETURN_TYPE };
    my RPerl::Test::Subclass::MySubclasserA_Bad_02_arrayref $others
        = [ RPerl::Test::Subclass::MySubclasserA_Bad_02->new(), RPerl::Test::Subclass::MySubclasserA_Bad_02->new() ];
    return $others;
}

sub tinker_toys {
    { my RPerl::Test::Subclass::MySubclasserA_Bad_02_hashref $RETURN_TYPE };
    my RPerl::Test::Subclass::MySubclasserA_Bad_02_hashref $peers = {
        'chip' => RPerl::Test::Subclass::MySubclasserA_Bad_02->new(),
        'dale' => RPerl::Test::Subclass::MySubclasserA_Bad_02->new()
    };
    return $peers;
}

1;                     # end of class

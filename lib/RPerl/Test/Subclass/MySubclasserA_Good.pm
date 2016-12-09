# [[[ HEADER ]]]
use RPerl;

package RPerl::Test::Subclass::MySubclasserA_Good;
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

our RPerl::Test::Subclass::MySubclasserA_Good::method $building_blocks = sub {
    ( my RPerl::Test::Subclass::MySubclasserA_Good $self ) = @ARG;
    $self->{preschool} .= '; ABCDEFG';
    my RPerl::Test::Subclass::MySubclasserA_Good $chum = RPerl::Test::Subclass::MySubclasserA_Good->new();
    return $chum;
};

our RPerl::Test::Subclass::MySubclasserA_Good_arrayref::method $finger_paints = sub {
    ( my RPerl::Test::Subclass::MySubclasserA_Good $self ) = @ARG;
    $self->{preschool} .= '; orange yellow red';
    my RPerl::Test::Subclass::MySubclasserA_Good_arrayref $friends
        = [ RPerl::Test::Subclass::MySubclasserA_Good->new(), RPerl::Test::Subclass::MySubclasserA_Good->new(),
        RPerl::Test::Subclass::MySubclasserA_Good->new() ];
    return $friends;
};

our RPerl::Test::Subclass::MySubclasserA_Good_hashref::method $sand_box = sub {
    ( my RPerl::Test::Subclass::MySubclasserA_Good $self ) = @ARG;
    $self->{preschool} .= '; castle';
    my RPerl::Test::Subclass::MySubclasserA_Good_hashref $classmates = {
        'alvin'    => RPerl::Test::Subclass::MySubclasserA_Good->new(),
        'simon'    => RPerl::Test::Subclass::MySubclasserA_Good->new(),
        'theodore' => RPerl::Test::Subclass::MySubclasserA_Good->new()
    };
    return $classmates;
};

our RPerl::Test::Subclass::MySubclasserA_Good_arrayref $swings = sub {
    my RPerl::Test::Subclass::MySubclasserA_Good_arrayref $others
        = [ RPerl::Test::Subclass::MySubclasserA_Good->new(), RPerl::Test::Subclass::MySubclasserA_Good->new() ];
    return $others;
};

our RPerl::Test::Subclass::MySubclasserA_Good_hashref $tinker_toys = sub {
    my RPerl::Test::Subclass::MySubclasserA_Good_hashref $peers
        = { 'chip' => RPerl::Test::Subclass::MySubclasserA_Good->new(), 'dale' => RPerl::Test::Subclass::MySubclasserA_Good->new() };
    return $peers;
};

1;    # end of class

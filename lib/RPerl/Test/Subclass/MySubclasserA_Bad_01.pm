# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'No such class RPerl::Test::Subclass::MySubclasserA_Bad_01_arrayref::methodd' >>>

# [[[ HEADER ]]]
use RPerl;

package RPerl::Test::Subclass::MySubclasserA_Bad_01;
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

# [[[ OO METHODS & SUBROUTINES ]]]

our RPerl::Test::Subclass::MySubclasserA_Bad_01::method $building_blocks = sub {
    ( my RPerl::Test::Subclass::MySubclasserA_Bad_01 $self ) = @_;
    $self->{preschool} .= '; ABCDEFG';
    my RPerl::Test::Subclass::MySubclasserA_Bad_01 $chum = RPerl::Test::Subclass::MySubclasserA_Bad_01->new();
    return $chum;
};

our RPerl::Test::Subclass::MySubclasserA_Bad_01_arrayref::methodd $finger_paints = sub {
    ( my RPerl::Test::Subclass::MySubclasserA_Bad_01 $self ) = @_;
    $self->{preschool} .= '; orange yellow red';
    my RPerl::Test::Subclass::MySubclasserA_Bad_01_arrayref $friends
        = [ RPerl::Test::Subclass::MySubclasserA_Bad_01->new(), RPerl::Test::Subclass::MySubclasserA_Bad_01->new(),
        RPerl::Test::Subclass::MySubclasserA_Bad_01->new() ];
    return $friends;
};

our RPerl::Test::Subclass::MySubclasserA_Bad_01_hashref::method $sand_box = sub {
    ( my RPerl::Test::Subclass::MySubclasserA_Bad_01 $self ) = @_;
    $self->{preschool} .= '; castle';
    my RPerl::Test::Subclass::MySubclasserA_Bad_01_hashref $classmates = {
        'alvin'    => RPerl::Test::Subclass::MySubclasserA_Bad_01->new(),
        'simon'    => RPerl::Test::Subclass::MySubclasserA_Bad_01->new(),
        'theodore' => RPerl::Test::Subclass::MySubclasserA_Bad_01->new()
    };
    return $classmates;
};

our RPerl::Test::Subclass::MySubclasserA_Bad_01_arrayref $swings = sub {
    my RPerl::Test::Subclass::MySubclasserA_Bad_01_arrayref $others
        = [ RPerl::Test::Subclass::MySubclasserA_Bad_01->new(), RPerl::Test::Subclass::MySubclasserA_Bad_01->new() ];
    return $others;
};

our RPerl::Test::Subclass::MySubclasserA_Bad_01_hashref $tinker_toys = sub {
    my RPerl::Test::Subclass::MySubclasserA_Bad_01_hashref $peers = {
        'chip' => RPerl::Test::Subclass::MySubclasserA_Bad_01->new(),
        'dale' => RPerl::Test::Subclass::MySubclasserA_Bad_01->new()
    };
    return $peers;
};

1;                     # end of class

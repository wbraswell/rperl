# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
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

# [[[ OO METHODS & SUBROUTINES ]]]

our RPerl::Test::Subclass::MySubclasserA_Bad_02::method $building_blocks = sub {
    ( my RPerl::Test::Subclass::MySubclasserA_Bad_02 $self ) = @_;
    $self->{preschool} .= '; ABCDEFG';
    my RPerl::Test::Subclass::MySubclasserA_Bad_02 $chum = RPerl::Test::Subclass::MySubclasserA_Bad_02->new();
    return $chum;
};

our RPerl::Test::Subclass::MySubclasserA_Bad_02_arrayref::method $finger_paints = sub {
    ( my RPerl::Test::Subclass::MySubclasserA_Bad_02 $self ) = @_;
    $self->{preschool} .= '; orange yellow red';
    my RPerl::Test::Subclass::MySubclasserA_Bad_02_arrayref $friends
        = [ RPerl::Test::Subclass::MySubclasserA_Bad_02->new(), RPerl::Test::Subclass::MySubclasserA_Bad_02->new(),
        RPerl::Test::Subclass::MySubclasserA_Bad_02->new() ];
    return $friends;
};

our RPerl::Test::Subclass::MySubclasserA_Bad_02_hashref::methodd $sand_box = sub {
    ( my RPerl::Test::Subclass::MySubclasserA_Bad_02 $self ) = @_;
    $self->{preschool} .= '; castle';
    my RPerl::Test::Subclass::MySubclasserA_Bad_02_hashref $classmates = {
        'alvin'    => RPerl::Test::Subclass::MySubclasserA_Bad_02->new(),
        'simon'    => RPerl::Test::Subclass::MySubclasserA_Bad_02->new(),
        'theodore' => RPerl::Test::Subclass::MySubclasserA_Bad_02->new()
    };
    return $classmates;
};

our RPerl::Test::Subclass::MySubclasserA_Bad_02_arrayref $swings = sub {
    my RPerl::Test::Subclass::MySubclasserA_Bad_02_arrayref $others
        = [ RPerl::Test::Subclass::MySubclasserA_Bad_02->new(), RPerl::Test::Subclass::MySubclasserA_Bad_02->new() ];
    return $others;
};

our RPerl::Test::Subclass::MySubclasserA_Bad_02_hashref $tinker_toys = sub {
    my RPerl::Test::Subclass::MySubclasserA_Bad_02_hashref $peers = {
        'chip' => RPerl::Test::Subclass::MySubclasserA_Bad_02->new(),
        'dale' => RPerl::Test::Subclass::MySubclasserA_Bad_02->new()
    };
    return $peers;
};

1;                     # end of class

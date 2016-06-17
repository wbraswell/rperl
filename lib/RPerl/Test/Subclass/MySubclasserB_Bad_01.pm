# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'No such class RPerl::Test::Subclass::MySubclasserA_Good_arrayrefd' >>>

# [[[ HEADER ]]]
use RPerl;

package RPerl::Test::Subclass::MySubclasserB_Bad_01;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test::Subclass::MySubclasserA_Good);
use RPerl::Test::Subclass::MySubclasserA_Good;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = { preschool => my string $TYPED_preschool = 'Eager Muskrat', kindergarten => my string $TYPED_kindergarten = 'Eagle Elementary' };

# [[[ SUBROUTINES & OO METHODS ]]]

our RPerl::Test::Subclass::MySubclasserB_Bad_01::method $alphabet = sub {
    ( my RPerl::Test::Subclass::MySubclasserB_Bad_01 $self ) = @_;
    $self->{kindergarten} .= '; ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    my RPerl::Test::Subclass::MySubclasserA_Good $buddy = RPerl::Test::Subclass::MySubclasserA_Good->new();
    my RPerl::Test::Subclass::MySubclasserB_Bad_01 $chum  = RPerl::Test::Subclass::MySubclasserB_Bad_01->new();
    return $chum;
};

our RPerl::Test::Subclass::MySubclasserB_Bad_01_arrayref::method $brush_paints = sub {
    ( my RPerl::Test::Subclass::MySubclasserB_Bad_01 $self ) = @_;
    $self->{kindergarten} .= '; green blue purple';
    my RPerl::Test::Subclass::MySubclasserB_Bad_01_arrayref $friends
        = [ RPerl::Test::Subclass::MySubclasserB_Bad_01->new(), RPerl::Test::Subclass::MySubclasserB_Bad_01->new(),
        RPerl::Test::Subclass::MySubclasserB_Bad_01->new() ];
    return $friends;
};

our RPerl::Test::Subclass::MySubclasserB_Bad_01_hashref::method $clay = sub {
    ( my RPerl::Test::Subclass::MySubclasserB_Bad_01 $self ) = @_;
    $self->{kindergarten} .= '; bust';
    my RPerl::Test::Subclass::MySubclasserB_Bad_01_hashref $classmates = {
        'huey'  => RPerl::Test::Subclass::MySubclasserB_Bad_01->new(),
        'dewey' => RPerl::Test::Subclass::MySubclasserB_Bad_01->new(),
        'louie' => RPerl::Test::Subclass::MySubclasserB_Bad_01->new()
    };
    return $classmates;
};

our RPerl::Test::Subclass::MySubclasserB_Bad_01_arrayref $seesaw = sub {
    my RPerl::Test::Subclass::MySubclasserA_Good_arrayrefd $strangers
        = [ RPerl::Test::Subclass::MySubclasserA_Good->new(), RPerl::Test::Subclass::MySubclasserA_Good->new() ];
    my RPerl::Test::Subclass::MySubclasserB_Bad_01_arrayref $others
        = [ RPerl::Test::Subclass::MySubclasserB_Bad_01->new(), RPerl::Test::Subclass::MySubclasserB_Bad_01->new() ];
    return $others;
};

our RPerl::Test::Subclass::MySubclasserB_Bad_01_hashref $erector_set = sub {
    my RPerl::Test::Subclass::MySubclasserA_Good_hashref $teachers = {
        'launchpad' => RPerl::Test::Subclass::MySubclasserA_Good->new(),
        'donald'    => RPerl::Test::Subclass::MySubclasserA_Good->new()
    };
    my RPerl::Test::Subclass::MySubclasserB_Bad_01_hashref $peers = { 'webbigail' => RPerl::Test::Subclass::MySubclasserB_Bad_01->new() };
    return $peers;
};

1;    # end of class

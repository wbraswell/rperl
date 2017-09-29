# [[[ HEADER ]]]
use RPerl;

package RPerl::Test::Subclass::MySubclasserB_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test::Subclass::MySubclasserA_Good);
use RPerl::Test::Subclass::MySubclasserA_Good;

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT = qw(swings tinker_toys seesaw erector_set);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = { kindergarten => my string $TYPED_kindergarten = 'Eagle Elementary' };

# [[[ SUBROUTINES & OO METHODS ]]]

sub alphabet {
    { my RPerl::Test::Subclass::MySubclasserB_Good::method $RETURN_TYPE };
    ( my RPerl::Test::Subclass::MySubclasserB_Good $self ) = @ARG;
    $self->{kindergarten} .= '; ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    my RPerl::Test::Subclass::MySubclasserA_Good $buddy = RPerl::Test::Subclass::MySubclasserA_Good->new();
    my RPerl::Test::Subclass::MySubclasserB_Good $chum  = RPerl::Test::Subclass::MySubclasserB_Good->new();
    return $chum;
}

sub brush_paints {
    { my RPerl::Test::Subclass::MySubclasserB_Good_arrayref::method $RETURN_TYPE };
    ( my RPerl::Test::Subclass::MySubclasserB_Good $self ) = @ARG;
    $self->{kindergarten} .= '; green blue purple';
    my RPerl::Test::Subclass::MySubclasserB_Good_arrayref $friends
        = [ RPerl::Test::Subclass::MySubclasserB_Good->new(), RPerl::Test::Subclass::MySubclasserB_Good->new(),
        RPerl::Test::Subclass::MySubclasserB_Good->new() ];
    return $friends;
}

sub clay {
    { my RPerl::Test::Subclass::MySubclasserB_Good_hashref::method $RETURN_TYPE };
    ( my RPerl::Test::Subclass::MySubclasserB_Good $self ) = @ARG;
    $self->{kindergarten} .= '; bust';
    my RPerl::Test::Subclass::MySubclasserB_Good_hashref $classmates = {
        'huey'  => RPerl::Test::Subclass::MySubclasserB_Good->new(),
        'dewey' => RPerl::Test::Subclass::MySubclasserB_Good->new(),
        'louie' => RPerl::Test::Subclass::MySubclasserB_Good->new()
    };
    return $classmates;
}

sub seesaw {
    { my RPerl::Test::Subclass::MySubclasserB_Good_arrayref $RETURN_TYPE };
    my RPerl::Test::Subclass::MySubclasserA_Good_arrayref $strangers
        = [ RPerl::Test::Subclass::MySubclasserA_Good->new(), RPerl::Test::Subclass::MySubclasserA_Good->new() ];
    my RPerl::Test::Subclass::MySubclasserB_Good_arrayref $others
        = [ RPerl::Test::Subclass::MySubclasserB_Good->new(), RPerl::Test::Subclass::MySubclasserB_Good->new() ];
    return $others;
}

sub erector_set {
    { my RPerl::Test::Subclass::MySubclasserB_Good_hashref $RETURN_TYPE };
    my RPerl::Test::Subclass::MySubclasserA_Good_hashref $teachers
        = { 'launchpad' => RPerl::Test::Subclass::MySubclasserA_Good->new(), 'donald' => RPerl::Test::Subclass::MySubclasserA_Good->new() };
    my RPerl::Test::Subclass::MySubclasserB_Good_hashref $peers = { 'webbigail' => RPerl::Test::Subclass::MySubclasserB_Good->new() };
    return $peers;
}

1;    # end of class

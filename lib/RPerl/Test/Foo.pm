# [[[ HEADER ]]]
package RPerl::Test::Foo;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO OBJECT PROPERTIES ]]]
our hash_ref $properties = {
    plugh => my integer $TYPED_plugh           = 23,
    xyzzy => my string $TYPED_xyzzy            = 'twenty-three',
    thud  => my integer__array_ref $TYPED_thud = [ 2, 4, 6, 8 ],
    yyz => my number__hash_ref $TYPED_yyz = { a => 3.1, b => 6.2, c => 9.3 }
};

# [[[ OO OBJECT METHODS ]]]

our void__method $quux = sub {
    ( my object $self) = @_;
    $self->{plugh} = $self->{plugh} * 2;
};

our string__method $corge = sub {
    ( my object $self) = @_;
    return $self->{xyzzy} x 3;
};

# [[[ OO CLASS METHODS ]]]

our void__method $xuuq = sub {
    ( my string $class) = @_;
    print 'Class method xuuq called from class ', $class, "\n";
};

our number__method $egroc = sub {
    ( my string $class, my number $hgulp) = @_;
    return $hgulp * 3;
};

# [[[ SUBROUTINES ]]]

our void $grault = sub {
    ( my integer $grault_input ) = @_;
    print '$grault_input ** PI() = ' . ( $grault_input**PI() ) . "\n";
};

our number__array_ref $garply = sub {
    ( my integer $garply_input ) = @_;
    my number__array_ref $garply_output
        = [ $garply_input * 1.1, $garply_input * 2.2, $garply_input * 3.3 ];
    return $garply_output;
};

1;    # end of class

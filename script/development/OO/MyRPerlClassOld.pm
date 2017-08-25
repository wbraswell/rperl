# [[[ HEADER ]]]
use RPerl;
package MyRPerlClassOld;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    bar => my integer $TYPED_bar = 23,
};

# [[[ SUBROUTINES & OO METHODS ]]]

our void::method $double_bar_save = sub {
    ( my MyRPerlClassOld $self ) = @ARG;
    $self->{bar} = $self->{bar} * 2;
};

our integer::method $double_bar_return = sub {
    ( my MyRPerlClassOld $self ) = @ARG;
    return $self->{bar} * 2;
};

1;    # end of class
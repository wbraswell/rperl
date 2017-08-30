# [[[ HEADER ]]]
use RPerl;
package MyRPerlClassNew;
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

sub double_bar_save {
    ( my MyRPerlClassNew $self ) = @ARG;
    $self->{bar} = $self->{bar} * 2;
}

sub double_bar_return {
    ( my MyRPerlClassNew $self ) = @ARG;
    return my integer $retval = $self->{bar} * 2;
}

1;  # end of class


# [[[ HEADER ]]]
use RPerl;
package MyRPerlSubclassNew;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MyRPerlClassNew);
use MyRPerlClassNew;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    bax => my integer $TYPED_bax = 123,  # NEED FIX: bax should be readonly, need to change into a constant???
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub triple_bax_save {
    ( my MyRPerlSubclassNew $self ) = @ARG;
    $self->{bax} = $self->{bax} * 3;
}

sub triple_bax_return {
    ( my MyRPerlSubclassNew $self ) = @ARG;
    return my integer $retval = $self->{bax} * 3;
}

1;  # end of subclass
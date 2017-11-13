# [[[ HEADER ]]]
use RPerl;
package MyClass01LowRPerlOld;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitMultiplePackages ProhibitReusedNames ProhibitPackageVars)  # USER DEFAULT 8: allow additional packages

# [[[ OO PROPERTIES ]]]

our hashref $properties = { bar => my integer $TYPED_bar = 23 };

# [[[ SUBROUTINES & OO METHODS ]]]

our void::method $double_bar_save = sub {

    ( my MyClass01LowRPerlOld $self ) = @ARG;
    $self->{bar} = $self->{bar} * 2;
    return;
};

our integer::method $double_bar_return = sub {

    ( my MyClass01LowRPerlOld $self ) = @ARG;
    return $self->{bar} * 2;
};

1;    # end of class


# [[[ HEADER ]]]
use RPerl;
package MySubclass01LowRPerlOld;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent -norequire, qw(MyClass01LowRPerlOld);
BEGIN { MyClass01LowRPerlOld->import(); }

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitMultiplePackages ProhibitReusedNames ProhibitPackageVars)  # USER DEFAULT 8: allow additional packages

# [[[ OO PROPERTIES ]]]
our hashref $properties = { bax => my integer $TYPED_bax = 123 };  # NEED FIX: bax should be readonly, need to change into a constant???

# [[[ SUBROUTINES & OO METHODS ]]]

our void::method $triple_bax_save = sub {

    ( my MySubclass01LowRPerlOld $self ) = @ARG;
    $self->{bax} = $self->{bax} * 3;
    return;
};

our integer::method $triple_bax_return = sub {

    ( my MySubclass01LowRPerlOld $self ) = @ARG;
    return $self->{bax} * 3;
};

our integer::method $multiply_bax_return = sub {

    ( my MySubclass01LowRPerlOld $self, my integer $multiplier ) = @ARG;

    if ( $multiplier < 10 ) {
        return $self->{bax} * $multiplier;
    }
    return $self->{bax} * 3;
};

1;    # end of subclass

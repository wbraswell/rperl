# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: ON >>>

# [[[ HEADER ]]]
use RPerl;
package MyClass02LowRPerlNew;
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

sub double_bar_save {
    { my void::method $RETURN_TYPE };
    ( my MyClass02LowRPerlNew $self ) = @ARG;
    $self->{bar} = $self->{bar} * 2;
}

sub double_bar_return {
    { my integer::method $RETURN_TYPE };
    ( my MyClass02LowRPerlNew $self ) = @ARG;
    return $self->{bar} * 2;
}

1;    # end of class


# [[[ HEADER ]]]
use RPerl;
package MySubclass02LowRPerlNew;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
#use parent qw(MyClass02LowRPerlNew);  # WRONG: RELOADS THIS FILE "Subroutine FOO redefined"
use parent -norequire, qw(MyClass02LowRPerlNew);  # CORRECT: EDITS @ISA ONLY
#use MyClass02LowRPerlNew;      # WRONG: RELOADS THIS FILE "Subroutine FOO redefined"
#require MyClass02LowRPerlNew;  # WRONG: DOES NOTHING???
BEGIN { MyClass02LowRPerlNew->import(); }  # CORRECT: IMPORTS ONLY

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitMultiplePackages ProhibitReusedNames ProhibitPackageVars)  # USER DEFAULT 8: allow additional packages

# [[[ OO PROPERTIES ]]]

our hashref $properties = { bax => my integer $TYPED_bax = 123 };  # NEED FIX: bax should be readonly, need to change into a constant???

# [[[ SUBROUTINES & OO METHODS ]]]

sub triple_bax_save {
    { my void::method $RETURN_TYPE };
    ( my MySubclass02LowRPerlNew $self ) = @ARG;
    $self->{bax} = $self->{bax} * 3;
}

sub triple_bax_return {
    { my integer::method $RETURN_TYPE };
    ( my MySubclass02LowRPerlNew $self ) = @ARG;
    return $self->{bax} * 3;
}

sub add_bax_return {
    { my integer::method $RETURN_TYPE };
    ( my MySubclass02LowRPerlNew $self, my integer $addend ) = @ARG;

    if ( $addend < 10 ) {
        return $self->{bax} + $addend;
    }
    return $self->{bax} + 3;
}

sub subtract_bax_return {
    { my integer::method $RETURN_TYPE };
    ( my MySubclass02LowRPerlNew $self, my integer $subtrahend ) = @ARG;

    if ( $subtrahend < 10 ) {
        return $self->{bax} - $subtrahend;
    }
    return $self->{bax} - 3;
}

sub multiply_bax_return {
    { my integer::method $RETURN_TYPE };
    ( my MySubclass02LowRPerlNew $self, my integer $multiplier ) = @ARG;

    if ( $multiplier < 10 ) {
        return $self->{bax} * $multiplier;
    }
    return $self->{bax} * 3;
}

sub multiply_multiply_bax_return {
    { my integer::method $RETURN_TYPE };
    ( my MySubclass02LowRPerlNew $self, my integer $multiplier, my integer $multiplier2 ) = @ARG;

    if ( $multiplier < 10 ) {
        return $self->{bax} * $multiplier * $multiplier2;
    }
    return $self->{bax} * 3 * $multiplier2;
}

1;    # end of subclass

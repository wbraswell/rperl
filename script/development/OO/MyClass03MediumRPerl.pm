# [[[ HEADER ]]]
use RPerl;
package MyClass03MediumRPerl;
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
    ( my MyClass03MediumRPerl $self ) = @ARG;  # single argument in, multiple argument English syntax
    $self->{bar} = $self->{bar} * 2;
}

sub double_bar_return {
    { my integer::method $RETURN_TYPE };
    my MyClass03MediumRPerl $self = shift @ARG;  # single argument in, single argument English syntax
    return $self->{bar} * 2;
}

1;    # end of class


# [[[ HEADER ]]]
use RPerl;
package MySubclass03MediumRPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(MyClass03MediumRPerl);
use MyClass03MediumRPerl;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitMultiplePackages ProhibitReusedNames ProhibitPackageVars)  # USER DEFAULT 8: allow additional packages

# [[[ OO PROPERTIES ]]]

our hashref $properties = { bax => my integer $TYPED_bax = 123 };  # NEED FIX: bax should be readonly, need to change into a constant???

# [[[ SUBROUTINES & OO METHODS ]]]

sub triple_bax_save {
    { my void::method $RETURN_TYPE };
    my MySubclass03MediumRPerl $self = shift @_;  # single argument in, single argument punctuation syntax
    $self->{bax} = $self->{bax} * 3;
}

sub triple_bax_return {
    { my integer::method $RETURN_TYPE };
    my MySubclass03MediumRPerl $self = shift;  # single argument in, single argument hidden syntax
    return $self->{bax} * 3;
}

sub add_bax_return {
    { my integer::method $RETURN_TYPE };
    ( my MySubclass03MediumRPerl $self, my integer $addend ) = @ARG;  # multiple arguments in, multiple argument English syntax

    if ( $addend < 10 ) {
        return $self->{bax} + $addend;
    }
    return $self->{bax} + 3;
}

sub subtract_bax_return {
    { my integer::method $RETURN_TYPE };
    ( my MySubclass03MediumRPerl $self, my integer $subtrahend ) = @_;  # multiple arguments in, multiple argument punctuation syntax

    if ( $subtrahend < 10 ) {
        return $self->{bax} - $subtrahend;
    }
    return $self->{bax} - 3;
}

sub multiply_bax_return {
    { my integer::method $RETURN_TYPE };
    my MySubclass03MediumRPerl $self = shift @ARG;  # multiple arguments in, single argument English syntax
    my integer $multiplier = shift @_;  # multiple arguments in, single argument punctuation syntax

    if ( $multiplier < 10 ) {
        return $self->{bax} * $multiplier;
    }
    return $self->{bax} * 3;
}

sub multiply_multiply_bax_return {
    { my integer::method $RETURN_TYPE };
    my MySubclass03MediumRPerl $self = shift @ARG;  # multiple arguments in, single argument English syntax
    my integer $multiplier = shift @_;  # multiple arguments in, single argument punctuation syntax
    my integer $multiplier2 = shift;  # multiple arguments in, single argument hidden syntax

    if ( $multiplier < 10 ) {
        return $self->{bax} * $multiplier * $multiplier2;
    }
    return $self->{bax} * 3 * $multiplier2;
}

1;    # end of subclass

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::Subroutines::ProtectPrivateSubs' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Reserved::Class_01_Bad_02;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitUnusedPrivateSubroutines)  # DEVELOPER DEFAULT 3: allow uncalled subroutines

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    _foo_property => my string $TYPED__foo_property = 'quite a prize'
};


# [[[ SUBROUTINES & OO METHODS ]]]

sub _foo_subroutine {
    { my integer $RETURN_TYPE };
    ( my integer $foo_argument ) = @ARG;

    print 'in RPerl::Test::Reserved::Class_01_Bad_02::_foo_subroutine(), received $foo_argument = ', $foo_argument, "\n";

    return ($foo_argument * 2);
}

sub bar_subroutine {
    { my integer $RETURN_TYPE };
    ( my integer $bar_argument ) = @ARG;

    print 'in RPerl::Test::Reserved::Class_01_Bad_02::bar_subroutine(), received $bar_argument = ', $bar_argument, "\n";

#    my integer $foo_retval = _foo_subroutine($bar_argument);
    my integer $foo_retval = RPerl::Test::Reserved::Class_01_Bad_02::_foo_subroutine($bar_argument);
    print 'in RPerl::Test::Reserved::Class_01_Bad_02::bar_subroutine(), have $foo_retval = ', $foo_retval, "\n";

    return ($foo_retval * 3);
}

sub _foo_method {
    { my integer::method $RETURN_TYPE };
    ( my RPerl::Test::Reserved::Class_01_Bad_02 $self, my integer $foo_argument ) = @ARG;

    print 'in RPerl::Test::Reserved::Class_01_Bad_02::_foo_subroutine(), received $foo_argument = ', $foo_argument, "\n";
    print 'in RPerl::Test::Reserved::Class_01_Bad_02::_foo_subroutine(), have $self->{_foo_property} = ', q{'}, $self->{_foo_property}, q{'}, "\n";

    return ($foo_argument * -2);
}

1;    # end of class

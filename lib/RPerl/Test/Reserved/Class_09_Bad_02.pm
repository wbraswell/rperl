# [[[ PREPROCESSOR ]]]

# <<< GENERATE_ERROR: 'P189c, CODE GENERATOR, ABSTRACT SYNTAX' >>>
# <<< GENERATE_ERROR: "class property name 'foo__property()' must not include a double-underscore, forbidden by C++ specification as a reserved identifier" >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Reserved::Class_09_Bad_02;
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
    foo__property => my string $TYPED_foo__property = 'quite a prize'
};


# [[[ SUBROUTINES & OO METHODS ]]]

sub _foo_subroutine {
    { my integer $RETURN_TYPE };
    ( my integer $_foo_argument ) = @ARG;

    print 'in RPerl::Test::Reserved::Class_09_Bad_02::_foo_subroutine(), received $_foo_argument = ', $_foo_argument, "\n";

    return ($_foo_argument * 2);
}


sub _foo_method {
    { my integer::method $RETURN_TYPE };
    ( my RPerl::Test::Reserved::Class_09_Bad_02 $self, my integer $_foo_argument ) = @ARG;

    print 'in RPerl::Test::Reserved::Class_09_Bad_02::_foo_method(), received $_foo_argument = ', $_foo_argument, "\n";
    print 'in RPerl::Test::Reserved::Class_09_Bad_02::_foo_method(), have $self->{foo__property} = ', q{'}, $self->{foo__property}, q{'}, "\n";

    return ($_foo_argument * -2);
}

1;    # end of class

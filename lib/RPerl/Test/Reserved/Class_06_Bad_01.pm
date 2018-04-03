# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: "P186c, CODE GENERATOR, ABSTRACT SYNTAX TO" >>>
# <<< GENERATE_ERROR: "method name 'foo__method()' must not include a double-underscore, forbidden by C++ specification as a reserved identifier" >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Reserved::Class_06_Bad_01;
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
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case & mixed-case package names

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    foo_property => my string $TYPED_foo_property = 'quite a prize'
};


# [[[ SUBROUTINES & OO METHODS ]]]

sub _foo_subroutine {
    { my integer $RETURN_TYPE };
    ( my integer $foo_argument ) = @ARG;

    print 'in RPerl::Test::Reserved::Class_06_Bad_01::_foo_subroutine(), received $foo_argument = ', $foo_argument, "\n";

    return ($foo_argument * 2);
}


sub foo__method {
    { my integer::method $RETURN_TYPE };
    ( my RPerl::Test::Reserved::Class_06_Bad_01 $self, my integer $foo_argument ) = @ARG;

    print 'in RPerl::Test::Reserved::Class_06_Bad_01::foo__method(), received $foo_argument = ', $foo_argument, "\n";
    print 'in RPerl::Test::Reserved::Class_06_Bad_01::foo__method(), have $self->{foo_property} = ', q{'}, $self->{foo_property}, q{'}, "\n";

    return ($foo_argument * -2);
}

1;    # end of class

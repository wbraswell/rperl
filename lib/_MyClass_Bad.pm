# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: 'P184a, CODE GENERATOR, ABSTRACT SYNTAX TO' >>>
# <<< GENERATE_ERROR: "package or class name '_MyClass_Bad' must not start with an underscore, forbidden by C++ specification as a reserved identifier, dying" >>>

# [[[ HEADER ]]]
use RPerl;
package _MyClass_Bad;
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
    foo_property => my string $TYPED_foo_property = 'quite a prize'
};


# [[[ SUBROUTINES & OO METHODS ]]]

sub foo_subroutine {
    { my integer $RETURN_TYPE };
    ( my integer $foo_argument ) = @ARG;

    print 'in _MyClass_Bad::foo_subroutine(), received $foo_argument = ', $foo_argument, "\n";

    my string $foo_variable = 'the prodigal son';

    print 'in _MyClass_Bad::foo_subroutine(), have $foo_variable = ', $foo_variable, "\n";

    return ($foo_argument * 2);
}


sub foo_method {
    { my integer::method $RETURN_TYPE };
    ( my _MyClass_Bad $self, my integer $foo_argument ) = @ARG;

    print 'in _MyClass_Bad::foo_method(), received $foo_argument = ', $foo_argument, "\n";
    print 'in _MyClass_Bad::foo_method(), have $self->{foo_property} = ', q{'}, $self->{foo_property}, q{'}, "\n";

    return ($foo_argument * -2);
}

1;    # end of class

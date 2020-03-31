# [[[ HEADER ]]]
use RPerl;
# hide from PAUSE indexing; comment must not be on 'package' line below due to Perl::Tidy format mismatch
package
    MyClass_Good;
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

    print 'in MyClass_Good::foo_subroutine(), received $foo_argument = ', $foo_argument, "\n";

    my string $foo_variable = 'the prodigal son';

    print 'in MyClass_Good::foo_subroutine(), have $foo_variable = ', $foo_variable, "\n";

    return($foo_argument * 2);
}


sub foo_method {
    { my integer::method $RETURN_TYPE };
    ( my MyClass_Good $self, my integer $foo_argument ) = @ARG;

    print 'in MyClass_Good::foo_method(), received $foo_argument = ', $foo_argument, "\n";
    print 'in MyClass_Good::foo_method(), have $self->{foo_property} = ', q{'}, $self->{foo_property}, q{'}, "\n";

    return ($foo_argument * -2);
}

1;    # end of class

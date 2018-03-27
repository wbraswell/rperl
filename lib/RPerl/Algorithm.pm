# [[[ HEADER ]]]
package RPerl::Algorithm;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.011_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case & mixed-case package names

# [[[ CONSTANTS ]]]
use constant TIME_BEST    => my string $TYPED_TIME_BEST    = '<<< UNKNOWN >>>';
use constant TIME_AVERAGE => my string $TYPED_TIME_AVERAGE = '<<< UNKNOWN >>>';
use constant TIME_WORST   => my string $TYPED_TIME_WORST   = '<<< UNKNOWN >>>';
use constant SPACE_WORST  => my string $TYPED_SPACE_WORST  = '<<< UNKNOWN >>>';

# [[[ OO PROPERTIES ]]]
our hashref $properties = { foo => my string $TYPED_foo = '<<< DEFAULT, ALGORITHM >>>' };

# [[[ SUBROUTINES & OO METHODS ]]]

# [ INHERITANCE TESTING ]

sub inherited__Algorithm {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Algorithm $self, my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', FNORD' . "\n" );
    return;
}

sub inherited__Algorithm_foo_get {
    { my string::method $RETURN_TYPE };
    ( my RPerl::Algorithm $self ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm_foo_get(), have ::class($self) = ' . ::class($self) . ', FNORD' . "\n" );
    return $self->{foo};
}

sub inherited__Algorithm_foo_set {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Algorithm $self, my string $foo_new ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm_foo_set(), have ::class($self) = ' . ::class($self) . ' and $foo_new = ' . $foo_new . ', FNORD' . "\n" );
    $self->{foo} = $foo_new;
    return;
}

#sub inherited {
#    { my void::method $RETURN_TYPE };
#    ( my RPerl::Algorithm $self, my string $person ) = @ARG;
#    RPerl::diag('in PERLOPS_PERLTYPES Algorithm->inherited(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', IS' . "\n");
#    return;
#}

sub uninherited__Algorithm {
    { my string $RETURN_TYPE };
    ( my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm::uninherited__Algorithm(), received $person = ' . $person . ', MYSTIC' . "\n" );
    return 'Algorithm::uninherited__Algorithm() RULES! PERLOPS_PERLTYPES';
}

#sub uninherited {
#    { my string $RETURN_TYPE };
#    ( my string $person ) = @ARG;
#    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm::uninherited(), received $person = ' . $person . ', TERRITORY' . "\n" );
#    return 'Algorithm::uninherited() ROCKS! PERLOPS_PERLTYPES';
#}

1;    # end of class

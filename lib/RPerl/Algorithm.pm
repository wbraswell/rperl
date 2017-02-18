# [[[ HEADER ]]]
package RPerl::Algorithm;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.010_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant TIME_BEST    => my string $TYPED_TIME_BEST    = '<<< UNKNOWN >>>';
use constant TIME_AVERAGE => my string $TYPED_TIME_AVERAGE = '<<< UNKNOWN >>>';
use constant TIME_WORST   => my string $TYPED_TIME_WORST   = '<<< UNKNOWN >>>';
use constant SPACE_WORST  => my string $TYPED_SPACE_WORST  = '<<< UNKNOWN >>>';

# [[[ OO PROPERTIES ]]]
our hashref $properties = { foo => my string $TYPED_foo = '<<< DEFAULT, ALGORITHM >>>' };

# [[[ SUBROUTINES & OO METHODS ]]]

# [ INHERITANCE TESTING ]

our void::method $inherited__Algorithm = sub {
    ( my RPerl::Algorithm $self, my string $person ) = @ARG;
    RPerl::diag(
        'in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', FNORD' . "\n" );
};

our string::method $inherited__Algorithm_foo_get = sub {
    ( my RPerl::Algorithm $self ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm_foo_get(), have ::class($self) = ' . ::class($self) . ', FNORD' . "\n" );
    return $self->{foo};
};

our void::method $inherited__Algorithm_foo_set = sub {
    ( my RPerl::Algorithm $self, my string $foo_new ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm_foo_set(), have ::class($self) = ' . ::class($self) . ' and $foo_new = ' . $foo_new . ', FNORD' . "\n" );
    $self->{foo} = $foo_new;
};

#our void::method $inherited = sub {
#    ( my RPerl::Algorithm $self, my string $person ) = @ARG;
#    RPerl::diag('in PERLOPS_PERLTYPES Algorithm->inherited(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', IS' . "\n");
#};

our string $uninherited__Algorithm = sub {
    ( my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm::uninherited__Algorithm(), received $person = ' . $person . ', MYSTIC' . "\n" );
    return 'Algorithm::uninherited__Algorithm() RULES! PERLOPS_PERLTYPES';
};

#our string $uninherited = sub {
#    ( my string $person ) = @ARG;
#    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm::uninherited(), received $person = ' . $person . ', TERRITORY' . "\n" );
#    return 'Algorithm::uninherited() ROCKS! PERLOPS_PERLTYPES';
#};

1;    # end of class

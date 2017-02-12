# [[[ HEADER ]]]
package RPerl::Algorithm;
use strict;
use warnings;
#use RPerl::AfterSubclass;  # NEED REMOVE???
use RPerl;
our $VERSION = 0.006_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = { complexity => my string $TYPED_complexity = undef };

# [[[ SUBROUTINES & OO METHODS ]]]

# [ INHERITANCE TESTING ]

our void::method $inherited__Algorithm = sub {
    ( my RPerl::Algorithm $self, my string $person ) = @ARG;
    RPerl::diag(
        'in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', FNORD' . "\n" );
};

our void::method $inherited__Algorithm_complexity_modify = sub {
    ( my RPerl::Algorithm $self, my string $complexity_new ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm_complexity_modify(), have ::class($self) = ' . ::class($self) . ' and $complexity_new = ' . $complexity_new . ', FNORD' . "\n" );
    $self->{complexity} = $complexity_new;
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

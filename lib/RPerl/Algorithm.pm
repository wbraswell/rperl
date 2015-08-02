# [[[ HEADER ]]]
package RPerl::Algorithm;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.005_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);  # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our void::method $inherited__Algorithm = sub {
    ( my RPerl::Algorithm $self, my string $person) = @_;
    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', FNORD' . "\n" );
};

#our void::method $inherited = sub {
#    ( my RPerl::Algorithm $self, my string $person) = @_;
#    RPerl::diag('in PERLOPS_PERLTYPES Algorithm->inherited(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', IS' . "\n");
#};

our string $uninherited__Algorithm = sub {
    ( my string $person) = @_;
    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm::uninherited__Algorithm(), received $person = ' . $person . ', MYSTIC' . "\n" );
    return 'Algorithm::uninherited__Algorithm() RULES! PERLOPS_PERLTYPES';
};

#our string $uninherited = sub {
#    ( my string $person) = @_;
#    RPerl::diag( 'in PERLOPS_PERLTYPES Algorithm::uninherited(), received $person = ' . $person . ', TERRITORY' . "\n" );
#    return 'Algorithm::uninherited() ROCKS! PERLOPS_PERLTYPES';
#};

1;    # end of class

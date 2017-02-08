# [[[ HEADER ]]]
package RPerl::Algorithm::Inefficient;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.008_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Algorithm);
use RPerl::Algorithm;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = { usefulness => my string $TYPED_usefulness = undef };

# [[[ SUBROUTINES & OO METHODS ]]]

our void::method $inherited__Inefficient = sub {
    ( my RPerl::Algorithm::Inefficient $self, my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', FLUFFY' . "\n" );
};

our void::method $inherited__Inefficient_usefulness_modify = sub {
    ( my RPerl::Algorithm::Inefficient $self, my string $usefulness_new ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient_usefulness_modify(), have ::class($self) = ' . ::class($self) . ' and $usefulness_new = ' . $usefulness_new . ', FLUFFY' . "\n" );
    $self->{usefulness} = $usefulness_new;
};

our void::method $inherited__Inefficient_complexity_modify = sub {
    ( my RPerl::Algorithm::Inefficient $self, my string $complexity_new ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient_complexity_modify(), have ::class($self) = ' . ::class($self) . ' and $complexity_new = ' . $complexity_new . ', FLUFFY' . "\n" );
    $self->{complexity} = $complexity_new;
};

our void::method $inherited = sub {
    ( my RPerl::Algorithm::Inefficient $self, my string $person ) = @ARG;
    RPerl::diag('in PERLOPS_PERLTYPES Inefficient->inherited(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', INCOMPATIBLE' . "\n");
};

# all of the following happen before the INIT block, and thus rely upon AUTOLOAD
#RPerl::diag("WAZZUP FROM Inefficient.pm\n");
#inherited('FAKESELF', "Spidey");
#RPerl::Algorithm::Inefficient::inherited("FAKECLASS", "Peter Parker");
#RPerl::Algorithm::Inefficient->inherited("Mary Jane");

# pre-INIT AUTOLOAD resolution below only works with Perl, not Inline::CPP
#uninherited('Doc Oc');
#RPerl::Algorithm::Inefficient::uninherited("Doctor Octavius");
#RPerl::Algorithm::Inefficient->uninherited("Mad Scientist");  # ignores "Mad Scientist"
#RPerl::diag("LATERZ FROM Inefficient.pm\n");

our string $uninherited__Inefficient = sub {
    ( my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Inefficient::uninherited__Inefficient(), received $person = ' . $person . ', MESSY' . "\n" );
    return 'Inefficient::uninherited__Inefficient() RULES! PERLOPS_PERLTYPES';
};

# DEV NOTE, CORRELATION #rp004: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
#our string $uninherited = sub {
#    ( my string $person ) = @ARG;
#    RPerl::diag('in PERLOPS_PERLTYPES Inefficient::uninherited(), received $person = ' . $person . ', TRICKS' . "\n");
#    return 'Inefficient::uninherited() ROCKS! PERLOPS_PERLTYPES';
#};

1;    # end of class

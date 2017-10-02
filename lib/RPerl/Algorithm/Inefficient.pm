# [[[ HEADER ]]]
package RPerl::Algorithm::Inefficient;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.012_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Algorithm);
use RPerl::Algorithm;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant USEFULNESS => my string $TYPED_USEFULNESS = '<<< UNKNOWN >>>';

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    bar => my string $TYPED_bar = '<<< DEFAULT, INEFFICIENT >>>'
};

# [[[ SUBROUTINES & OO METHODS ]]]

# [ INHERITANCE TESTING ]

sub inherited__Inefficient {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Inefficient $self, my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', FLUFFY' . "\n" );
    return;
}

sub inherited__Inefficient_bar_get {
    { my string::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Inefficient $self ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient_bar_get(), have ::class($self) = ' . ::class($self) . ', FLUFFY' . "\n" );
    return $self->{bar};
}

sub inherited__Inefficient_bar_set {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Inefficient $self, my string $bar_new ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient_bar_set(), have ::class($self) = ' . ::class($self) . ' and $bar_new = ' . $bar_new . ', FLUFFY' . "\n" );
    $self->{bar} = $bar_new;
    return;
}

sub inherited__Inefficient_foo_get {
    { my string::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Inefficient $self ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient_foo_get(), have ::class($self) = ' . ::class($self) . ', FLUFFY' . "\n" );
    return $self->{foo};
}

sub inherited__Inefficient_foo_set {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Inefficient $self, my string $foo_new ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Inefficient->inherited__Inefficient_foo_set(), have ::class($self) = ' . ::class($self) . ' and $foo_new = ' . $foo_new . ', FLUFFY' . "\n" );
    $self->{foo} = $foo_new;
    return;
}

sub inherited {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Inefficient $self, my string $person ) = @ARG;
    RPerl::diag('in PERLOPS_PERLTYPES Inefficient->inherited(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', INCOMPATIBLE' . "\n");
    return;
}

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

sub uninherited__Inefficient {
    { my string $RETURN_TYPE };
    ( my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Inefficient::uninherited__Inefficient(), received $person = ' . $person . ', MESSY' . "\n" );
    return 'Inefficient::uninherited__Inefficient() RULES! PERLOPS_PERLTYPES';
}

# DEV NOTE, CORRELATION #rp004: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
#sub uninherited {
#    { my string $RETURN_TYPE };
#    ( my string $person ) = @ARG;
#    RPerl::diag('in PERLOPS_PERLTYPES Inefficient::uninherited(), received $person = ' . $person . ', TRICKS' . "\n");
#    return 'Inefficient::uninherited() ROCKS! PERLOPS_PERLTYPES';
#}

1;    # end of class

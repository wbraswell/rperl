# [[[ HEADER ]]]
package RPerl::Algorithm::Sort;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.010_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Algorithm);
use RPerl::Algorithm;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

# [ INHERITANCE TESTING ]

our void::method $inherited__Sort = sub {
    ( my RPerl::Algorithm::Sort $self, my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Sort->inherited__Sort(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', FISH' . "\n" );
};

our string::method $inherited__Sort_foo_get = sub {
    ( my RPerl::Algorithm::Sort $self ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Sort->inherited__Sort_foo_get(), have ::class($self) = ' . ::class($self) . ', FISH' . "\n" );
    return $self->{foo};
};

our void::method $inherited__Sort_foo_set = sub {
    ( my RPerl::Algorithm::Sort $self, my string $foo_new ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Sort->inherited__Sort_foo_set(), have ::class($self) = ' . ::class($self) . ' and $foo_new = ' . $foo_new . ', FISH' . "\n" );
    $self->{foo} = $foo_new;
};

#our void::method $inherited = sub {
#    ( my RPerl::Algorithm::Sort $self, my string $person) = @ARG;
#    RPerl::diag( 'in PERLOPS_PERLTYPES Sort->inherited(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', IN' . "\n" );
#};

our string $uninherited__Sort = sub {
    ( my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Sort::uninherited__Sort(), received $person = ' . $person . ', MY' . "\n" );
    return 'Sort::uninherited__Sort() RULES! PERLOPS_PERLTYPES';
};

#our string $uninherited = sub {
#    ( my string $person ) = @ARG;
#    RPerl::diag('in PERLOPS_PERLTYPES Sort::uninherited(), received $person = ' . $person . ', TROUSERS' . "\n");
#    return 'Sort::uninherited() ROCKS! PERLOPS_PERLTYPES';
#};

1;    # end of class

# DISABLED
# all of the following happen before the INIT block, and thus rely upon AUTOLOAD
#RPerl::diag("WAZZUP FROM Sort.pm\n");
#inherited('FAKESELF', "Spidey");
#RPerl::Algorithm::Sort::inherited("FAKECLASS", "Peter Parker");
#RPerl::Algorithm::Sort->inherited("Mary Jane");

# pre-INIT AUTOLOAD resolution below only works with Perl, not Inline::CPP
#uninherited('Doc Oc');
#RPerl::Algorithm::Sort::uninherited("Doctor Octavius");
#RPerl::Algorithm::Sort->uninherited("Mad Scientist");  # ignores "Mad Scientist"
#RPerl::diag("LATERZ FROM Sort.pm\n");

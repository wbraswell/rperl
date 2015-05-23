# [[[ HEADER ]]]
package RPerl::Algorithm::Sort;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.004_030;

# [[[ CRITICS, OO INHERITANCE, INCLUDES ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
use parent ('RPerl::Algorithm');
use RPerl::Algorithm;

# [[[ OO METHODS & SUBROUTINES ]]]

# OO INHERITANCE TESTING
our void_method $inherited__Sort = sub {
    ( my object $self, my string $person) = @_;
#    RPerl::diag "in PERLOPS_PERLTYPES Sort->inherited__Sort(), received \$self = '$self' and \$person = '$person', FISH\n";
};

#our void_method $inherited = sub { (my object $self, my string $person) = @_;  RPerl::diag "in PERLOPS_PERLTYPES Sort->inherited(), received \$self = '$self' and \$person = '$person', IN\n"; };

# [[[ SUBROUTINES ]]]

# OO INHERITANCE TESTING, CONTINUED
our string $uninherited__Sort = sub {
    ( my string $person) = @_;
#    RPerl::diag "in PERLOPS_PERLTYPES Sort::uninherited__Sort(), received \$person = '$person', MY\n";
    return "Sort::uninherited__Sort() RULES! PERLOPS_PERLTYPES";
};

#our string $uninherited = sub { (my string $person) = @_;  RPerl::diag "in PERLOPS_PERLTYPES Sort::uninherited(), received \$person = '$person', TROUSERS\n";  return "Sort::uninherited() ROCKS! PERLOPS_PERLTYPES"; };

1;    # end of class

__END__
# all of the following happen before the INIT block, and thus rely upon AUTOLOAD
RPerl::diag "WAZZUP FROM Sort.pm\n";
inherited('FAKESELF', "Spidey");
RPerl::Algorithm::Sort::inherited("FAKECLASS", "Peter Parker");
RPerl::Algorithm::Sort->inherited("Mary Jane");

# pre-INIT AUTOLOAD resolution below only works with Perl, not Inline::CPP
uninherited('Doc Oc');
RPerl::Algorithm::Sort::uninherited("Doctor Octavius");
RPerl::Algorithm::Sort->uninherited("Mad Scientist");  # ignores "Mad Scientist"
RPerl::diag "LATERZ FROM Sort.pm\n";

# [[[ HEADER ]]]
package RPerl::Algorithm::Sort;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.004_011;

# [[[ CRITICS, OO INHERITANCE, INCLUDES ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator
use parent ('RPerl::Algorithm');
use RPerl::Algorithm;




# [[[ OO METHODS ]]]


# OO INHERITANCE TESTING


1, 1;    # CODE SEPARATOR: methods above, subroutines below

# [[[ SUBROUTINES ]]]


# OO INHERITANCE TESTING, CONTINUED


# <<< OPERATIONS & DATA TYPES REPORTING >>>
our integer $RPerl__Algorithm__Sort__OPS_TYPES_ID
    = sub { return 0; };    # PERLOPS_PERLTYPES is 0
our string $RPerl__Algorithm__Sort__ops   = sub { return 'PERL'; };
our string $RPerl__Algorithm__Sort__types = sub { return 'PERL'; };

1, 1;                          # CODE SEPARATOR: end of class












# [[[ INHERITANCE TESTING ]]]
our void__method $inherited__Sort = sub { (my object $self, my string $person) = @_;  RPerl::diag "in Perl Sort->inherited__Sort(), have \$self = '$self' and \$person = '$person', FISH\n"; };
#our void__method $inherited = sub { (my object $self, my string $person) = @_;  RPerl::diag "in Perl Sort->inherited(), have \$self = '$self' and \$person = '$person', IN\n"; };
our string $uninherited__Sort = sub { (my string $person) = @_;  RPerl::diag "in Perl Sort::uninherited__Sort(), \$person = '$person', MY\n";  return "Perl Sort::uninherited__Sort() RULES!"; };
#our string $uninherited = sub { (my string $person) = @_;  RPerl::diag "in Perl Sort::uninherited(), \$person = '$person', TROUSERS\n";  return "Perl Sort::uninherited() ROCKS!"; };


# all of the following happen before the INIT block, and thus rely upon AUTOLOAD
=SNIP
RPerl::diag "WAZZUP FROM Sort.pm\n";
inherited('FAKESELF', "Spidey");
RPerl::Algorithm::Sort::inherited("FAKECLASS", "Peter Parker");
RPerl::Algorithm::Sort->inherited("Mary Jane");
=cut

# pre-INIT AUTOLOAD resolution below only works with Perl, not Inline::CPP
=SNIP
uninherited('Doc Oc');
RPerl::Algorithm::Sort::uninherited("Doctor Octavius");
RPerl::Algorithm::Sort->uninherited("Mad Scientist");  # ignores "Mad Scientist"
RPerl::diag "LATERZ FROM Sort.pm\n";
=cut
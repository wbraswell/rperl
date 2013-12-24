use strict;  use warnings;
package RPerl::Algorithm::Sort;

use parent ('RPerl::Algorithm');
use RPerl::Algorithm;

# [[[ INHERITANCE TESTING ]]]
our void__method $inherited__Sort = sub { (my object $self, my string $person) = @_;  print STDERR "in Perl Sort->inherited__Sort(), have \$self = '$self' and \$person = '$person', FISH\n"; };
#our void__method $inherited = sub { (my object $self, my string $person) = @_;  print STDERR "in Perl Sort->inherited(), have \$self = '$self' and \$person = '$person', IN\n"; };
our string $uninherited__Sort = sub { (my string $person) = @_;  print STDERR "in Perl Sort::uninherited__Sort(), \$person = '$person', MY\n";  return "Perl Sort::uninherited__Sort() RULES!"; };
#our string $uninherited = sub { (my string $person) = @_;  print STDERR "in Perl Sort::uninherited(), \$person = '$person', TROUSERS\n";  return "Perl Sort::uninherited() ROCKS!"; };


# all of the following happen before the INIT block, and thus rely upon AUTOLOAD
=SNIP
print STDERR "WAZZUP FROM Sort.pm\n";
inherited('FAKESELF', "Spidey");
RPerl::Algorithm::Sort::inherited("FAKECLASS", "Peter Parker");
RPerl::Algorithm::Sort->inherited("Mary Jane");
=cut

# pre-INIT AUTOLOAD resolution below only works with Perl, not Inline::CPP
=SNIP
uninherited('Doc Oc');
RPerl::Algorithm::Sort::uninherited("Doctor Octavius");
RPerl::Algorithm::Sort->uninherited("Mad Scientist");  # ignores "Mad Scientist"
print STDERR "LATERZ FROM Sort.pm\n";
=cut
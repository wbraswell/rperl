use strict;  use warnings;
package RPerl::Algorithm::Inefficient;

our @ISA = ('RPerl::Algorithm');
use RPerl::Algorithm;

# [[[ INHERITANCE TESTING ]]]
our void__method $inherited__Inefficient = sub { (my object $self, my string $person) = @_;  print STDERR "in Perl Inefficient->inherited__Inefficient(), have \$self = '$self' and \$person = '$person', FLUFFY\n"; };
our void__method $inherited = sub { (my object $self, my string $person) = @_;  print STDERR "in Perl Inefficient->inherited(), have \$self = '$self' and \$person = '$person', INCOMPATIBLE\n"; };
our string $uninherited__Inefficient = sub { (my string $person) = @_;  print STDERR "in Perl Inefficient::uninherited__Inefficient(), \$person = '$person', MESSY\n";  return "Perl Inefficient::uninherited__Inefficient() RULES!"; };
#our string $uninherited = sub { (my string $person) = @_;  print STDERR "in Perl Inefficient::uninherited(), \$person = '$person', TRICKS\n";  return "Perl Inefficient::uninherited() ROCKS!"; };


# all of the following happen before the INIT block, and thus rely upon AUTOLOAD
=SNIP
print STDERR "WAZZUP FROM Inefficient.pm\n";
inherited('FAKESELF', "Spidey");
RPerl::Algorithm::Inefficient::inherited("FAKECLASS", "Peter Parker");
RPerl::Algorithm::Inefficient->inherited("Mary Jane");
=cut

# pre-INIT AUTOLOAD resolution below only works with Perl, not Inline::CPP
=SNIP
uninherited('Doc Oc');
RPerl::Algorithm::Inefficient::uninherited("Doctor Octavius");
RPerl::Algorithm::Inefficient->uninherited("Mad Scientist");  # ignores "Mad Scientist"
print STDERR "LATERZ FROM Inefficient.pm\n";
=cut
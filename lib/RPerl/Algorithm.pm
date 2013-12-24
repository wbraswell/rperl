use strict;  use warnings;
package RPerl::Algorithm;

# RPerl Base Class
use parent ('RPerl::Class');
use RPerl::Class;  use RPerl;

# [[[ INHERITANCE TESTING ]]]
our void__method $inherited__Algorithm = sub { (my object $self, my string $person) = @_;  print STDERR "in Perl Algorithm->inherited__Algorithm(), have \$self = '$self' and \$person = '$person', FNORD\n"; };
#our void__method $inherited = sub { (my object $self, my string $person) = @_;  print STDERR "in Perl Algorithm->inherited(), have \$self = '$self' and \$person = '$person', IS\n"; };
our string $uninherited__Algorithm = sub { (my string $person) = @_;  print STDERR "in Perl Algorithm::uninherited__Algorithm(), \$person = '$person', MYSTIC\n";  return "Perl Algorithm::uninherited__Algorithm() RULES!"; };
#our string $uninherited = sub { (my string $person) = @_;  print STDERR "in Perl Algorithm::uninherited(), \$person = '$person', TERRITORY\n";  return "Perl Algorithm::uninherited() ROCKS!"; };

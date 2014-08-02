# [[[ PACKAGE, HEADER ]]]
package RPerl::Algorithm;
use strict;
use warnings;
our $VERSION = 0.000_010;
use Carp;
use RPerl;

# [[[ CRITIC, PARENT INHERITANCE, INCLUDES, CONSTANTS, OO PROPERTIES ]]]
use parent ('RPerl::CompileUnit::Module::Class'); # RPerl::CompileUnit::Module::Class is the base class of all RPerl classes
use RPerl::CompileUnit::Module::Class;

# [[[ OO METHODS ]]]

# INHERITANCE TESTING
our void__method $inherited__Algorithm = sub {
    ( my object $self, my string $person) = @_;
    RPerl::diag
        "in PERLOPS_PERLTYPES Algorithm->inherited__Algorithm(), received \$self = '$self' and \$person = '$person', FNORD\n";
};

our void__method $inherited = sub {
    ( my object $self, my string $person) = @_;
    RPerl::diag
        "in PERLOPS_PERLTYPES Algorithm->inherited(), received \$self = '$self' and \$person = '$person', IS\n";
};

1;
1;    # CODE SEPARATOR: methods above, subroutines below

# [[[ PROCEDURAL SUBROUTINES ]]]

our string $uninherited__Algorithm = sub {
    ( my string $person) = @_;
    RPerl::diag
        "in PERLOPS_PERLTYPES Algorithm::uninherited__Algorithm(), received \$person = '$person', MYSTIC\n";
    return 'Algorithm::uninherited__Algorithm() RULES! PERLOPS_PERLTYPES';
};

#our string $uninherited = sub { ( my string $person) = @_; RPerl::diag "in Perl Algorithm::uninherited(), \$person = '$person', TERRITORY\n"; return "Perl Algorithm::uninherited() ROCKS!"; };

1;
1;    # CODE SEPARATOR: end of package or class

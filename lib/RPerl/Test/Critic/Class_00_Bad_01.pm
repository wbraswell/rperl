# [[[ TEST : 'ERROR ECVPARP00' ]]]
# [[[ TEST : 'unexpected token:  ## no critic qw(' ]]]
# [[[ HEADER ]]]
package RPerl::Test::Critic::Class_00_Bad_01;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    empty_property => my integer $TYPED_empty_property = 2
);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator

# [[[ OO METHODS ]]]
our void__method $empty_method = sub { 2; };

1;                  # end of class

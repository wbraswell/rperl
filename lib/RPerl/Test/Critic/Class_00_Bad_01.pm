# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>
# <<< COMPILE_ERROR: 'Unexpected token:  ## no critic qw(' >>>

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
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 3: allow OO properties
    empty_property => my integer $TYPED_empty_property = 2
);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ OO METHODS ]]]
our void__method $empty_method = sub { return 2; };

1;                  # end of class

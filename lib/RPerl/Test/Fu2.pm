# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Fu2;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)
## no critic qw(RequireInterpolationOfMetachars)
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)

# [[[ OO PROPERTIES ]]]
our hashref $properties = { thud => my integer_arrayref $TYPED_thud = [] };

# [[[ SUBROUTINES & OO METHODS ]]]
our void::method $quux = sub {
    ( my object $self, my integer $howdy, my string_hashref $doody) = @ARG;
    return 2;
};
1;    # end of class

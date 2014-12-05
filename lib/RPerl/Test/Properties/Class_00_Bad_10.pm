# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'Global symbol "$TYPED_empty_property" requires explicit package name' ]]]
# [[[ HEADER ]]]
package RPerl::Test::Properties::Class_00_Bad_10;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    empty_property => integer $TYPED_empty_property = 2
);

# [[[ OO METHODS ]]]
our void__method $empty_method = sub { 2; };

1;                  # end of class

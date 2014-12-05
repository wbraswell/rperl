# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'near "use RPerl::Test,"' ]]]
# [[[ HEADER ]]]
package RPerl::Test::Include::Class_00_Bad_07;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;
use RPerl::Test,:Bar;

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    empty_property => my integer $TYPED_empty_property = 2
);

# [[[ OO METHODS ]]]
our void__method $empty_method = sub { 2; };

1;                  # end of class

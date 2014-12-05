# [[[ TEST : 'ERROR ECVPARP00' ]]]
# [[[ TEST : 'Unexpected token:  us' ]]]
# [[[ HEADER ]]]
package RPerl::Test::Include::Package_00_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
us RPerl::Test::Foo;
use RPerl::Test::Bar;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;                  # end of class

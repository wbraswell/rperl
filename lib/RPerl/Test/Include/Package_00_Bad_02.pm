# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'Can't locate RPerl/Tst/Bar.pm' ]]]
# [[[ HEADER ]]]
package RPerl::Test::Include::Package_00_Bad_02;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;
use RPerl::Tst::Bar;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;                  # end of class

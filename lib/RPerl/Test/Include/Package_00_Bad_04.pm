# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'Can't locate RPerl/T.pm' ]]]
# [[[ HEADER ]]]
package RPerl::Test::Include::Package_00_Bad_04;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::T@est::Foo;
use RPerl::Test::Bar;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;                  # end of class

# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'Can't locate RPerl/T.pm' ]]]
# [[[ HEADER ]]]
package RPerl::Test::Include::Package_00_Bad_05;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;
use RPerl::T&est::Bar;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;                  # end of class
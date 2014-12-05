# [[[ TEST : 'ERROR ECVPARP00' ]]]
# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_DoubleQuotes_06_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { "\foo\bar"; };

1;                  # end of class

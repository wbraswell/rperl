# [[[ TEST : 'ERROR ECVPARP00' ]]]
# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_DoubleQuotes_15_Bad_01;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
# DEV NOTE: the rules for sigils inside double quotes are too complicated for now
our void $empty_sub = sub { "@ \@bar \$foo $ \n"; };

1;                  # end of class

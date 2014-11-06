# [[[ TEST : "ERROR ECVPARP00" ]]]
# [[[ HEADER ]]]
package RPerl::Test::DataTypeString::String_DoubleQuotes_15_Bad_01;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
# DEV NOTE: the rules for sigils inside double quotes are too complicated for now
our void $empty_sub = sub { "@ \@bar \$foo $ \n"; };

1;
1;    # CODE SEPARATOR: end of package


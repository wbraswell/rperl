# [[[ TEST : "ERROR ECVPAPL02" ]]]
# [[[ TEST : "Can't modify constant item in predecrement" ]]]
# [[[ HEADER ]]]
package RPerl::Test::DataTypeNumber::Number_00_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { --2; };

1;
1;    # CODE SEPARATOR: end of package

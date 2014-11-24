# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'syntax error' ]]]
foo
# [[[ HEADER ]]]
package RPerl::Test::EmptyModule::Package_00_Bad_PreHeader;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;
1;    # CODE SEPARATOR: end of package


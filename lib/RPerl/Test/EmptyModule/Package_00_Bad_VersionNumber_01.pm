# [[[ TEST : 'ERROR ECVPARP00' ]]]
# [[[ HEADER ]]]
package RPerl::Test::EmptyModule::Package_00_Bad_VersionNumber_01;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.01_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;                  # end of class

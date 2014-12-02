# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'Bareword "b" not allowed' ]]]
# [[[ HEADER ]]]
package RPerl::Test::EmptyModule::Package_00_Bad_Separator_01;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

b;                  # end of class

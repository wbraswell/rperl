# [[[ TEST : 'ERROR ECVPAPC02' ]]]
# [[[ TEST : 'RequireEndWithOne' ]]]
# [[[ HEADER ]]]
package RPerl::Test::Module::Package_00_Bad_Terminator_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

0;                  # end of class

# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'syntax error' ]]]
# [[[ HEADER ]]]
package RPerl::Test::Subroutine::Package_00_Bad_02;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void empty_sub = sub { 2; };

1;                  # end of class

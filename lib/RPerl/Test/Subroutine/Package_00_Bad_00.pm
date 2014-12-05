# [[[ TEST : 'ERROR ECVPAPL02' ]]]
# [[[ TEST : 'Global symbol "$empty_sub" requires explicit package name' ]]]
# [[[ HEADER ]]]
package RPerl::Test::Subroutine::Package_00_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
ou void $empty_sub = sub { 2; };

1;                  # end of class

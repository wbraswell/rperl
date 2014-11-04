# [[[ TEST : "ERROR ECVPAPC02" ]]]
# [[[ TEST : "Perl::Critic::Policy::Modules::RequireEndWithOne" ]]]
# [[[ HEADER ]]]
package RPerl::Test::EmptyModule::Package_00_Bad_Separator_03;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;
1    # CODE SEPARATOR: end of package


# [[[ TEST : "ERROR ECVPAPL02" ]]]
# [[[ TEST : "Perl::Critic::Policy::Miscellanea::RequireRcsKeywords" ]]]
# [[[ HEADER ]]]
package RPerl::Test::EmptyModule::Package_00_Bad_VersionNumber_03;
use strict;
use warnings;
use RPerl;
our $VERSION = 100.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;
1;    # CODE SEPARATOR: end of package


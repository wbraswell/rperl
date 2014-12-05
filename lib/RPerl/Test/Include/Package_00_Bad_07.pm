# [[[ TEST : 'ERROR ECVPAPC02' ]]]
# [[[ TEST : 'Perl::Critic::Policy::Modules::RequireExplicitPackage' ]]]
# [[[ HEADER ]]]
use RPerl::Test::Foo;
package RPerl::Test::Include::Package_00_Bad_07;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Test::Bar;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;                  # end of class

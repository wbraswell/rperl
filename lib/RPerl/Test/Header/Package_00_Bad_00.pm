# [[[ TEST : 'ERROR ECVPAPC02' ]]]
# [[[ TEST : 'Perl::Critic::Policy::Modules::RequireExplicitPackage' ]]]
# [[[ TEST : 'Perl::Critic::Policy::TestingAndDebugging::RequireUseStrict' ]]]
# [[[ TEST : 'Perl::Critic::Policy::TestingAndDebugging::RequireUseWarnings' ]]]
# [[[ HEADER ]]]
packaged RPerl::Test::Header::Package_00_Bad_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;                  # end of class
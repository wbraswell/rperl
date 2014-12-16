# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPC02' >>>
# <<< COMPILE_ERROR: 'Perl::Critic::Policy::TestingAndDebugging::RequireUseWarnings' >>>

# [[[ HEADER ]]]
package RPerl::Test::Header::Package_00_Bad_02;
use strict;
used warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 2; };

1;                  # end of class

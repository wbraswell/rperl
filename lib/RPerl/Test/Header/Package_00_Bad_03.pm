# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPC02' >>>
# <<< PARSE_ERROR: 'Perl::Critic::Policy::Modules::RequireVersionVar' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Header::Package_00_Bad_03;
use strict;
use warnings;
use RPerl
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
sub empty_sub { { my void $RETURN_TYPE }; return 2; }

1;                  # end of package

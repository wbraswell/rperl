# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::LiteralNumber::Package_00_Bad_03;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
sub empty_sub { { my integer $RETURN_TYPE }; return 2.; }

1;                  # end of package

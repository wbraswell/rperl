# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  EMPTY_SUB' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Subroutine::Package_00_Bad_09;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
sub EMPTY_SUB { { my void $RETURN_TYPE }; return 2; }

1;                  # end of package


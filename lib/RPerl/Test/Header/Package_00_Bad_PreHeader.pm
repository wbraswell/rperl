# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: '"use" not allowed in expression' >>>
# <<< PARSE_ERROR: 'syntax error' >>>
# <<< PARSE_ERROR: 'near "foo' >>>

foo
# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Header::Package_00_Bad_PreHeader;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
sub empty_sub { { my void $RETURN_TYPE }; return 2; }

1;                  # end of package

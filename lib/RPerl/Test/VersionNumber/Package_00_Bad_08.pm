# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'syntax error' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::VersionNumber::Package_00_Bad_08;
use strict;
use warnings;
our $VERSION = 0.001_000

# [[[ SUBROUTINES ]]]
sub empty_sub { { my void $RETURN_TYPE };
    return 2;
}

1;                  # end of package

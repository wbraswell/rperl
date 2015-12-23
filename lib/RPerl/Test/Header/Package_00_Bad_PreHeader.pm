# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Unquoted string "foo" may clash with future reserved word' >>>

foo
# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Header::Package_00_Bad_PreHeader;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    return 2;
};

1;                  # end of package

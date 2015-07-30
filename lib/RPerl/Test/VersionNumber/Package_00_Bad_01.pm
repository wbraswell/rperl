# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>

# [[[ HEADER ]]]
package RPerl::Test::VersionNumber::Package_00_Bad_01;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.01_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    return 2;
};

1;                  # end of package

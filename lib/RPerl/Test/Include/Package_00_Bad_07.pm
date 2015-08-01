# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  use' >>>

# [[[ HEADER ]]]
use RPerl::Test::Foo;
package RPerl::Test::Include::Package_00_Bad_07;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Test::Bar;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    return 2;
};

1;                  # end of package

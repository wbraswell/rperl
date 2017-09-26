# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
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
sub empty_sub { { my integer $RETURN_TYPE };
    return 2;
}

1;                  # end of package

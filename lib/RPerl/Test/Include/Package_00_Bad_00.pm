# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  us' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Include::Package_00_Bad_00;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
us RPerl::Test::Foo;
use RPerl::Test::Bar;

# [[[ SUBROUTINES ]]]
sub empty_sub { { my integer $RETURN_TYPE };
    return 2;
}

1;                  # end of package

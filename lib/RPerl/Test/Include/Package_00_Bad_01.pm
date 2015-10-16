# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< PARSE_ERROR: 'near "use RPerl:"' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Include::Package_00_Bad_01;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl:Test::Foo;
use RPerl::Test::Bar;

# [[[ SUBROUTINES ]]]
our integer $empty_sub = sub {
    return 2;
};

1;                  # end of package

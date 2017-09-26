# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Can't locate RPerl/T.pm' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Include::Package_00_Bad_05;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;
use RPerl::T&est::Bar;

# [[[ SUBROUTINES ]]]
sub empty_sub { { my integer $RETURN_TYPE };
    return 2;
}

1;                  # end of package

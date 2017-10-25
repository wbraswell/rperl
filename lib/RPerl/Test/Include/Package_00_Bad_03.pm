# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'near "use RPerl::Test::Bar' >>>
# <<< PARSE_ERROR: 'sub empty_sub "' >>>
# <<< PARSE_ERROR: 'near "; }"' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Include::Package_00_Bad_03;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;
use RPerl::Test::Bar

# [[[ SUBROUTINES ]]]
sub empty_sub { { my integer $RETURN_TYPE }; return 2; }

1;                  # end of package


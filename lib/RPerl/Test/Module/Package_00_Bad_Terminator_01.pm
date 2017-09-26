# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Bareword "b" not allowed' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Module::Package_00_Bad_Terminator_01;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
sub empty_sub { { my void $RETURN_TYPE };
    return 2;
}

b;                  # end of package

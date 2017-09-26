# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Useless use of a constant' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Module::Package_00_Bad_Terminator_02;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
sub empty_sub { { my void $RETURN_TYPE };
    return 2;
}

1 + 1;                  # end of package

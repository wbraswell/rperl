# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPC02' >>>
# <<< PARSE_ERROR: 'RequireEndWithOne' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Module::Package_00_Bad_Terminator_00;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
sub empty_sub { { my void $RETURN_TYPE };
    return 2;
}

0;                  # end of package

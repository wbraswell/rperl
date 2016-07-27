# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  $EMPTY_SUB' >>>
# <<< PARSE_ERROR: 'Expected Token(s): VARIABLE_SYMBOL' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Subroutine::Package_00_Bad_09;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $EMPTY_SUB = sub {
    return 2;
};

1;                  # end of package

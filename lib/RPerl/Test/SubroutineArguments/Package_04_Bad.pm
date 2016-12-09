# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'near "1;' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::SubroutineArguments::Package_04_Bad;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number $foo, y number $bar ) = @ARG;
    return 1;
};

1;    # end of package

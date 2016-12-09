# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'near "my number_hashref foo "' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::SubroutineArguments::Package_03_Bad;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number_hashref foo ) = @ARG;
    return 1;
};

1;    # end of package

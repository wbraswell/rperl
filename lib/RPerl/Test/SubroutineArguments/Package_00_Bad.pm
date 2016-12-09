# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Number found where operator expected' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::SubroutineArguments::Package_00_Bad;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( m number $foo ) = @ARG;
    return 1;
};

1;    # end of package

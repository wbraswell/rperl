# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'near "1;    # end of"' >>>

# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_00_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( m number $foo ) = @_;
    1;
};

1;    # end of package

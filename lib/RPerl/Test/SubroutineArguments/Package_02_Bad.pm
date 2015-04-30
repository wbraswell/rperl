# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'near "( my number__arrayref"' >>>

# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_02_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number__arrayref $foo ) = @_;
    return 1;
};

1;    # end of package

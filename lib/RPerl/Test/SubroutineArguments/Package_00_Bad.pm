# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'syntax error' >>>

# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_00_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( m number $foo ) = @_;
    return 1;
};

1;    # end of package

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'near "my number__hash_ref foo "' >>>

# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_03_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number__hash_ref foo ) = @_;
    1;
};

1;    # end of package

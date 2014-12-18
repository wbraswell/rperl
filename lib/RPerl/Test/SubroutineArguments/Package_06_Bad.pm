# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'near "$bar my number__hash_ref"' >>>

# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_06_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number $foo, my number__array_ref $bar my number__hash_ref $baz ) = @_;
    return 1;
};

1;    # end of package

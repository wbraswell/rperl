# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'Transliteration replacement not terminated' >>>

# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_04_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number $foo, y number $bar ) = @_;
    1;
};

1;    # end of package

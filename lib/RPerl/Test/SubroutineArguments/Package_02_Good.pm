# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_02_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number__array_ref $foo ) = @_;
    1;
};

1;    # end of package

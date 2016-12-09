# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::SubroutineArguments::Package_00_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number $foo ) = @ARG;
    return 1;
};

1;    # end of package

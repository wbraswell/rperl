# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_03_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number_hashref $foo ) = @_;
    return 1;
};

1;    # end of package

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::SubroutineArguments::Package_02_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number_arrayref $foo ) = @_;
    return 1;
};

1;    # end of package

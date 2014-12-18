# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_04_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number $foo, my number $bar ) = @_;
    return 1;
};

1;    # end of package

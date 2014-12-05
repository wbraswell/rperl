# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_06_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number $foo, my number__array_ref $bar, my number__hash_ref $baz ) = @_;
    1;
};

1;    # end of class

# [[[ HEADER ]]]
package RPerl::Test::SubroutineArguments::Package_07_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number $foo, my string $bar, my scalartype__array_ref $baz, my integer__hash_ref $bat ) = @_;
    1;
};

1;    # end of package

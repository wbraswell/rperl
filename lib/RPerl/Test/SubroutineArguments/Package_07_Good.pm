# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::SubroutineArguments::Package_07_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    ( my number $foo, my string $bar, my scalartype_arrayref $baz, my integer_hashref $bat ) = @_;
    return 1;
};

1;    # end of package

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::LiteralString::Package_QQuotes_07_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
sub empty_sub { { my string $RETURN_TYPE }; return q{@ $}; }

1;    # end of package

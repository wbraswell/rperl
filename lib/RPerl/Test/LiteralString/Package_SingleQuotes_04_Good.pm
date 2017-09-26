# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::LiteralString::Package_SingleQuotes_04_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
sub empty_sub { { my string $RETURN_TYPE }; return '"q{foo123}"'; }

1;    # end of package

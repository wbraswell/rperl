# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::LiteralString::Package_SingleQuotes_05_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub { return '\\ foo'; };

1;    # end of package

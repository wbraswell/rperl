# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_SingleQuotes_03_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { 'q{foo123}'; };

1;                  # end of package

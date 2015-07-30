# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_SingleQuotes_05_Good;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub {
    return '\ foo';
};

1;    # end of package

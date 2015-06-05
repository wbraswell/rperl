# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_DoubleQuotes_05_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub {
    return "\nfoo\nbar";
};

1;    # end of package

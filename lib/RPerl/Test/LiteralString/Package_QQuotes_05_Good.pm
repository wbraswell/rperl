# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::LiteralString::Package_QQuotes_05_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub { return q{'foo'\\ t"bar"\\ n}; };

1;    # end of package

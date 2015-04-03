# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_SingleQ_05_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub { return q{'foo'\ t"bar"\ n}; };

1;                  # end of package

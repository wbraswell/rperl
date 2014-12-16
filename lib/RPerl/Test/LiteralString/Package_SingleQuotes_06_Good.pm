# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_SingleQuotes_06_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { '`~!#%^&*()-_=+[]{}\|;:",<.>/?'; };

1;                  # end of package

# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'Global symbol "$bar" requires explicit package name' >>>
# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_DoubleQuotes_02_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { "$bar"; };

1;                  # end of class

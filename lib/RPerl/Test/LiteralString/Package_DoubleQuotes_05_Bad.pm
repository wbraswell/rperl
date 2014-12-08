# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'Global symbol "$foo" requires explicit package name' >>>
# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_DoubleQuotes_05_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub { "\n$foo\nbar"; };

1;                  # end of class

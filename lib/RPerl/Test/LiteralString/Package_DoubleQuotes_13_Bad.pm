# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL02' >>>
# <<< COMPILE_ERROR: 'Global symbol "$bar" requires explicit package name' >>>

# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_DoubleQuotes_13_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub { return "foo\t$bar\t"; };

1;                  # end of package

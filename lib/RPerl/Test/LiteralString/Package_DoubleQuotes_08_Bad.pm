# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPAPL03' >>>
# <<< COMPILE_ERROR: 'Unrecognized escape \m passed through' >>>

# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_DoubleQuotes_08_Bad;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub { return "\m\mfoo\m\mbar\m\m"; };

1;                  # end of package

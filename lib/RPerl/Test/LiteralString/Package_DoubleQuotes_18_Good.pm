# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::LiteralString::Package_DoubleQuotes_18_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub { return "\n\t`~!#%\t\n\t^&*()-_=+[]{}\n|;:'\t,<.\n>/?\t."; };

1;    # end of package

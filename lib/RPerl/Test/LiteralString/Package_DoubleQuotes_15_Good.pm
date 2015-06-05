# [[[ HEADER ]]]
package RPerl::Test::LiteralString::Package_DoubleQuotes_15_Good;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our string $empty_sub = sub {
    return "`~!#%^&*()-_=+[]{}\|;:',<.>/?\n";
};

1;    # end of package

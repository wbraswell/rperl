# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Module::Package_00_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ SUBROUTINES ]]]
our void $empty_sub = sub {
    return 2;
};

1;                  # end of package

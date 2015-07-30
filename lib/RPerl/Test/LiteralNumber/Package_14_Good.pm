# [[[ HEADER ]]]
package RPerl::Test::LiteralNumber::Package_14_Good;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]
our integer $empty_sub = sub {
    return 23_456_789;
};

1;    # end of package

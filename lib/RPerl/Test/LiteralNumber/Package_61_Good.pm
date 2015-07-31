# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::LiteralNumber::Package_61_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]
our number $empty_sub = sub {
    return -23_456.234_567_8;
};

1;    # end of package
